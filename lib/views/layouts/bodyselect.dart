import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../app/controllers/navbarcontroller.dart';
import '../chat/listmessage.dart';
import '../order/orders.dart';
import '../users/myuser.dart';
import '../users/userlist.dart';
class BodyWidget extends StatelessWidget {
  const BodyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final navbarProvider = Provider.of<NavBarController>(context);
    switch (navbarProvider.nBarindex) {
      case 0:
        return const OrderPage();
      case 1:
        return const UsersListPage();
      case 2:
        return const ListMessagePage();
      default:
        return const MyUserPage();
    }
  }
}
