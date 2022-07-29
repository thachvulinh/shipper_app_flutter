import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shipper/common/com.dart';
import 'package:shipper/common/socketio.dart';
import 'package:socket_io_client/socket_io_client.dart';
import '../../common/api.dart';
import '../../common/session.dart';

class Info_WebsiteController with ChangeNotifier {
  info_website() async {
    var res=await CallApi().getData("/info_websites/info_use");
    return res;
  }
}
