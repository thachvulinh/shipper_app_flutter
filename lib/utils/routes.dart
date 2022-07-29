import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shipper/app/controllers/userscontroller.dart';

import '../views/users/signin.dart';
import '../views/order/orders.dart';
import '../views/users/myuser.dart';
import '../views/order/myorder.dart';
import '../views/users/changepassword.dart';
import '../views/users/profile.dart';
import '../views/users/userlist.dart';
import '../views/wrapper.dart';
import '../views/splash.dart';
import '../views/users/userinfo.dart';
import '../views/utility/comments.dart';
import '../views/chat/msgs.dart';


class RoutingPages {
  List<GetPage<dynamic>> pages = [
    //
    //loading
    GetPage(
      name: '/splashpage',
      page: () => const SplashPage(),
    ),
    //users
    GetPage(
      name: '/signinpage',
      page: () => const SignInPage(),
    ),
    GetPage(
      name: '/profilepage',
      page: () => const ProfilePage(),
    ),
    GetPage(
      name: '/userinfo',
      page: () => UserInfoPage(),
    ),
    GetPage(
      name: '/changepassword',
      page: () => ChangePasswordPage(),
    ),
    GetPage(
      name: '/myorder',
      page: () => MyOrderPage(),
    ),
    GetPage(
      name: '/orders',
      page: () => const OrderPage(),
    ),
    //main
    GetPage(
      name: '/wrapper',
      page: () => WrapperManager(),
    ),

    GetPage(
      name: '/searchpage',
      page: () => const UsersListPage(),
    ),
    GetPage(
      name: '/inboxpage',
      page: () => const MyUserPage(),
    ),
    // GetPage(
    //   name: '/commentspage',
    //   page: () => const CommentsPage(),
    // ),
  ];
}
