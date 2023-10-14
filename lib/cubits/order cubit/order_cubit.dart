import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart';
import 'package:test/core/api/crud.dart';
import 'package:test/core/functions/check_internet_function.dart';
import 'package:test/core/functions/handling_failure_response.dart';
import 'package:test/data/data%20source/remote/order_remote.dart';
import 'package:test/data/model/cart_model.dart';
import 'package:test/data/model/order_model.dart';
import 'package:test/data/model/user%20model/user_model.dart';

part 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  Crud crud = Crud();
  UserModel userModel = UserModel.instance;
  OrderCubit() : super(OrderInitial());
  late String addressId;
  List<OrderModel> pendingOrders = [];
  List<OrderModel> archiveOrders = [];

  List<CartModel> products = [];

  void placeOrder(String priceDelivery, String productsPrice) async {
    if (await checkInternetFunction()) {
      emit(PlaceOrderLoading());
      try {
        OrderRemote orderRemote = OrderRemote(crud);
        var response = await orderRemote.placeOrder(
            userModel.userId, addressId, priceDelivery, productsPrice);

        if (response is Map<String, dynamic>) {}
        String? failureMessage = handlingFailureMessage(
            response, "we could not place you order..Sorry!");
        if (failureMessage != null) {
          emit(PlaceOrderFailure(errorMessage: failureMessage));
        } else {
          
          emit(PlaceOrderSuccess());
        }
      } on Exception catch (e) {
        if (e is ClientException) {
          emit(const PlaceOrderFailure(
              errorMessage: "the internet is slow, try again"));
        }
        emit(PlaceOrderFailure(
            errorMessage: "unknown problem : ${e.toString()} "));
      }
    } else {
      emit(const PlaceOrderFailure(
          errorMessage: "the internet is slow, try again"));
    }
  }

  void pendingOrder() async {
    if (await checkInternetFunction()) {
      emit(PendingOrderLoading());
      try {
        OrderRemote orderRemote = OrderRemote(crud);
        var response = await orderRemote.pendingOrder(userModel.userId);

        if (response is Map<String, dynamic>) {
          pendingOrders.clear();
          for (final order in response["data"]) {
            pendingOrders.add(OrderModel.fromJson(order));
          }
        }
        String? failureMessage =
            handlingFailureMessage(response, "failed no data!");
        if (failureMessage != null) {
          pendingOrders.clear();
          emit(PendingOrderFailure(errorMessage: failureMessage));
        } else {
          emit(PendingOrderSuccess());
        }
      } on Exception catch (e) {
        if (e is ClientException) {
          emit(const PendingOrderFailure(
              errorMessage: "the internet is slow, try again"));
        }
        emit(PendingOrderFailure(
            errorMessage: "unknown problem : ${e.toString()} "));
      }
    } else {
      emit(const PendingOrderFailure(
          errorMessage: "the internet is slow, try again"));
    }
  }

  void archiveOrder() async {
    if (await checkInternetFunction()) {
      emit(ArchiveOrderLoading());
      try {
        OrderRemote orderRemote = OrderRemote(crud);
        var response = await orderRemote.archiveOrder(userModel.userId);

        if (response is Map<String, dynamic>) {
          archiveOrders.clear();
          for (final order in response["data"]) {
            archiveOrders.add(OrderModel.fromJson(order));
          }
        }
        String? failureMessage =
            handlingFailureMessage(response, "failed no data!");
        if (failureMessage != null) {
          pendingOrders.clear();
          emit(ArchiveOrderFailure(errorMessage: failureMessage));
        } else {
          emit(ArchiveOrderSuccess());
        }
      } on Exception catch (e) {
        if (e is ClientException) {
          emit(const ArchiveOrderFailure(
              errorMessage: "the internet is slow, try again"));
        }
        emit(ArchiveOrderFailure(
            errorMessage: "unknown problem : ${e.toString()} "));
      }
    } else {
      emit(const ArchiveOrderFailure(
          errorMessage: "the internet is slow, try again"));
    }
  }

  void orderDetails(ordersId) async {
    if (await checkInternetFunction()) {
      emit(OrderDetailsLoading());
      try {
        OrderRemote orderRemote = OrderRemote(crud);
        var response = await orderRemote.detailsOrder(ordersId);

        if (response is Map<String, dynamic>) {
          products.clear();
          for (final product in response["data"]) {
            products.add(CartModel.fromJson(product));
          }
        }
        String? failureMessage =
            handlingFailureMessage(response, "failed no data!");
        if (failureMessage != null) {
          emit(OrderDetailsFailure(errorMessage: failureMessage));
        } else {
          emit(OrderDetailsSuccess());
        }
      } on Exception catch (e) {
        if (e is ClientException) {
          emit(const OrderDetailsFailure(
              errorMessage: "the internet is slow, try again"));
        }
        emit(OrderDetailsFailure(
            errorMessage: "unknown problem : ${e.toString()} "));
      }
    } else {
      emit(const OrderDetailsFailure(
          errorMessage: "the internet is slow, try again"));
    }
  }

  void deleteOrder(OrderModel orderModel) async {
    if (await checkInternetFunction()) {
      emit(DeleteOrderLoading());
      try {
        OrderRemote orderRemote = OrderRemote(crud);
        var response = await orderRemote.deleteOrder(orderModel.ordersId!);
        String? failureMessage =
            handlingFailureMessage(response, "failed to delete data!");
        if (failureMessage != null) {
          emit(DeleteOrderFailure(errorMessage: failureMessage));
        } else {
          pendingOrders.remove(orderModel);
          emit(DeleteOrderSuccess());
        }
      } on Exception catch (e) {
        if (e is ClientException) {
          emit(const DeleteOrderFailure(
              errorMessage: "the internet is slow, try again"));
        }
        emit(DeleteOrderFailure(
            errorMessage: "unknown problem : ${e.toString()} "));
      }
    } else {
      emit(const DeleteOrderFailure(
          errorMessage: "the internet is slow, try again"));
    }
  }
}
