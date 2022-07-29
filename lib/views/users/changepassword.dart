import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shipper/app/controllers/userscontroller.dart';
import 'package:http/http.dart' as http;

import '../../common/com.dart';
import '../../common/constants.dart';
import '../../common/session.dart';
import '../../designs/controls/signin_button.dart';
import '../../designs/controls/custom_input.dart';
class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({Key? key}) : super(key: key);
  @override
  State<ChangePasswordPage> createState() => ChangePasswordPageState();
}
class ChangePasswordPageState extends State<ChangePasswordPage>{
  var user_login;
  final users_str = UsersController();
  TextEditingController usernameController = new TextEditingController() ;
  TextEditingController passwordController = new TextEditingController();
  TextEditingController passwordNewController = new TextEditingController();
  TextEditingController replyPasswordController = new TextEditingController();
  _getSession() async {
    var data_login= (await Session_Login().getSession_Login());
    setState(() {
      user_login=data_login;
      usernameController=TextEditingController(text:user_login["user_login_name"] );
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getSession();
  }
  @override
  Widget build(BuildContext context) {
    final users_ctr = UsersController();
    return Scaffold(
        backgroundColor: Colors.white.withOpacity(0.9),
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          leading: new IconButton(onPressed:(){Get.offAllNamed('/profilepage');}, icon:const Icon(Icons.arrow_left_outlined),color: Colors.white),
          centerTitle: true,
          title: const Text("Đổi mật khẩu"),
        ),
        body:user_login==null?SizedBox(height:1):SingleChildScrollView(
            child:Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 15,right: 15,top: 30,bottom: 180),
                  child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border:  Border.all(color:Colors.black26),
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      child:Padding(
                        padding: EdgeInsets.all(15),
                        child: Column(
                          children: [
                            CustomInput(
                              controller: passwordController,
                              title: 'Mật khẩu hiện tại',
                              isPassword:true

                            ),
                            CustomInput(
                              controller: passwordNewController,
                              title: 'Mật khẩu mới',
                              isPassword:true
                            ),
                            CustomInput(
                                controller: replyPasswordController,
                                title: 'Mật khẩu xác thực',
                                isPassword:true
                            ),
                            SigninButton(
                              child: Text("Cập nhật", style: TextStyle(fontFamily: "RobotoMedium", fontSize: 16, color: Colors.white)),
                              onPressed: () {
                                users_str.change_password(context, user_login, passwordController.text, passwordNewController.text, replyPasswordController.text);
                              },
                            ),
                          ],
                        ),
                      )
                  ),
                ),
              ],
            )
        )
    );
  }
}
