// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `English`
  String get en_language {
    return Intl.message(
      'English',
      name: 'en_language',
      desc: 'the english language',
      args: [],
    );
  }

  /// `Arabic`
  String get ar_language {
    return Intl.message(
      'Arabic',
      name: 'ar_language',
      desc: 'the arabic language',
      args: [],
    );
  }

  /// `choose your preferred language`
  String get choose_language {
    return Intl.message(
      'choose your preferred language',
      name: 'choose_language',
      desc: 'choose your preferred language',
      args: [],
    );
  }

  /// `next`
  String get onboarding_next {
    return Intl.message(
      'next',
      name: 'onboarding_next',
      desc: 'next',
      args: [],
    );
  }

  /// `skip`
  String get onboarding_skip {
    return Intl.message(
      'skip',
      name: 'onboarding_skip',
      desc: 'skip',
      args: [],
    );
  }

  /// `done`
  String get onboarding_done {
    return Intl.message(
      'done',
      name: 'onboarding_done',
      desc: 'done',
      args: [],
    );
  }

  /// `Choose Product`
  String get onboarding_title_page_one {
    return Intl.message(
      'Choose Product',
      name: 'onboarding_title_page_one',
      desc: 'onboarding_title_page_one',
      args: [],
    );
  }

  /// `We Have a 100K Product , Choose \n Your Product From  Our \n E-commerce Shop`
  String get onboarding_body_page_one {
    return Intl.message(
      'We Have a 100K Product , Choose \n Your Product From  Our \n E-commerce Shop',
      name: 'onboarding_body_page_one',
      desc: 'onboarding_body_page_one',
      args: [],
    );
  }

  /// `Easy And Safe Payment`
  String get onboarding_title_page_two {
    return Intl.message(
      'Easy And Safe Payment',
      name: 'onboarding_title_page_two',
      desc: 'onboarding_title_page_two',
      args: [],
    );
  }

  /// `We Have one of the best ways \n to pay safely and easily in our \n E-commerce Shop`
  String get onboarding_body_page_two {
    return Intl.message(
      'We Have one of the best ways \n to pay safely and easily in our \n E-commerce Shop',
      name: 'onboarding_body_page_two',
      desc: 'onboarding_body_page_two',
      args: [],
    );
  }

  /// `Track Your Order`
  String get onboarding_title_page_three {
    return Intl.message(
      'Track Your Order',
      name: 'onboarding_title_page_three',
      desc: 'onboarding_title_page_three',
      args: [],
    );
  }

  /// `Watch your order while it is being prepared,\n when it has been done,\n and when it is on the road to you`
  String get onboarding_body_page_three {
    return Intl.message(
      'Watch your order while it is being prepared,\n when it has been done,\n and when it is on the road to you',
      name: 'onboarding_body_page_three',
      desc: 'onboarding_body_page_three',
      args: [],
    );
  }

  /// `Categories`
  String get categories_word {
    return Intl.message(
      'Categories',
      name: 'categories_word',
      desc: 'categories',
      args: [],
    );
  }

  /// `Top Selling`
  String get top_selling {
    return Intl.message(
      'Top Selling',
      name: 'top_selling',
      desc: 'top_selling',
      args: [],
    );
  }

  /// `Offer`
  String get offer {
    return Intl.message(
      'Offer',
      name: 'offer',
      desc: 'offer word',
      args: [],
    );
  }

  /// `Find Product`
  String get find_product {
    return Intl.message(
      'Find Product',
      name: 'find_product',
      desc: 'onboarding_body_page_three',
      args: [],
    );
  }

  /// `Add to Cart`
  String get add_to_cart {
    return Intl.message(
      'Add to Cart',
      name: 'add_to_cart',
      desc: 'add_to_cart',
      args: [],
    );
  }

  /// `Remove From Cart`
  String get remove_from_cart {
    return Intl.message(
      'Remove From Cart',
      name: 'remove_from_cart',
      desc: 'remove_from_cart',
      args: [],
    );
  }

  /// `Go and add products to the cart 😎`
  String get no_cart_products {
    return Intl.message(
      'Go and add products to the cart 😎',
      name: 'no_cart_products',
      desc: 'no_cart_products',
      args: [],
    );
  }

  /// `Cart`
  String get cart {
    return Intl.message(
      'Cart',
      name: 'cart',
      desc: 'cart',
      args: [],
    );
  }

  /// `You have {products_length} products in your cart`
  String you_have_products_added_to_cart(int products_length) {
    return Intl.message(
      'You have $products_length products in your cart',
      name: 'you_have_products_added_to_cart',
      desc: 'cart',
      args: [products_length],
    );
  }

  /// `Products' Price`
  String get products_price {
    return Intl.message(
      'Products\' Price',
      name: 'products_price',
      desc: 'products_price',
      args: [],
    );
  }

  /// `Shipping`
  String get shipping {
    return Intl.message(
      'Shipping',
      name: 'shipping',
      desc: 'shipping',
      args: [],
    );
  }

  /// `Total Price`
  String get total_price {
    return Intl.message(
      'Total Price',
      name: 'total_price',
      desc: 'total',
      args: [],
    );
  }

  /// `Place Order`
  String get place_order {
    return Intl.message(
      'Place Order',
      name: 'place_order',
      desc: 'place_order',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
