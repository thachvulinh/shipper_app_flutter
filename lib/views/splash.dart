import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:shipper/common/constants.dart';

import 'users/signin.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return EasySplashScreen(
      logo: Image.asset(
        'assets/Logo-512.png',
        //color: kMainColor,
      ),
      title: const Text(
        "LUCKY",
        style: TextStyle(
          fontSize: 25,
          color: kMainColor,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
      //backgroundColor: Colors.grey.shade400,
      showLoader: true,
      loadingText: const Text(
        "Đang tải...",
        style: TextStyle(color: kMainColor),
      ),
      navigator: const SignInPage(),
      durationInSeconds: 3,
    );
  }
}
