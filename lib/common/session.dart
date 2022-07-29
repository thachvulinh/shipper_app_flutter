import 'dart:convert';
import 'package:flutter_session/flutter_session.dart';
import 'constants.dart';
class Session_Login{
  final session = FlutterSession();
  setSession_Login(data) async {
    await session.set("user_login_id", data["_id"]);
    await session.set("user_login_name", (data["name"]!=null?data["name"]:''));
    await session.set("user_login_username",(data["username"]!=null?data["username"]:''));
    await session.set("user_login_email",(data["email"]!=null?data["email"]:''));
    await session.set("user_login_phone",(data["phone"]!=null?data["phone"]:''));
    await session.set("user_login_rank_id", data["rank_id"]);
    await session.set("user_login_avatar", (data["avatar"]!=null?data["avatar"]:''));
    await session.set("user_login_bgavatar",(data["bgavatar"]!=null?data["bgavatar"]:''));
    await session.set("user_login_updatedAt", data["updatedAt"]);
  }
  getSession_Login() async {
    var data={
      "user_login_id":await FlutterSession().get("user_login_id"),
      "user_login_name":await FlutterSession().get("user_login_name"),
      "user_login_username":await FlutterSession().get("user_login_username"),
      "user_login_email":await FlutterSession().get("user_login_email"),
      "user_login_phone":await FlutterSession().get("user_login_phone"),
      "user_login_rank_id":await FlutterSession().get("user_login_rank_id"),
      "user_login_avatar":await FlutterSession().get("user_login_avatar"),
      "user_login_bgavatar":await FlutterSession().get("user_login_bgavatar"),
      "user_login_updatedAt":await FlutterSession().get("user_login_updatedAt"),
    };
    return  data;
  }
  removeSession_Login() async {
    await session.set("user_login_id", "");
    await session.set("user_login_name", "");
    await session.set("user_login_username", "");
    await session.set("user_login_email", "");
    await session.set("user_login_phone", "");
    await session.set("user_login_rank_id", "");
    await session.set("user_login_avatar", "");
    await session.set("user_login_bgavatar", "");
    await session.set("user_login_updatedAt", "");
  }
}