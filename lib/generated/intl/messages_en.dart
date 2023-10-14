// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static String m0(products_length) =>
      "You have ${products_length} products in your cart";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "add_to_cart": MessageLookupByLibrary.simpleMessage("Add to Cart"),
        "ar_language": MessageLookupByLibrary.simpleMessage("Arabic"),
        "cart": MessageLookupByLibrary.simpleMessage("Cart"),
        "categories_word": MessageLookupByLibrary.simpleMessage("Categories"),
        "choose_language": MessageLookupByLibrary.simpleMessage(
            "choose your preferred language"),
        "en_language": MessageLookupByLibrary.simpleMessage("English"),
        "find_product": MessageLookupByLibrary.simpleMessage("Find Product"),
        "no_cart_products": MessageLookupByLibrary.simpleMessage(
            "Go and add products to the cart 😎"),
        "offer": MessageLookupByLibrary.simpleMessage("Offer"),
        "onboarding_body_page_one": MessageLookupByLibrary.simpleMessage(
            "We Have a 100K Product , Choose \n Your Product From  Our \n E-commerce Shop"),
        "onboarding_body_page_three": MessageLookupByLibrary.simpleMessage(
            "Watch your order while it is being prepared,\n when it has been done,\n and when it is on the road to you"),
        "onboarding_body_page_two": MessageLookupByLibrary.simpleMessage(
            "We Have one of the best ways \n to pay safely and easily in our \n E-commerce Shop"),
        "onboarding_done": MessageLookupByLibrary.simpleMessage("done"),
        "onboarding_next": MessageLookupByLibrary.simpleMessage("next"),
        "onboarding_skip": MessageLookupByLibrary.simpleMessage("skip"),
        "onboarding_title_page_one":
            MessageLookupByLibrary.simpleMessage("Choose Product"),
        "onboarding_title_page_three":
            MessageLookupByLibrary.simpleMessage("Track Your Order"),
        "onboarding_title_page_two":
            MessageLookupByLibrary.simpleMessage("Easy And Safe Payment"),
        "place_order": MessageLookupByLibrary.simpleMessage("Place Order"),
        "products_price":
            MessageLookupByLibrary.simpleMessage("Products\' Price"),
        "remove_from_cart":
            MessageLookupByLibrary.simpleMessage("Remove From Cart"),
        "shipping": MessageLookupByLibrary.simpleMessage("Shipping"),
        "top_selling": MessageLookupByLibrary.simpleMessage("Top Selling"),
        "total_price": MessageLookupByLibrary.simpleMessage("Total Price"),
        "you_have_products_added_to_cart": m0
      };
}
