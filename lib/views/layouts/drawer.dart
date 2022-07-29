import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shipper/common/constants.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../common/session.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({Key? key}) : super(key: key);
  @override
  State<CustomDrawer> createState() => CustomDrawerState();
}
class CustomDrawerState extends State<CustomDrawer>{
   var user_login;
  _getSession() async {
    var data_login= (await Session_Login().getSession_Login());
    setState(() {
      user_login=data_login;
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    _getSession();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: kbgColor,
        border: Border.all(color: kaccentColor, width: 2),
      ),
      height: Get.height,
      width: Get.width * 0.6,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  //crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        width: Get.width * 0.3,
                        height: Get.width * 0.3,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(user_login["user_login_avatar"]),
                          ),
                          border: Border.all(color: kaccentColor, width: 1),
                          boxShadow: [
                            BoxShadow(
                              color: kaccentColor.withOpacity(0.4),
                              blurRadius: 6,
                              spreadRadius: 1,
                              //offset: const Offset(3, 2),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0, bottom: 3, left: 10),
                      child: Text(user_login["user_login_name"],
                          style: TextStyle(fontWeight:FontWeight.bold,
                                            wordSpacing: 2,
                                            letterSpacing: 0.5,
                                            fontSize:Get.textScaleFactor * 20 )
                                            ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0, left: 10),
                      child:Text(user_login["user_login_email"],
                                  style: TextStyle(color: Colors.blue,fontSize: Get.textScaleFactor))
                    ),
                    const Divider(
                      thickness: 1,
                    ),
                    InkWell(
                      onTap: () {
                        Get.toNamed('/profilepage');
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 10.0, bottom: 20, left: 10),
                        child: Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(right: 15.0),
                              child: Icon(Icons.person),
                            ),
                            'Hồ sơ'
                                .text
                                .wordSpacing(3)
                                .fontWeight(FontWeight.w600)
                                .minFontSize(13)
                                .make(),
                          ],
                        ),
                      ),
                    ),
                    // InkWell(
                    //   onTap: () {
                    //
                    //   },
                    //   child: Padding(
                    //     padding: const EdgeInsets.only(
                    //         top: 10.0, bottom: 20, left: 10),
                    //     child: Row(
                    //       // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    //       children: [
                    //         const Padding(
                    //           padding: EdgeInsets.only(right: 15.0),
                    //           child: Icon(Icons.bookmark),
                    //         ),
                    //         'Cài đặt'
                    //             .text
                    //             .wordSpacing(3)
                    //             .fontWeight(FontWeight.w600)
                    //             .minFontSize(13)
                    //             .make(),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                    // InkWell(
                    //   onTap: () {Get.toNamed('/myorder');},
                    //   child: Padding(
                    //     padding: const EdgeInsets.only(
                    //         top: 10.0, bottom: 20, left: 10),
                    //     child: Row(
                    //       // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    //       children: [
                    //         const Padding(
                    //           padding: EdgeInsets.only(right: 15.0),
                    //           child: Icon(
                    //             Icons.list_alt_outlined,
                    //           ),
                    //         ),
                    //         'Đơn vận chuyển'
                    //             .text
                    //             .wordSpacing(3)
                    //             .fontWeight(FontWeight.w600)
                    //             .minFontSize(13)
                    //             .make(),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                    InkWell(
                      onTap: () {
                        Get.offAllNamed('/signinpage');
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 10.0, bottom: 20, left: 10),
                        child: Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(right: 15.0),
                              child: Icon(Icons.logout_outlined),
                            ),
                            'Đăng xuất'
                                .text
                                .color(kaccentColor)
                                .wordSpacing(3)
                                .fontWeight(FontWeight.w600)
                                .minFontSize(13)
                                .make(),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: Get.height * 0.1,
                ),
                // InkWell(
                //     onTap: () {},
                //     child: Container(
                //         height: Get.height * 0.07,
                //         decoration: BoxDecoration(
                //           borderRadius: BorderRadius.circular(12),
                //           color: Colors.amber,
                //         ),
                //         child: 'Change Color Theme'
                //             .text
                //             .minFontSize(Get.textScaleFactor * 16)
                //             .bold
                //             .letterSpacing(1.5)
                //             .makeCentered()))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
