import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../app/models/usermodel.dart';

class User_Card extends StatelessWidget {
  const User_Card({Key? key,
    this.id_socket,
    this.name,
    this.avatar,
    this.bgavatar,
    this.message="Xem thông tin cá nhân",
    required this.onTap,
  }) : super(key: key);
  final String? id_socket;
  final String? name;
  final String? avatar;
  final String? bgavatar;
  final String message;
  final void Function() onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        height: Get.height * 0.15,
        width: Get.width,
        color: Colors.white,
        child: Row(
          children: [
            Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0, right: 15),
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(avatar!),
                      radius: 35,
                    ),
                  ),
                  id_socket==null|| id_socket==""?SizedBox(height:1):
                  Positioned(
                    right: 10,
                    bottom: 6,
                    child: Container(
                        padding: EdgeInsets.all(7.5),
                        decoration: BoxDecoration(
                            border: Border.all(
                                width: 2,
                                color: Colors.white
                            ),
                            borderRadius: BorderRadius.circular(90.0),
                            color: Colors.green
                        )
                    )
                  )
                ]
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  name!.text
                      .minFontSize(20)
                      .fontWeight(FontWeight.w700)
                      .make(),
                  const Divider(
                    height: 5,
                  ),
                  message.text
                      .minFontSize(12)
                      .make(),
                ],
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: 'Time'.text.minFontSize(16).maxFontSize(16).make(),
            ),
          ],
        ),
      ),
    );
  }
}
