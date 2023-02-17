import 'package:church_app/pages/add_new_card.page.dart';
import 'package:church_app/pages/cart.page.dart';
import 'package:church_app/pages/checkout.page.dart';
import 'package:church_app/pages/detail_product.widget.dart';
import 'package:church_app/pages/login.page.dart';
import 'package:church_app/pages/payment_methods.page.dart';
import 'package:church_app/pages/sign_up.page.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../pages/initial_tabs.page.dart';
import '../pages/splash.page.dart';

List<GetPage<Widget>> routes = [
  GetPage(
    name: '/splash',
    page: () => const SplashPage(),
  ),
  GetPage(
    name: '/initial_tabs',
    page: () => const InitialTabsPage(),
  ),
  GetPage(
    name: '/detail_product',
    page: () => const DetailProductPage(),
  ),
  GetPage(
    name: '/cart',
    page: () => const CartPage(),
  ),
  GetPage(
    name: '/payment_methods',
    page: () => const PaymentMethodsPage(),
  ),
  GetPage(
    name: '/add_new_card',
    page: () => const AddNewCardPage(),
  ),
  GetPage(
    name: '/checkout',
    page: () => const CheckoutPage(),
  ),
  GetPage(
    name: '/login',
    page: () => LoginPage(),
  ),
  GetPage(
    name: '/sign_up',
    page: () => SignUpPage(),
  ),
];
