import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shipper/app/controllers/userscontroller.dart';
import 'package:http/http.dart' as http;
import 'package:velocity_x/velocity_x.dart';

import '../../common/com.dart';
import '../../common/constants.dart';
import '../../common/session.dart';
import '../../designs/controls/camera/camera_screen.dart';
import '../../designs/controls/signin_button.dart';
import '../../designs/controls/custom_input.dart';
import 'order_detail.dart';
class DeliveryFeePage extends StatefulWidget {
  const DeliveryFeePage({
    Key? key,
    required this.order_id
  }) : super(key: key);
  final String order_id;
  @override
  State<DeliveryFeePage> createState() => DeliveryFeePageState();
}
class DeliveryFeePageState extends State<DeliveryFeePage>{
  var user_login;
  final ImagePicker imgpicker = ImagePicker();
  List<XFile>? imagefiles;
  TextEditingController contentController = new TextEditingController() ;
  TextEditingController signController = new TextEditingController();
  _getSession() async {
    var data_login= (await Session_Login().getSession_Login());
    setState(() {
      user_login=data_login;
      contentController=TextEditingController(text:"Đã giao hàng" );
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getSession();
  }
  void BackOrder()  {
    Navigator.of(context).push(
      new MaterialPageRoute(builder: (BuildContext context){
        return OrderDetailPage(order_id:widget.order_id);
      })
    );
  }
  Future chooseImage() async {
    try {
      var pickedfiles = await imgpicker.pickMultiImage();
      //you can use ImageCourse.camera for Camera capture
      if(pickedfiles != null){
        imagefiles = pickedfiles;
        setState(() {
        });
      }else{
        print("Không có lựa chọn hình ảnh.");
      }
    }catch (e) {
      print("Lỗi khi chọn tập tin.");
    }
  }
  Future CompletedOrders() async {
    List<http.MultipartFile> images = [];
    if(imagefiles!=null) {
      for (int i = 0; i < imagefiles!.length; i++) {
        File imageFile = File(imagefiles![i].path);
        var stream = new http.ByteStream(imageFile.openRead());
        stream.cast();
        var length = await imageFile.length();
        var multipartFile = new http.MultipartFile("images", stream, length);
        images.add(multipartFile);
      }
    }
    var url=Uri.parse(url_server+"/orders/change_status");
    var request=new http.MultipartRequest("POST", url);
    request.fields['user_id']=user_login["user_login_id"];
    request.fields['order_id']=widget.order_id;
    request.fields['status']="2";
    request.fields['content']=contentController.text;
    if(imagefiles!=null){
      request.files.addAll(images);
    }
    http.Response response = await http.Response.fromStream(await request.send());
    if(response.statusCode==200){
      var body= json.decode(response.body);
      Com().alert_dialog_button1(context,"Thông báo","Thành công","Quay lại đơn hàng",(){BackOrder();});
    }
    else{
      Com().alert_dialog(context,"Thông báo","Thất bại");
    }
  }
  @override
  Widget build(BuildContext context) {
    final users_ctr = UsersController();
    return Scaffold(
        backgroundColor: Colors.white.withOpacity(0.9),
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          leading: new IconButton(onPressed:(){
            BackOrder();
          }, icon:const Icon(Icons.arrow_left_outlined),color: Colors.white),
          centerTitle: true,
          title: const Text("Tiến hành giao hàng"),
        ),
        body:SingleChildScrollView(
            child:Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 15,right: 15,top: 30,bottom: 180),
                  child: Container(
                      decoration: BoxDecoration(
                        border:  Border.all(color:Colors.black12),
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      child:Padding(
                        padding: EdgeInsets.all(15),
                        child: Column(
                          children: [
                            // InkWell(
                            //     onTap: () {
                            //       Navigator.of(context).push(
                            //           new MaterialPageRoute(builder: (BuildContext context){
                            //             return CameraScreen();
                            //           })
                            //       );
                            //     },
                            //     child: Container(
                            //       child: Column(
                            //           mainAxisAlignment: MainAxisAlignment.end,
                            //           children: [
                            //             const Icon(
                            //               Icons.upload_outlined,
                            //               size: 50,
                            //               color: kMainColor,
                            //             ),
                            //             'Mở máy ảnh'.text.make(),
                            //           ])
                            //     )
                            // ),
                            InkWell(
                              onTap: () {
                                chooseImage();
                              },
                              child:
                              imagefiles == null ? Container(
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      const Icon(
                                        Icons.upload_outlined,
                                        size: 50,
                                        color: kMainColor,
                                      ),
                                      'Chọn một hoặc nhiều hình giao hàng'.text.make(),
                                    ]),
                              )
                                  : Wrap(
                                children: imagefiles!.map((imageone){
                                  return Container(
                                      child:Card(
                                        child: Container(
                                          height: 120, width:120,
                                          child: Image.file(File(imageone.path)),
                                        ),
                                      )
                                  );
                                }).toList(),
                              )
                            ),
                            CustomInput(
                                controller: contentController,
                                title: 'Nhập tiến trình',

                            ),
                            SigninButton(
                              child: Text("Hoàn tất giao hàng", style: TextStyle(fontFamily: "RobotoMedium", fontSize: 16, color: Colors.white)),
                              onPressed: () {
                                CompletedOrders();
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
