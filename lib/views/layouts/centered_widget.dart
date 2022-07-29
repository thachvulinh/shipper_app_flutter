import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../app/controllers/navbarcontroller.dart';

class CustomCenterWidget extends StatelessWidget {
  const CustomCenterWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final navBarProvider = Provider.of<NavBarController>(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: navBarProvider.getCenteredTopText(),
    );
  }
}
