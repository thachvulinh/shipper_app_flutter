import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../app/controllers/userscontroller.dart';
import '../../app/models/usermodel.dart';
import '../../common/constants.dart';
import '../../common/session.dart';
import '../../common/socketio.dart';
import '../../designs/widgets/src/wave.dart';
import '../../designs/widgets/user_card.dart';
import 'msgs.dart';
class ListMessagePage extends StatefulWidget {
  const ListMessagePage({Key? key}) : super(key: key);
  @override
  State<ListMessagePage> createState() => ListMessagePageState();
}
class ListMessagePageState extends State<ListMessagePage>{
  int loading=1;
  late Socket socket;
  var list_user;
  var user_login;
  LoadData() async {
    var data_login= (await Session_Login().getSession_Login());
    var listuser= await UsersController().GetListUser(data_login['user_login_id']);
    socket.emit("client_get_user_id");
    socket.on("server_send_list_user_id", (data) {
      print(data);
      if (this.mounted) {
        setState(() {
          listuser = AppendUserOnline(listuser, data);
        });
      }
    });
    setState(() {
      user_login=data_login;
      list_user=listuser;
    });
  }
  AppendUserOnline(listuser,listuseronline){
    //Future.delayed(const Duration(milliseconds: 1000), () {
      if(listuser!=null){
        for(int i=0;i<listuser.length;i++){
          if(listuseronline!=null) {
            String id_soket="";
            for (int j = 0; j < listuseronline.length; j++) {
              if (listuser[i]["_id"] == listuseronline[j]["user_id"]) {
                id_soket=listuseronline[j]["id"];

              }
            }
            listuser[i]["id_socket"]=id_soket;
          }
        }
      }
    //});
    return listuser ;
  }
  @override
  void initState() {
    socket=SocketIO().connectToServer();
    super.initState();
    LoadData();
  }
  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(milliseconds: 2000), () {
      setState(() {
        loading = 0;
      });
    });
    return SingleChildScrollView(
      physics: const ScrollPhysics(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
        loading==1?Container(width: double.infinity, height: 500,child:SpinKitWave(color: Colors.black, type: SpinKitWaveType.start)):
          list_user==null || list_user.toString()=="[]" ? SizedBox(
            child: 'Không có người dùng'.text.makeCentered(),
            height: Get.height * 0.3,
          ) :ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: (list_user!=null?list_user.length:0),
            itemBuilder: (context, index) {
              return InkWell(child:User_Card(
                id_socket:list_user[index]["id_socket"],
                name:list_user[index]["name"],
                avatar:list_user[index]["avatar"],
                bgavatar:list_user[index]["bgavatar"],
                message:"tin nhắn",
                onTap: (){
                    Navigator.of(context).push(
                        new MaterialPageRoute(builder: (BuildContext context){
                          return MsgsScreen(send_user_id:list_user[index]["_id"],id_socket_send:list_user[index]["id_socket"]);
                        })
                    );
                  }
              ),
              );
            },
          ),
        ],
      ),
    );
  }
}
