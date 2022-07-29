import 'dart:math';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shipper/common/constants.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../app/controllers/postscontroller.dart';
import '../../app/controllers/userscontroller.dart';
import '../../app/models/postmodel.dart';
import '../../common/session.dart';
import '../../designs/widgets/post_widget.dart';
import '../order/orders.dart';
class UserDetailPage extends StatefulWidget {
  const UserDetailPage({
    Key? key,
    required this.user_id
  }) : super(key: key);
  final String user_id;
  @override
  State<UserDetailPage> createState() => UserDetailPageState();
}
class UserDetailPageState extends State<UserDetailPage>{
  var info_user;
  _getSession() async {
    var infouser= await UsersController().InfoUser(widget.user_id);
    setState(() {
      info_user=infouser;
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
        title: const Text("Thông Tin Người Dùng"),
      ),
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child:info_user==null?SizedBox(height:1):Column(
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
                      image: NetworkImage(info_user["bgavatar"]),
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
                      NetworkImage(info_user["avatar"]),
                      radius: Get.height * 0.1,
                    ),
                  ),
                ),
                Positioned(
                  left: 150,
                  bottom: 75,
                  child: Column(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(info_user["name"],
                              style: TextStyle(fontWeight:FontWeight.bold,
                                  wordSpacing: 2,
                                  letterSpacing: 0.5,
                                  fontSize:Get.textScaleFactor * 18
                              )
                          ),
                          Padding(
                            padding: const EdgeInsets.all(1),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  info_user["ranks"][0]["name"]!=null?Text(info_user["ranks"][0]["name"],style: TextStyle(fontSize: 14)):SizedBox(height:1),
                                  info_user["phone"]!=null?Text(info_user["phone"],style: TextStyle(fontSize: 14)):SizedBox(height:1),
                                  info_user["email"]!=null?Text(info_user["email"],style: TextStyle(fontSize: 14)):SizedBox(height:1),
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
          ],
        ),
      ),
    );
  }
}
