import 'package:flutter/material.dart';
import 'package:new_user_shop_app/authentication/views/login_screen.dart';
import 'package:new_user_shop_app/authentication/views/signup_screen.dart';
import 'package:new_user_shop_app/cart/cart_screen.dart';
import 'package:new_user_shop_app/constants/routes.dart';
import 'package:new_user_shop_app/dashboard/dashboard_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:new_user_shop_app/oders/order_screen.dart';
import 'package:new_user_shop_app/profile/address/address_screen.dart';

class AppWrapper extends StatelessWidget {
  const AppWrapper({
    super.key,
    required this.isLoggedIn,
  });
  final bool isLoggedIn;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      locale: const Locale('en', ''),
      routes: {
        AppRoute.routeLoginScreen: (context) => const LoginScreen(),
        AppRoute.routeSignupScreen: (context) => const SignupScreen(),
        AppRoute.routeDashBoardScreen: (context) => const Dashboard(),
        AppRoute.routeOrderScreen: (context) => const OrderScreen(),
        AppRoute.routeCartScreen: (context) => const CartScreen(),
        AppRoute.routeAddressScreen: (context) => const AddressScreen(),
      },
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      home: isLoggedIn ? const Dashboard() : const LoginScreen(),
    );
  }
}
