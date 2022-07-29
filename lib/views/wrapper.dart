import 'package:flutter/material.dart';
import 'package:shipper/app/controllers/userscontroller.dart';
import 'package:shipper/app/models/usermodel.dart';
import 'package:shipper/common/constants.dart';

import '../app/controllers/info_websitecontroller.dart';
import '../app/models/postmodel.dart';
import '../common/session.dart';
import 'layouts/bodyselect.dart';
import 'layouts/bottom_navbar.dart';
import 'layouts/centered_widget.dart';
import 'layouts/drawer.dart';
import 'layouts/floating_button.dart';
class WrapperManager extends StatefulWidget {
  const WrapperManager({Key? key}) : super(key: key);
  @override
  State<WrapperManager> createState() => WrapperManagerState();
}
class WrapperManagerState extends State<WrapperManager>{
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  var user_login;
  var info_website;
  _LoadData() async {
    var data_login= await Session_Login().getSession_Login();
    var infowebsite= await Info_WebsiteController().info_website();
    setState(() {
      user_login=data_login;
      info_website=infowebsite;
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _LoadData();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: kbgColor,
      appBar: AppBar(
        backgroundColor: kmainColor,
        leading: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: GestureDetector(
            onTap: () => _scaffoldKey.currentState?.openDrawer(),
            child:user_login==null?SizedBox(height:1):CircleAvatar(
              backgroundColor: ktxtwhiteColor,
              child: CircleAvatar(
                backgroundImage: NetworkImage(user_login["user_login_avatar"]!),
                radius: 22,
              ),
            ),
          ),
        ),
        centerTitle: true,
        title: const CustomCenterWidget(),
        // actions: [
        //   InkWell(
        //     child: Padding(
        //       padding: const EdgeInsets.all(5.0),
        //       child:info_website==null?SizedBox(height:1):Image.asset(
        //         info_website["logo"],
        //         color: ktxtwhiteColor,
        //       ),
        //     ),
        //   ),
        // ],
      ),
      body: const BodyWidget(),
      bottomNavigationBar: const BottomNavBar(),
       //floatingActionButton: const CustomFloatingActionButton(),
      // floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      drawer: const CustomDrawer(),
    );
  }
}
