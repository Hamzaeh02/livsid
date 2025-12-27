import 'package:flutter/material.dart';
import 'package:livsd/views/auth_screens/logout.dart';
import 'package:livsd/views/dashboard/wish_list_screen.dart';
import 'package:sizer/sizer.dart';

import '../../widgets/custom_bottom_navigation.dart';
import 'welcome_screen.dart';
import 'search_screen.dart';



class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const WelcomeScreen(),
     SearchScreen(),
     WishListScreen(),
LogoutScreen(),

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,

      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),

      bottomNavigationBar: CustomBottomNavigation(
        selectedIndex: _selectedIndex,
        onItemSelected: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
