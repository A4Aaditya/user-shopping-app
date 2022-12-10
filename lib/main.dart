import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_user_shop_app/authentication/bloc/auth_bloc.dart';
import 'package:new_user_shop_app/authentication/views/login_screen.dart';
import 'package:new_user_shop_app/cart/bloc/cart_bloc.dart';
import 'package:new_user_shop_app/dashboard/dashboard_screen.dart';
import 'package:new_user_shop_app/home/bloc/home_bloc.dart';
import 'package:new_user_shop_app/oders/bloc/order_bloc.dart';
import 'package:new_user_shop_app/profile/address/bloc/address_bloc.dart';
import 'package:new_user_shop_app/profile/address/repository/address_repository.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final isLoggedIn = FirebaseAuth.instance.currentUser != null;
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthBloc()),
        BlocProvider(
          create: (context) => HomeBloc()
            ..add(isLoggedIn ? HomeFetchProductEvent() : HomeInitialEvent()),
        ),
        BlocProvider(create: (context) => CartBloc()),
        BlocProvider(create: (context) => OrderBloc()),
        BlocProvider(
          create: (context) => AddressBloc(repository: AddressRepository())
            ..add(isLoggedIn ? AddressFetchEvent() : InitialAddressEvent()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light(),
        home: isLoggedIn ? const Dashboard() : const LoginScreen(),
      ),
    );
  }
}
