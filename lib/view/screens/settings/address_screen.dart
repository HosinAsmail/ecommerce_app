import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test/core/constant/app_color.dart';
import 'package:test/core/functions/my_snack_bar.dart';
import 'package:test/cubits/address%20cubit/address_cubit.dart';
import 'package:test/data/model/address_model.dart';
import 'package:test/view/widget/settings/address/address_list_tile.dart';

class AddressScreen extends StatelessWidget {
  const AddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AddressCubit addressCubit = context.read<AddressCubit>();
    addressCubit.getAddress();
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                addressCubit.getAsyncAddress();
              },
              icon: const Icon(Icons.refresh))
        ],
        title: const Text('العنوان'),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          addressCubit.getAsyncAddress();
        },
        child: BlocConsumer<AddressCubit, AddressState>(
          listener: (context, state) {
            if (state is GetAddressFailure) {
              mySnackBar(Colors.red, 'failure', state.errorMessage);
            } else if (state is DeleteAddressSuccess) {
              mySnackBar(AppColor.secondaryColor, 'success',
                  "the address has been delete successfully");
            }
          },
          builder: (context, state) {
            if (state is GetAddressLoading || state is DeleteAddressLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              List<AddressModel> addresses = addressCubit.addresses;
              if (addresses.isNotEmpty) {
                return ListView.builder(
                    itemCount: addresses.length,
                    itemBuilder: (context, index) {
                      AddressModel addressModel = addresses[index];
                      return AddressListTile(
                        addressModel: addressModel,
                      );
                    });
              } else {
                return const Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Center(
                    child: Text(
                      "لا يوجد أي عنواين حالية 😣",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20, color: AppColor.black),
                    ),
                  ),
                );
              }
            }
          },
        ),
      ),
    );
  }
}
