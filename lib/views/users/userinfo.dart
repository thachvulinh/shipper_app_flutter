import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shipper/app/controllers/userscontroller.dart';
import 'package:http/http.dart' as http;

import '../../common/com.dart';
import '../../common/constants.dart';
import '../../common/session.dart';
import '../../designs/controls/signin_button.dart';
import '../../designs/controls/custom_input.dart';
import '../../designs/widgets/src/rotating_circle.dart';
class UserInfoPage extends StatefulWidget {
  const UserInfoPage({Key? key}) : super(key: key);
  @override
  State<UserInfoPage> createState() => UserInfoPageState();
}
class UserInfoPageState extends State<UserInfoPage>{
  var user_login;
  TextEditingController nameController = new TextEditingController() ;
  TextEditingController emailController = new TextEditingController();
  TextEditingController phoneController = new TextEditingController();
  _getSession() async {
    var data_login= (await Session_Login().getSession_Login());
    setState(() {
      user_login=data_login;
      nameController=TextEditingController(text:user_login["user_login_name"] );
      emailController=TextEditingController(text:user_login["user_login_email"] );
      phoneController=TextEditingController(text:user_login["user_login_phone"] );
    });
  }
  ImagePicker picker = ImagePicker();
  File? file_avatar;
  File? file_bgavatar;
  Future chooseImageAvatar() async {
    var file;
    file = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (file != null) {
        file_avatar = File(file.path);
      } else {
        debugPrint('File not Picked');
      }
    });
  }
  Future chooseImageBgAvatar() async {
    var file;
    file = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (file != null) {
        file_bgavatar = File(file.path);
      } else {
        debugPrint('File not Picked');
      }
    });
  }
  Future Update_Users() async {
    var multiport_avatar;
    var multiport_bgavatar;
    if(file_avatar!=null){
      var stream_avatar=new http.ByteStream(file_avatar!.openRead());
      stream_avatar.cast();
      var length_avatar=await file_avatar!.length();
      multiport_avatar=new http.MultipartFile('avatar',stream_avatar,length_avatar);
    }
    if(file_bgavatar!=null){
      var stream_bgavatar=new http.ByteStream(file_bgavatar!.openRead());
      stream_bgavatar.cast();
      var length_bgavatar=await file_bgavatar!.length();
      multiport_bgavatar=new http.MultipartFile('bgavatar',stream_bgavatar,length_bgavatar);
    }
    var url=Uri.parse(url_server+"/users/update");
    var request=new http.MultipartRequest("POST", url);
    request.fields['id']=user_login["user_login_id"];
    request.fields['_avatar']=(file_avatar!=null?'':user_login["user_login_avatar"]);
    request.fields['_bgavatar']=(file_bgavatar!=null?'':user_login["user_login_bgavatar"]);
    request.fields['name']=nameController.text;
    request.fields['email']=emailController.text;
    request.fields['phone']=phoneController.text;
    if(file_avatar!=null){
      request.files.add(multiport_avatar);
    }
    if(file_bgavatar!=null){
      request.files.add(multiport_bgavatar);
    }
    http.Response response = await http.Response.fromStream(await request.send());
    if(response.statusCode==200){
        var body= json.decode(response.body);
        await Session_Login().setSession_Login(body["data"]);
        Com().alert_dialog(context,"Thông báo","Thành công");
    }
    else{
      Com().alert_dialog(context,"Thông báo","Thất bại");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getSession();
  }
  @override
  Widget build(BuildContext context) {
    final users_ctr = UsersController();
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.9),
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: new IconButton(onPressed:(){Get.offAllNamed('/profilepage');}, icon:const Icon(Icons.arrow_left_outlined),color: Colors.white),
        centerTitle: true,
        // actions: [
        //   Padding(
        //     padding: const EdgeInsets.all(8.0),
        //     child: CircleAvatar(
        //       radius: 25,
        //       backgroundImage: NetworkImage(user_login["user_login_avatar"]),
        //     ),
        //   )
        // ],
        title: const Text("Thông tin"),
      ),
      body:user_login==null?SpinKitRotatingCircle(color: Colors.white):SingleChildScrollView(
          child:Column(
            children: [
            Stack(
              children: [
                Container(
                  height: Get.height * 0.4,
                ),
                InkWell(
                  onTap: (){chooseImageBgAvatar();},
                  child:(file_bgavatar==null?Container(
                    decoration: BoxDecoration(
                      color: Colors.white12,
                      border: Border.all(color:Colors.black12),
                      image: DecorationImage(
                        image:NetworkImage(
                          user_login["user_login_bgavatar"],
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                    height: Get.height * 0.25,
                  ):Container(
                    decoration: BoxDecoration(
                      color: Colors.white12,
                      border: Border.all(color:Colors.black12),
                      image: DecorationImage(
                        image:FileImage(file_bgavatar!),
                        fit: BoxFit.cover,
                      ),
                    ),
                    height: Get.height * 0.25,
                  )),
                ),
                Positioned(
                  left: Get.width * 0.2,
                  right: Get.width * 0.2,
                  bottom: 15,
                  child:InkWell(
                      onTap: (){chooseImageAvatar();},
                      child:CircleAvatar(
                      backgroundColor: ktxtwhiteColor,
                      radius: Get.height * 0.105,
                      child:(file_avatar==null?CircleAvatar(
                        backgroundImage:NetworkImage(user_login["user_login_avatar"]),
                        radius: Get.height * 0.1,
                      ):CircleAvatar(
                        backgroundImage:FileImage(file_avatar!),
                        radius: Get.height * 0.1,
                      )) ,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(left: 15,right: 15,top: 5,bottom: 180),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border:  Border.all(color:Colors.black26),
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                child:Padding(
                  padding: EdgeInsets.all(15),
                  child: Column(
                    children: [
                      CustomInput(
                        controller: nameController,
                        title: 'Họ và tên',
                      ),
                      CustomInput(
                        controller: emailController,
                        title: 'Email',
                      ),
                      CustomInput(
                        controller: phoneController,
                        title: 'Số điện thoại',
                      ),
                      SigninButton(
                        child: Text("Cập nhật", style: TextStyle(fontFamily: "RobotoMedium", fontSize: 16, color: Colors.white)),
                        onPressed: () {
                          Update_Users();
                          // users_ctr.update_info(context,
                          //                       user_login,
                          //                       nameController.text,
                          //                       emailController.text,
                          //                       phoneController.text,file_avatar,file_bgavatar);
                        },
                      ),
                    ],
                  ),
                )
              ),
            ),
          ],
        )
      )
    );
  }
}
