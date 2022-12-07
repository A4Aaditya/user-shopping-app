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

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthBloc()),
        BlocProvider(create: (context) => HomeBloc()),
        BlocProvider(create: (context) => CartBloc()),
        BlocProvider(create: (context) => OrderBloc())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light(),
        home: FirebaseAuth.instance.currentUser != null
            ? const Dashboard()
            : const LoginScreen(),
      ),
    );
  }
}
