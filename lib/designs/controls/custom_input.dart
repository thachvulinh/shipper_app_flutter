import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class CustomInput extends StatelessWidget {
  CustomInput({Key? key,
    required this.title,
    required this.controller,
    this.isPassword = false,
  })
      : super(key: key);
  bool isPassword;
  String title;
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8,bottom: 8),
      child:Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 5.0),
            child: title.text.make(),
          ),
          TextFormField(
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
            ),
            obscureText: isPassword,
            controller:controller
          ),
        ],
      ),
    );
  }
}
