class ProductModel {
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
  String? productsDateTime;
  String? productsCategories;
  String? categoriesId;
  String? categoriesName;
  String? categoriesNameAr;
  String? categoriesImage;
  String? categoriesDateTime;
  String? favorite;
  String? discountedPrice;
  ProductModel(
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
      this.productsDateTime,
      this.productsCategories,
      this.categoriesId,
      this.categoriesName,
      this.categoriesNameAr,
      this.discountedPrice,
      this.categoriesImage,
      this.categoriesDateTime,
      this.favorite});

  ProductModel.fromJson(Map<String, dynamic> json) {
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
    productsDateTime = json['products_datetime'];
    productsCategories = json['products_categories'];
    categoriesId = json['categories_id'];
    categoriesName = json['categories_name'];
    categoriesNameAr = json['categories_name_ar'];
    categoriesImage = json['categories_image'];
    categoriesDateTime = json['categories_datetime'];
    favorite = json['favorite'];
    discountedPrice = json['products_price_discount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['products_id'] = productsId;
    data['products_name'] = productsName;
    data['products_name_ar'] = productsNameAr;
    data['products_description'] = productsDescription;
    data['products_description_ar'] = productsDescriptionAr;
    data['products_image'] = productsImage;
    data['products_count'] = productsCount;
    data['products_active'] = productsActive;
    data['products_price'] = productsPrice;
    data['products_discount'] = productsDiscount;
    data['products_datetime'] = productsDateTime;
    data['products_categories'] = productsCategories;
    data['categories_id'] = categoriesId;
    data['categories_name'] = categoriesName;
    data['categories_name_ar'] = categoriesNameAr;
    data['categories_image'] = categoriesImage;
    data['categories_datetime'] = categoriesDateTime;
    data['favorite'] = favorite;
    data['products_price_discount'] = discountedPrice;
    return data;
  }
}
