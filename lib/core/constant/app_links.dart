class AppLinks {
  static const String serverLink =
      'https://housinasmail.000webhostapp.com/ecommerce';
  // ================================= Auth ================================= //
  static const String authLink = '$serverLink/auth';
  static const String signUpLink = '$authLink/signup.php';
  static const String loginLink = '$authLink/login.php';
  static const String checkSendEmailLink = '$authLink/check_send_email.php';
  static const String verifyCodeLink = '$authLink/verifycode.php';
  static const String resetPasswordLink = '$authLink/reset_password.php';
  // ================================= Home ================================= //
  static const String homeLink = '$serverLink/home.php';
  // ================================= Notification ================================= //
  static const String notificationLink = '$serverLink/notification.php';

  // ================================= Images ================================= //
  static const String imageLink = '$serverLink/upload';
  static const String imageCategoriesLink = '$imageLink/categories';
  static const String imageProductsLink = '$imageLink/products';
  // ================================= Products ================================= //
  static const String productLink = '$serverLink/products';
  static const String getProductLink = '$productLink/get_product.php';
  static const String searchProductLink = '$productLink/search_product.php';
  static const String getOffersLink = '$productLink/offer.php';

  // ================================= Favorite ================================= //
  static const String favoriteLink = '$serverLink/favorite';
  static const String addFavoriteLink = '$favoriteLink/add.php';
  static const String deleteFavoriteLink = '$favoriteLink/delete.php';
  static const String viewFavoriteLink = '$favoriteLink/view.php';

  // ================================= Cart ================================= //
  static const String cartLink = '$serverLink/cart';
  static const String addCartLink = '$cartLink/add.php';
  static const String deleteCartLink = '$cartLink/delete.php';
  static const String viewCartLink = '$cartLink/view.php';

  // ================================= Address ================================= //
  static const String addressLink = '$serverLink/address';
  static const String addAddressLink = '$addressLink/add.php';
  static const String deleteAddressLink = '$addressLink/delete.php';
  static const String viewAddressLink = '$addressLink/view.php';
  static const String editAddressLink = '$addressLink/edit.php';
  // ================================= Order ================================= //
  static const String orderLink = '$serverLink/order';
  static const String placeOrderLink = '$orderLink/place_order.php';
  static const String pendingOrderLink = '$orderLink/pending_order.php';
  static const String detailsOrderLink = '$orderLink/order_details.php';
  static const String deleteOrderLink = '$orderLink/delete_order.php';
  static const String archiveOrderLink = '$orderLink/archive_order.php';
}
