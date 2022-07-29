import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:get/get.dart';
import 'package:shipper/common/com.dart';
import 'package:shipper/common/socketio.dart';
import 'package:socket_io_client/socket_io_client.dart';
import '../../common/api.dart';
import '../../common/session.dart';
import '../models/usermodel.dart';

class UsersController with ChangeNotifier {
  void update_info(BuildContext context,user_login,String name,String email,String phone,file_avatar,file_bgavatar) async {
    var data= {
      "id":user_login["user_login_id"],
      "_avatar":(file_avatar!=null?'':user_login["user_login_avatar"]),
      "_bgavatar":(file_bgavatar!=null?'':user_login["user_login_bgavatar"]),
      "name":name,
      "email":email,
      "phone":phone,
    };
    var res=await CallApi().postData(data,"/users/update");
    if(res["result"]==1){
      Com().alert_dialog(context,"Thông báo",res["message"]);
    }
    else{
      Com().alert_dialog(context,"Thông báo",res["message"]);
    }
  }
  void change_password(BuildContext context,user_login,String password_old,String password_new,String password_reply) async{
    var data= {
      "id":user_login["user_login_id"],
      "username":user_login["user_login_username"],
      "password":password_old,
      "password_new":password_new,
      "password_reply":password_reply,
    };
    var res=await CallApi().postData(data,"/users/update_password");
    if(res["result"]==1){
      Com().alert_dialog(context,"Thông báo",res["message"]);
    }
    else{
      Com().alert_dialog(context,"Thông báo",res["message"]);
    }
  }
  void loginSubmit(BuildContext context,socket,String username,String password) async{
    var data= {
      "type":"shipper",
      "username":username,
      "password":password,
    };
    var res=await CallApi().postData(data,"/users/login");
    if(res["result"]==1){
      await Session_Login().setSession_Login(res["data"]);
      socket.emit("client_send_user_id",res["data"]["_id"]);
      Get.offAllNamed('/wrapper');
    }
    else{
      Com().alert_dialog(context,"Thông báo",res["data"]);
    }
  }
  GetListUser(user_id) async {
    var res=await CallApi().getData("/users/list_shipper?user_id="+user_id);
    return res;
  }
  InfoUser(String user_id) async {
    var res=await CallApi().getData("/users/info/"+user_id);
    return res;
  }

}

