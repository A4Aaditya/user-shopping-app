import 'package:flutter/material.dart';
import 'package:new_user_shop_app/authentication/views/login_screen.dart';
import 'package:new_user_shop_app/dashboard/dashboard_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      home: isLoggedIn ? const Dashboard() : const LoginScreen(),
    );
  }
}
