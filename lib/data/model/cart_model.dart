class CartModel {
  String? productsId;
  String? productsName;
  String? productsNameAr;
  String? productsDescription;
  String? productsDescriptionAr;
  String? productsImage;
  String? productsCount;
  String? productsActive;
  String? productsPrice;
  String? productsDiscount;
  String? productsDatetime;
  String? productsCategories;
  String? categoriesId;
  String? categoriesName;
  String? categoriesNameAr;
  String? categoriesImage;
  String? categoriesDatetime;
  String? cartId;
  String? cartUsersid;
  String? cartProductsid;
  String? cartProductsCount;
  String? cartTotalProductPrice;
  String? cartOrders;
  String? productsPriceDiscount;

  CartModel(
      {this.productsId,
      this.productsName,
      this.productsNameAr,
      this.productsDescription,
      this.productsDescriptionAr,
      this.productsImage,
      this.productsCount,
      this.productsActive,
      this.productsPrice,
      this.productsDiscount,
      this.productsDatetime,
      this.productsCategories,
      this.categoriesId,
      this.categoriesName,
      this.categoriesNameAr,
      this.categoriesImage,
      this.categoriesDatetime,
      this.cartId,
      this.cartUsersid,
      this.cartProductsid,
      this.cartProductsCount,
      this.cartTotalProductPrice,
      this.cartOrders,
      this.productsPriceDiscount});

  CartModel.fromJson(Map<String, dynamic> json) {
    productsId = json['products_id'];
    productsName = json['products_name'];
    productsNameAr = json['products_name_ar'];
    productsDescription = json['products_description'];
    productsDescriptionAr = json['products_description_ar'];
    productsImage = json['products_image'];
    productsCount = json['products_count'];
    productsActive = json['products_active'];
    productsPrice = json['products_price'];
    productsDiscount = json['products_discount'];
    productsDatetime = json['products_datetime'];
    productsCategories = json['products_categories'];
    categoriesId = json['categories_id'];
    categoriesName = json['categories_name'];
    categoriesNameAr = json['categories_name_ar'];
    categoriesImage = json['categories_image'];
    categoriesDatetime = json['categories_datetime'];
    cartId = json['cart_id'];
    cartUsersid = json['cart_usersid'];
    cartProductsid = json['cart_productsid'];
    cartProductsCount = json['cart_products_count'];
    cartTotalProductPrice = json['cart_total_product_price'];
    cartOrders = json['cart_orders'];
    productsPriceDiscount = json['products_price_discount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['products_id'] = this.productsId;
    data['products_name'] = this.productsName;
    data['products_name_ar'] = this.productsNameAr;
    data['products_description'] = this.productsDescription;
    data['products_description_ar'] = this.productsDescriptionAr;
    data['products_image'] = this.productsImage;
    data['products_count'] = this.productsCount;
    data['products_active'] = this.productsActive;
    data['products_price'] = this.productsPrice;
    data['products_discount'] = this.productsDiscount;
    data['products_datetime'] = this.productsDatetime;
    data['products_categories'] = this.productsCategories;
    data['categories_id'] = this.categoriesId;
    data['categories_name'] = this.categoriesName;
    data['categories_name_ar'] = this.categoriesNameAr;
    data['categories_image'] = this.categoriesImage;
    data['categories_datetime'] = this.categoriesDatetime;
    data['cart_id'] = this.cartId;
    data['cart_usersid'] = this.cartUsersid;
    data['cart_productsid'] = this.cartProductsid;
    data['cart_products_count'] = this.cartProductsCount;
    data['cart_total_product_price'] = this.cartTotalProductPrice;
    data['cart_orders'] = this.cartOrders;
    data['products_price_discount'] = this.productsPriceDiscount;
    return data;
  }
}