import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../app/models/usermodel.dart';
import '../../common/session.dart';
import '../../designs/widgets/user_card.dart';
class MyUserPage extends StatefulWidget {
  const MyUserPage({Key? key}) : super(key: key);
  @override
  State<MyUserPage> createState() => MyUserPageState();
}
class MyUserPageState extends State<MyUserPage>{
  var user_login;
  LoadData() async {
    var data_login= (await Session_Login().getSession_Login());
    setState(() {
      user_login=data_login;
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    LoadData();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        (user_login==null?SizedBox(height:1):User_Card(
          name:user_login["user_login_name"],
          avatar:user_login["user_login_avatar"],
          bgavatar:user_login["user_login_bgavatar"],
          onTap: () {Get.offAllNamed('/profilepage');},
        ))
      ],
    );
  }
}
