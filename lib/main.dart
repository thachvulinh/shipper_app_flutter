import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shipper/common/constants.dart';
import 'package:shipper/utils/routes.dart';
import 'package:provider/provider.dart';
import 'package:get_storage/get_storage.dart';

import 'package:shipper/app/controllers/navbarcontroller.dart';
import 'package:shipper/app/controllers/postscontroller.dart';
import 'package:camera/camera.dart';
List<CameraDescription> cameras = [];

main() async {
  await GetStorage.init();
  try {
    WidgetsFlutterBinding.ensureInitialized();
    cameras = await availableCameras();
  } on CameraException catch (e) {
    print('Error in fetching the cameras: $e');
  }
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final routingClass = RoutingPages();
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => NavBarController(),
          ),
          ChangeNotifierProvider(
            create: (context) => PostsController(),
          ),
        ],
        child: GetMaterialApp(
          theme: ThemeData(primarySwatch: kmainColor),
          debugShowCheckedModeBanner: false,
          initialRoute: '/splashpage',
          getPages: routingClass.pages,
        ),
      ),
    );
  }
}
