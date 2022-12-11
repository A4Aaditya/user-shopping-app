import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_user_shop_app/app_wrapper.dart';
import 'package:new_user_shop_app/authentication/bloc/auth_bloc.dart';
import 'package:new_user_shop_app/cart/bloc/cart_bloc.dart';
import 'package:new_user_shop_app/home/bloc/home_bloc.dart';
import 'package:new_user_shop_app/notification/bloc/notification_bloc.dart';
import 'package:new_user_shop_app/notification/repository/i_notification_repo.dart';
import 'package:new_user_shop_app/oders/bloc/order_bloc.dart';
import 'package:new_user_shop_app/profile/address/bloc/add_address_bloc.dart';
import 'package:new_user_shop_app/profile/address/bloc/address_bloc.dart';
import 'package:new_user_shop_app/profile/address/repository/address_repository.dart';

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

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
          create: (context) => NotificationBloc(repo: INotificationRepo()),
        ),
        BlocProvider(
          create: (context) => AddressBloc(repository: AddressRepository())
            ..add(isLoggedIn ? AddressFetchEvent() : InitialAddressEvent()),
        ),
        BlocProvider(
          create: (context) => AddAddressBloc(AddressRepository()),
        )
      ],
      child: AppWrapper(isLoggedIn: isLoggedIn),
    );
  }
}
