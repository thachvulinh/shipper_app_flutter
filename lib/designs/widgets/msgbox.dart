import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shipper/common/constants.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../app/models/postmodel.dart';

// ignore: must_be_immutable
class MsgBox extends StatelessWidget {
  MsgBox({Key? key, required this.name, required this.msg,this.avatar,required this.type}) : super(key: key);
  String name;
  String msg;
  String? avatar;
  String type;
  @override
  Widget build(BuildContext context) {
    final PostModel mymodel = PostModel();
    return type=="right"?Row(
      children: [
        const Spacer(),
        Container(
          decoration: BoxDecoration(
            color: kaccentColor,
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 15),
          margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
          child: msg.text
              .overflow(TextOverflow.ellipsis)
              .maxLines(100)
              .align(TextAlign.justify)
              .color(Colors.white)
              .fontWeight(FontWeight.w400)
              .make(),
        ),
        Padding(
          padding: const EdgeInsets.only(
            right: 5.0,
          ),
          child: CircleAvatar(
            backgroundImage: NetworkImage(avatar!),
          ),
        ),
      ],
    ):Row(//left
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: 5.0,
          ),
          child: CircleAvatar(
            backgroundImage: NetworkImage(avatar!),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: kaccentColor,
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 15),
          margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
          child: msg.text
              .overflow(TextOverflow.ellipsis)
              .maxLines(100)
              .align(TextAlign.justify)
              .color(Colors.white)
              .fontWeight(FontWeight.w400)
              .make(),
        ),
      ],
    );
  }
}
