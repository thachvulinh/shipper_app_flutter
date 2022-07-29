
import 'package:socket_io_client/socket_io_client.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../app/controllers/chatscontroller.dart';
import '../../app/controllers/userscontroller.dart';
import '../../app/models/usermodel.dart';
import '../../common/constants.dart';
import '../../common/session.dart';
import '../../common/socketio.dart';
import '../../designs/widgets/inputtext.dart';
import '../../designs/widgets/msgbox.dart';

class MsgsScreen extends StatefulWidget {
  const MsgsScreen({
    Key? key,
    required this.send_user_id,
     this.id_socket_send
  }) : super(key: key);
  final String send_user_id;
  final String? id_socket_send;
  @override
  State<MsgsScreen> createState() => MsgsScreenState();
}
class MsgsScreenState extends State<MsgsScreen>{
  TextEditingController msgController=new TextEditingController();
  ScrollController _scrollController = new ScrollController();
  var user_login;
  var info_user_send;
  var listchat_user;
  bool _needsScroll = false;
  LoadData() async {
    var data_login= (await Session_Login().getSession_Login());
    var inforusersend= await UsersController().InfoUser(widget.send_user_id);
    var listchatuser=await ChatsController().ListChat_User(data_login["user_login_id"], inforusersend["_id"]);
    setState(() {
      user_login=data_login;
      info_user_send=inforusersend;
      listchat_user=listchatuser;
    });
  }
  late Socket socket;
  @override
  void initState() {
    socket=SocketIO().connectToServer();
    socket.on('send',(data){
      if (this.mounted) {
        setState(() {
          listchat_user.add(data["server"]["row_new"]);
        });
      }
    });
    super.initState();
    LoadData();

  }
  void ScrollTopBottom(){
    if (_scrollController.hasClients) {
      final position = _scrollController.position.maxScrollExtent;
      _scrollController.animateTo(
        position,
        duration: Duration(seconds: 1),
        curve: Curves.easeOut,
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(milliseconds: 300), () {
      _needsScroll = true;
    });
    if (_needsScroll) {
      Future.delayed(const Duration(milliseconds: 500), () {
        ScrollTopBottom();
      });
      _needsScroll = false;
    }
    _buildRow_ListChat(int index) {
      if(listchat_user[index]["user_id"]==user_login["user_login_id"]){
        return MsgBox(type:"right",name: listchat_user[index]["users"][0]["name"],avatar: listchat_user[index]["users"][0]["avatar"],msg:listchat_user[index]["content"]);
      }
      else{
        return MsgBox(type:"left",name: listchat_user[index]["users"][0]["name"],avatar: listchat_user[index]["users"][0]["avatar"],msg:listchat_user[index]["content"]);
      }
    }
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.9),
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        //centerTitle: true,
        actions: [
          info_user_send==null?SizedBox(height:1):
          Padding(
            padding: const EdgeInsets.all(8.0),
            child:CircleAvatar(
              backgroundColor: ktxtwhiteColor,
              child: CircleAvatar(
                backgroundImage: NetworkImage(info_user_send["avatar"]),
                radius: 22,
              ),
            ),
          )
        ],
        title: Text(info_user_send==null?"":info_user_send["name"]),
      ),
      body: SingleChildScrollView(
        reverse: true,
        child: Column(
          children: [
            listchat_user==null?Container(height: Get.height * 0.8):
             Container(
              margin: const EdgeInsets.only(bottom: 5),
              height: Get.height * 0.8,
              color: Colors.white10,
              child: ListView.builder(
                controller: _scrollController,
                // reverse: true,
                // shrinkWrap: true,
                itemBuilder: ((context, index) {
                  return _buildRow_ListChat(index);
                }),
                itemCount: listchat_user.length,
              ),
            ),
            CustomTextInputWidget(
              msgController:msgController,
              onChanged:(text){

              },
              performFunc: (){
                ChatsController().InsertChat(context,socket,user_login, info_user_send["_id"], msgController.text,widget.id_socket_send);
                msgController.text="";
                _needsScroll = true;
                FocusScopeNode currentFocus = FocusScope.of(context);
                if (!currentFocus.hasPrimaryFocus) {
                  currentFocus.unfocus();
                }
              },
            ),
          ],
        ),
      ),
      // floatingActionButton: new FloatingActionButton(
      //     child: new Icon(Icons.align_vertical_bottom),
      //     onPressed: () {
      //       ScrollTopBottom();
      //     }
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
    );
  }
}
