import 'dart:math';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shipper/common/constants.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../app/controllers/postscontroller.dart';
import '../../app/models/postmodel.dart';
import '../../common/session.dart';
import '../../designs/widgets/post_widget.dart';
import '../order/orders.dart';
class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);
  @override
  State<ProfilePage> createState() => ProfilePageState();
}
class ProfilePageState extends State<ProfilePage>{
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
    super.initState();
    _getSession();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.9),
      appBar: AppBar(
        leading: new IconButton(onPressed:(){Get.offAllNamed('/wrapper');}, icon:const Icon(Icons.arrow_left_outlined),color: Colors.white),
        centerTitle: true,
        title: const Text("Hồ sơ"),
      ),
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child:user_login==null?SizedBox(height:1):Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(height: Get.height * 0.5,),
                Container(
                  decoration: BoxDecoration(
                    //color: Colors.white12,
                    border: Border.all(color:Colors.black12),
                    image: DecorationImage(
                      image: NetworkImage(
                        user_login["user_login_bgavatar"],
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                  height: Get.height * 0.25,
                ),
                Positioned(
                  left: 10,
                  //right: Get.width * 0.2,
                  bottom: 60,
                  child:CircleAvatar(
                    backgroundColor: ktxtwhiteColor,
                    radius: Get.height * 0.105,
                    child: CircleAvatar(
                      backgroundImage:
                      NetworkImage(user_login["user_login_avatar"]),
                      radius: Get.height * 0.1,
                    ),
                  ),
                ),
                Positioned(
                  left: 150,
                  bottom: 80,
                  child: Column(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(user_login["user_login_name"],
                              style: TextStyle(fontWeight:FontWeight.bold,
                                  wordSpacing: 2,
                                  letterSpacing: 0.5,
                                  fontSize:Get.textScaleFactor * 16
                              )
                          ),
                          Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      '0'.text
                                          .fontWeight(FontWeight.w600)
                                          .minFontSize(16)
                                          .make(),
                                      SizedBox(
                                        width: Get.width * 0.02,
                                      ),
                                      'Đã giao'
                                          .text
                                          .minFontSize(14)
                                          .make(),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: 15,
                                      ),
                                      '0'.text
                                          .fontWeight(FontWeight.w600)
                                          .minFontSize(16)
                                          .make(),
                                      SizedBox(
                                        width: Get.width * 0.02,
                                      ),
                                      'Chưa giao'
                                          .text
                                          .minFontSize(14)
                                          .make(),
                                    ],
                                  ),
                                ]),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Divider(thickness: 1),
            Padding(
              padding: EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 10),
              child: Wrap(
                children: [
                  Padding(
                    padding: EdgeInsets.all(5),
                    child:InkWell(
                      onTap: () {Get.offAllNamed('/userinfo');},
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        child: Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color:Colors.black26),
                            borderRadius: BorderRadius.all(Radius.circular(10))
                          ),
                          child:Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox.fromSize(size: Size.fromRadius(18), child: FittedBox(child: Icon(Icons.perm_contact_cal_rounded))),
                              Center(child:Text("Thông Tin",style: TextStyle(color: Colors.black,fontWeight:FontWeight.bold))),
                            ],
                          )
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(5),
                    child:InkWell(
                      onTap: () {Get.offAllNamed('/changepassword');},
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        child: Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color:Colors.black26),
                              borderRadius: BorderRadius.all(Radius.circular(10))
                          ),
                          child:Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox.fromSize(size: Size.fromRadius(18), child: FittedBox(child: Icon(Icons.lock_open_outlined))),
                                Center(child:Text("Đổi Mật Khẩu",style: TextStyle(color: Colors.black,fontWeight:FontWeight.bold))),
                              ],
                          )
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(5),
                    child:InkWell(
                      onTap: () {Get.offAllNamed('/myorder');},
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        child: Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color:Colors.black26),
                              borderRadius: BorderRadius.all(Radius.circular(10))
                          ),
                          child:Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox.fromSize(size: Size.fromRadius(18), child: FittedBox(child: Icon(Icons.my_library_books_rounded))),
                                Center(child:Text("Đơn Hàng",style: TextStyle(color: Colors.black,fontWeight:FontWeight.bold))),
                              ],
                          )
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
