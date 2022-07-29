import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shipper/common/constants.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../app/controllers/info_websitecontroller.dart';
import '../../app/controllers/userscontroller.dart';
import '../../common/socketio.dart';
import '../../designs/controls/checkbox_input.dart';
import '../../designs/controls/icon_text_input.dart';
import '../../designs/controls/signin_button.dart';
class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);
  @override
  State<SignInPage> createState() => SignInPageState();
}
class SignInPageState extends State<SignInPage>{
  late Socket socket;
  void initState() {
    socket=SocketIO().connectToServer();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var rememberValue = false;
    TextEditingController userController=TextEditingController(text:"linh_shipper");
    TextEditingController passController=TextEditingController(text:"123");
    final usersProvider = UsersController();
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
        body:Container(
          child: Stack(
            children: [
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topRight,
                          end:Alignment.bottomLeft,
                          stops: [0.0,1.0],
                          colors: [
                            Color(0xff00BFA5),
                            Color(0xff64FFDA),
                          ]
                      )
                  ),
                ),
              ),
              Positioned.fill(
                child: SingleChildScrollView(
                  padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 100,
                        padding: const EdgeInsets.only(left: 30.0, right: 30.0),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(
                            Radius.circular(25.0),
                          ),
                        ),
                        child:Padding(
                          padding: const EdgeInsets.all(30.0),
                          child: Form(
                              child:Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: AssetImage('assets/Logo-512.png'),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        height: 75,
                                        width: 75,
                                      ),
                                      Text("GIAO HÀNG",style: TextStyle(fontSize: 25,fontWeight:FontWeight.bold ),),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  IconTextInput(
                                    controller:userController,
                                    hint: "Nhập tài khoản",
                                    prefixIcon:const Icon(Icons.person),
                                    validator: (value){if(value==null || value.isEmpty){return "Vui lòng nhập tài khoản";}return null;},
                                  ),
                                  IconTextInput(
                                    hint: "Nhập mật khẩu",
                                    controller:passController,
                                    isObscured: true,
                                    prefixIcon:const Icon(Icons.lock),
                                    validator: (value){if(value==null || value.isEmpty){return "Vui lòng nhập mật khẩu";}return null;},
                                  ),
                                  CheckBoxInput(
                                    text: const Text("Nhớ tài khoản "),
                                    value:rememberValue,
                                    onChanged: (newValue){
                                      rememberValue=newValue!;
                                    },
                                  ),
                                  SigninButton(
                                    child: Text("Đăng nhập", style: TextStyle(fontFamily: "RobotoMedium", fontSize: 16, color: Colors.white)),
                                    onPressed: () {
                                      usersProvider.loginSubmit(context,socket,userController.text,passController.text);
                                    },
                                  ),
                                ],
                              )
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          //codechu thich
        )
      // body: SafeArea(
      //   child: Container(
      //     padding: const EdgeInsets.symmetric(horizontal: 20),
      //     child: SingleChildScrollView(
      //       child: Column(
      //         //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //         children: [
      //           Image.asset(
      //             'assets/main_icon.png',
      //             color: kMainColor,
      //             scale: 3.5,
      //           ),
      //           Padding(
      //             padding: const EdgeInsets.symmetric(vertical: 15.0),
      //             child: 'Log in to your Account'
      //                 .text
      //                 .minFontSize(24)
      //                 .fontWeight(FontWeight.w600)
      //                 .maxFontSize(26)
      //                 .make(),
      //           ),
      //           Padding(
      //             padding: const EdgeInsets.symmetric(vertical: 15.0),
      //             child: 'Welcome back, please enter your details'
      //                 .text
      //                 .minFontSize(18)
      //                 .make(),
      //           ),
      //           InkWell(
      //             child: Container(
      //               padding: const EdgeInsets.symmetric(
      //                 vertical: 15,
      //               ),
      //               decoration: BoxDecoration(
      //                   border: Border.all(
      //                     color: kMainColor,
      //                   ),
      //                   borderRadius: BorderRadius.circular(5)),
      //               child: Row(
      //                 mainAxisAlignment: MainAxisAlignment.center,
      //                 children: [
      //                   Image.asset(
      //                     'assets/search.png',
      //                     scale: 20,
      //                   ),
      //                   const SizedBox(
      //                     width: 30,
      //                   ),
      //                   'Continue with Google'.text.minFontSize(18).make()
      //                 ],
      //               ),
      //             ),
      //           ),
      //           Padding(
      //             padding: const EdgeInsets.symmetric(vertical: 15),
      //             child: Row(
      //               mainAxisAlignment: MainAxisAlignment.center,
      //               children: [
      //                 const Expanded(
      //                   child: Divider(
      //                     color: Colors.black54,
      //                     //thickness: 1.0,
      //                   ),
      //                 ),
      //                 Padding(
      //                   padding: const EdgeInsets.symmetric(
      //                       horizontal: 8.0, vertical: 5),
      //                   child: 'OR'.text.make(),
      //                 ),
      //                 const Expanded(
      //                   child: Divider(
      //                     color: Colors.black54,
      //                     //thickness: 1.0,
      //                   ),
      //                 ),
      //               ],
      //             ),
      //           ),
      //           const SizedBox(
      //             height: 20,
      //           ),
      //           CustomInput(
      //             title: 'Email Address',
      //           ),
      //           const SizedBox(
      //             height: 20,
      //           ),
      //           CustomInput(
      //             title: 'Password',
      //             isPassword: true,
      //           ),
      //           Padding(
      //             padding: const EdgeInsets.symmetric(vertical: 10.0),
      //             child: Row(
      //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //               children: [
      //                 Row(
      //                   children: [
      //                     const CheckBoxx(),
      //                     'Remember Me'.text.make(),
      //                   ],
      //                 ),
      //                 InkWell(
      //                   child: Padding(
      //                     padding: const EdgeInsets.only(right: 10.0),
      //                     child: 'Forgot Password?'
      //                         .text
      //                         .fontWeight(FontWeight.w600)
      //                         .make(),
      //                   ),
      //                 ),
      //               ],
      //             ),
      //           ),
      //           ElevatedButton(
      //             onPressed: () {
      //               Get.offAllNamed('/wrapper');
      //             },
      //             child: Center(
      //               child: Padding(
      //                 padding: const EdgeInsets.all(18.0),
      //                 child: 'Log in'
      //                     .text
      //                     .minFontSize(18)
      //                     .fontWeight(FontWeight.w600)
      //                     .make(),
      //               ),
      //             ),
      //           ),
      //           Padding(
      //             padding: const EdgeInsets.symmetric(vertical: 25.0),
      //             child: Row(
      //               mainAxisAlignment: MainAxisAlignment.center,
      //               children: [
      //                 'Don\'t have an account?'.text.minFontSize(16).make(),
      //                 const SizedBox(
      //                   width: 5,
      //                 ),
      //                 InkWell(
      //                   onTap: (() => Get.toNamed('/signuppage')),
      //                   child: 'Sign Up'
      //                       .text
      //                       .fontWeight(FontWeight.w500)
      //                       .minFontSize(16)
      //                       .color(
      //                         const Color.fromARGB(255, 8, 12, 236),
      //                       )
      //                       .make(),
      //                 ),
      //               ],
      //             ),
      //           ),
      //         ],
      //       ),
      //     ),
      //   ),
      // ),
    );
  }
}
