class OrderModel {
  String? ordersId;
  String? ordersUsersid;
  String? ordersAddress;
  String? ordersType;
  String? ordersPricedelivery;
  String? ordersAllprodcutsprice;
  String? ordersCoupon;
  String? ordersDatetime;
  String? ordersPaymentmethod;
  String? ordersState;
  String? ordersTotalPrice;
  String? addressId;
  String? addressUsersid;
  String? addressCity;
  String? addressStreet;
  String? addressName;

  OrderModel(
      {this.ordersId,
      this.ordersUsersid,
      this.ordersAddress,
      this.ordersType,
      this.ordersPricedelivery,
      this.ordersAllprodcutsprice,
      this.ordersCoupon,
      this.ordersDatetime,
      this.ordersPaymentmethod,
      this.ordersState,
      this.ordersTotalPrice,
      this.addressId,
      this.addressUsersid,
      this.addressCity,
      this.addressStreet,
      this.addressName});

  OrderModel.fromJson(Map<String, dynamic> json) {
    ordersId = json['orders_id'];
    ordersUsersid = json['orders_usersid'];
    ordersAddress = json['orders_address'];
    ordersType = json['orders_type'];
    ordersPricedelivery = json['orders_pricedelivery'];
    ordersAllprodcutsprice = json['orders_allprodcutsprice'];
    ordersCoupon = json['orders_coupon'];
    ordersDatetime = json['orders_datetime'];
    ordersPaymentmethod = json['orders_paymentmethod'];
    ordersState = json['orders_state'];
    ordersTotalPrice = json['orders_total_price'];
    addressId = json['address_id'];
    addressUsersid = json['address_usersid'];
    addressCity = json['address_city'];
    addressStreet = json['address_street'];
    addressName = json['address_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['orders_id'] = this.ordersId;
    data['orders_usersid'] = this.ordersUsersid;
    data['orders_address'] = this.ordersAddress;
    data['orders_type'] = this.ordersType;
    data['orders_pricedelivery'] = this.ordersPricedelivery;
    data['orders_allprodcutsprice'] = this.ordersAllprodcutsprice;
    data['orders_coupon'] = this.ordersCoupon;
    data['orders_datetime'] = this.ordersDatetime;
    data['orders_paymentmethod'] = this.ordersPaymentmethod;
    data['orders_state'] = this.ordersState;
    data['orders_total_price'] = this.ordersTotalPrice;
    data['address_id'] = this.addressId;
    data['address_usersid'] = this.addressUsersid;
    data['address_city'] = this.addressCity;
    data['address_street'] = this.addressStreet;
    data['address_name'] = this.addressName;
    return data;
  }
}
