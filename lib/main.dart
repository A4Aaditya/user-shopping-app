import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:new_user_shop_app/app_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}
