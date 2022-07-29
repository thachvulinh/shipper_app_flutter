import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shipper/common/com.dart';
import '../../common/api.dart';
import '../../common/session.dart';

class ChatsController with ChangeNotifier {
  void InsertChat(BuildContext context,socket,user_login,String send_user_id,String content,String? id_socket_send) async{
    var data= {
      "user_id":user_login["user_login_id"],
      "send_user_id":send_user_id,
      "content":content,
    };
    if(content==""){
      Com().alert_dialog(context,"Thông báo","Vui lòng nhập tin nhắn");
      return;
    }
    var res=await CallApi().postData(data,"/chats/insert");
    if(res["result"]==1){
        socket.emit('send', { "user_id": user_login["user_login_id"],
                              "send_user_id": send_user_id,
                              "message": content,
                              "name_user": user_login["user_login_name"],
                              "avatar_user": user_login["user_login_avatar"],
                              "row_new": res["row_new"],
                              "list_message_new": res["data"],
                              "id_socket_send": id_socket_send,
                            });
    }
    else{
      Com().alert_dialog(context,"Thông báo",res["data"]);
    }
  }
  ListChat_User(String user_id,String send_user_id) async {
    var data= {
      "user_id":user_id,
      "send_user_id":send_user_id,
    };
    var res=await CallApi().postData(data,"/chats/list_chat_user_id");
    return res;
  }
}
