import 'package:test/core/api/crud.dart';
import 'package:test/core/constant/app_links.dart';

class OrderRemote {
  Crud crud;
  OrderRemote(this.crud);
  placeOrder(
    String usersId,
    String addressId,
    String priceDelivery,
    String ordersPrice, {
    String couponId = '0',
    String paymentMethod = '0',
    String ordersType = '0',
  }) async {
    var response = await crud.postData(AppLinks.placeOrderLink, {
      "users_id": usersId,
      "orders_type": ordersType,
      "address_id": addressId,
      "payment_method": paymentMethod,
      "price_delivery": priceDelivery,
      "coupon_id": couponId,
      "orders_price": ordersPrice
    });
    var resp = response.fold((l) => l, (r) => r);
    return resp;
  }

  pendingOrder(
    String usersId,
  ) async {
    var response = await crud.postData(AppLinks.pendingOrderLink, {
      "users_id": usersId,
    });
    var resp = response.fold((l) => l, (r) => r);
    return resp;
  }
  archiveOrder(
    String usersId,
  ) async {
    var response = await crud.postData(AppLinks.archiveOrderLink, {
      "users_id": usersId,
    });
    var resp = response.fold((l) => l, (r) => r);
    return resp;
  }
    detailsOrder(
    String ordersId,
  ) async {
    var response = await crud.postData(AppLinks.detailsOrderLink,{
      "orders_id": ordersId,
    });
    var resp = response.fold((l) => l, (r) => r);
    return resp;
  }

  deleteOrder(
    String ordersId,
  ) async {
    var response = await crud.postData(AppLinks.deleteOrderLink,{
      "orders_id": ordersId,
    });
    var resp = response.fold((l) => l, (r) => r);
    return resp;
  }
}
