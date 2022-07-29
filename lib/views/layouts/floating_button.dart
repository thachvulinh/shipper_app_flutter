import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shipper/common/constants.dart';
import 'package:provider/provider.dart';

import '../../app/controllers/postscontroller.dart';

class CustomFloatingActionButton extends StatelessWidget {
  const CustomFloatingActionButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final postProvider = Provider.of<PostsController>(context);
    return FloatingActionButton(
      backgroundColor: kMainColor,
      onPressed: () {
        Get.toNamed('/postpage')!.then((value) {
          if (value != null) {
            postProvider.addToPostList(value);
            // debugPrint(value.tweetText!);
            debugPrint(value.tweetImage.path!);
          }
        });
      },
      child: Image.asset(
        'assets/postIcon.png',
        color: Colors.white,
      ),
    );
  }
}
