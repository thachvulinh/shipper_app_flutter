import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shipper/common/com.dart';
import '../../common/api.dart';

class OrdersController with ChangeNotifier {
  list_myorder(user_login,int status) async {
    var data= {
      "id":user_login["user_login_id"],
      "status":status
    };
    var res=await CallApi().postData(data,"/orders/list_myshipper");
    return res;
  }
  info_myorder(id) async {
    var res=await CallApi().getData("/orders/info/"+id);
    return res;
  }
}
