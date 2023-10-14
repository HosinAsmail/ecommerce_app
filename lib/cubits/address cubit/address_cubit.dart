import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart';
import 'package:test/core/api/crud.dart';
import 'package:test/core/functions/check_internet_function.dart';
import 'package:test/core/functions/handling_failure_response.dart';
import 'package:test/core/services/storage%20services/store_all_data.dart';
import 'package:test/data/data%20source/remote/address_remote.dart';
import 'package:test/data/model/address_model.dart';
import 'package:test/data/model/user%20model/user_model.dart';

part 'address_state.dart';

class AddressCubit extends Cubit<AddressState> {
  AddressCubit() : super(AddressInitial());
  Crud crud = Crud();
  UserModel userModel = UserModel.instance;
  StoreAllData storeAllData = StoreAllData();
  List<AddressModel> addresses = [];
  int? selectedLocation;
  getAddress() async {
    try {
      emit(GetAddressLoading());
      if (addresses.isEmpty) {
        List<Map<String, dynamic>> list =
            await storeAllData.readData('address');
        if (list.isEmpty) {
          getAsyncAddress();
        } else {
          for (final address in list) {
            addresses.add(AddressModel.fromJson(address));
          }
          emit(GetAddressSuccess());
        }
      } else {
        emit(GetAddressSuccess());
      }
    } on Exception catch (e) {
      print(e);
      emit(GetAddressFailure(
          errorMessage: "unknown problem : ${e.toString()} "));
    }
  }

  getAsyncAddress() async {
    emit(GetAddressLoading());
    if (await checkInternetFunction()) {
      print('we get data from the internet now=================');
      try {
        AddressRemote addressRemote = AddressRemote(crud);
        var response = await addressRemote.getAddress(userModel.userId);
        if (response is Map<String, dynamic>) {
          addresses.clear();
          await storeAllData.deleteData('address');
          for (final address in response['data']) {
            addresses.add(AddressModel.fromJson(address));
            await storeAllData.insertData('address', address);
          }
        }
        String? failureMessage =
            handlingFailureMessage(response, "no data found");

        if (failureMessage != null) {
          emit(GetAddressFailure(errorMessage: failureMessage));
        } else {
          emit(GetAddressSuccess());
        }
      } on Exception catch (e) {
        print(e);
        if (e is ClientException) {
          emit(const GetAddressFailure(
              errorMessage: "the internet is slow, try again"));
        }
        emit(GetAddressFailure(
            errorMessage: "unknown problem : ${e.toString()} "));
      }
    } else {
      emit(const GetAddressFailure(
          errorMessage: "the internet is slow, try again"));
    }
  }

  Future<void> deleteAddress(AddressModel addressModel) async {
    emit(DeleteAddressLoading());
    if (await checkInternetFunction()) {
      try {
        addresses.remove(addressModel);
        await storeAllData.deleteData("address",
            where: "address_id= '${addressModel.addressId}'");
        emit(DeleteAddressSuccess());
        AddressRemote addressRemote = AddressRemote(crud);
        var response =
            await addressRemote.deleteAddress(addressModel.addressId!);

        String? failureMessage = handlingFailureMessage(response, "no data");
        if (failureMessage != null) {
          emit(DeleteAddressFailure(errorMessage: failureMessage));
        }
      } on Exception catch (e) {
        if (e is ClientException) {
          emit(const DeleteAddressFailure(
              errorMessage: "the internet is slow, try again"));
        }
        emit(DeleteAddressFailure(
            errorMessage: "unknown problem : ${e.toString()} "));
      }
    } else {
      print('=============================');
      emit(const DeleteAddressFailure(
          errorMessage:
              "your offline, please turn on the internet and try again"));
    }
  }

  chooseLocation(int index) {
    selectedLocation = index;
    emit(ChooseAddressLoading());
    emit(ChooseAddressSuccess());
  }
}
