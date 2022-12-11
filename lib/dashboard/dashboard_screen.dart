import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_user_shop_app/home/home_screen.dart';
import 'package:new_user_shop_app/notification/notification_screen.dart';
import 'package:new_user_shop_app/profile/address/bloc/address_bloc.dart';
import 'package:new_user_shop_app/profile/profile_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  void initState() {
    super.initState();

    // Load Address
    final addressBloc = context.read<AddressBloc>();
    addressBloc.add(AddressFetchEvent());
  }

  final List<Widget> screens = [
    const HomeScreen(),
    const NotificationScreen(),
    const ProfileScreen()
  ];
  int index = 0;
  @override
  Widget build(BuildContext context) {
    final localized = AppLocalizations.of(context);
    return Scaffold(
      body: IndexedStack(
        index: index,
        children: screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        onTap: (value) {
          setState(() {
            index = value;
          });
        },
        selectedFontSize: 16.0,
        unselectedFontSize: 14.0,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
        unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.home),
            label: localized.home,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.notifications),
            label: localized.notification,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.dashboard),
            label: localized.profile,
          ),
        ],
      ),
    );
  }
}
