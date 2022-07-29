import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:shipper/common/constants.dart';
import 'package:provider/provider.dart';

import '../../app/controllers/navbarcontroller.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final navbarProvider = Provider.of<NavBarController>(context);
    return AnimatedBottomNavigationBar(
        activeColor: Colors.white,
        inactiveColor: Colors.cyanAccent.withOpacity(0.7),
        backgroundColor: kmainColor,
        elevation: 4,
        iconSize: 35,
        icons: const [
          Icons.my_library_books,
          Icons.person_pin_outlined,
          Icons.messenger,
          Icons.person_pin,
        ],
        activeIndex: navbarProvider.nBarindex,
        // gapLocation: GapLocation.end,
        // leftCornerRadius: 15,
        // rightCornerRadius: 15,
        notchSmoothness: NotchSmoothness.softEdge,
        onTap: (val) {
          navbarProvider.changeNavBarIndex(val);
        });
  }
}
