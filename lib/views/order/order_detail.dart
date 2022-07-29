import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shipper/app/controllers/userscontroller.dart';
import 'package:http/http.dart' as http;
import 'package:velocity_x/velocity_x.dart';

import '../../app/controllers/orderscontroller.dart';
import '../../common/com.dart';
import '../../common/constants.dart';
import '../../common/session.dart';
import '../../designs/controls/signin_button.dart';
import '../../designs/controls/custom_input.dart';
import 'delivery_fee.dart';
class OrderDetailPage extends StatefulWidget {
  const OrderDetailPage({
    Key? key,
    required this.order_id
  }) : super(key: key);
  final String order_id;
  @override
  State<OrderDetailPage> createState() => OrderDetailPageState();
}
class OrderDetailPageState extends State<OrderDetailPage>{
  var user_login;
  var info_order;
  _getSession() async {
    var data_login= (await Session_Login().getSession_Login());
    var info_myorder= await OrdersController().info_myorder(widget.order_id);
    setState(() {
      user_login=data_login;
      info_order=info_myorder;
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getSession();
  }
  @override
  Widget build(BuildContext context) {
    Widget _buildWap(item){
      return item["images"] == null ?SizedBox(height: 1) :Center(child:Wrap(
        children: item["images"].map<Widget>((imageone) {
          return Container(
              child:Card(
                child: Container(
                  height: 120, width:120,
                  child: Image.network(imageone),
                ),
              )
          );
        }).toList(),
      ));
    }
    Widget _buildRow(item){
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 5.0),
        child:Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(item["createdAt"]+":  ",style: TextStyle(fontSize:12,fontWeight: FontWeight.bold)),
                  Expanded(
                    flex: 2,
                    child:Text(item["content"],style: TextStyle(fontSize:12)),
                  ),
                ],
              ),
              InkWell(
                  onTap: () {
                  },
                  child:_buildWap(item)
              )
           ]
        )
      );
    }
    return Scaffold(
        backgroundColor: Colors.white.withOpacity(0.9),
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          leading: new IconButton(onPressed:(){Get.offAllNamed('/myorder');}, icon:const Icon(Icons.arrow_left_outlined),color: Colors.white),
          centerTitle: true,
          title: const Text("Chi tiết đơn hàng vận chuyển"),
        ),
        body:(info_order==null?SizedBox(
          child: 'Không có đơn vận chuyển'.text.makeCentered(),
          height: Get.height * 0.3,
        ):SingleChildScrollView(
            child:Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                        child:Padding(
                          padding: EdgeInsets.all(7),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white12,
                              border: Border.all(color:Colors.black12),
                              image: DecorationImage(
                                image:NetworkImage(
                                  info_order["info"]["image"],
                                ),
                                fit: BoxFit.fill,
                              ),
                            ),
                            height:150,
                          ),
                        )
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      child:Padding(
                        padding: const EdgeInsets.all(5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children:<Widget> [
                            Text(info_order["info"]["name"],
                              style:const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0,
                              ),
                            ),
                            (info_order["info"]["color"]==""?SizedBox(height:1):
                            Text("Loại: "+info_order["info"]["color"],
                              style:const TextStyle(
                                fontWeight: FontWeight.w300,
                                fontSize: 14.0,
                              ),
                            )),
                            (info_order["info"]["condition1"]==""?SizedBox(height:1):
                            Text(info_order["info"]["condition1"]+":"+info_order["info"]["value_condition1"],
                              style:const TextStyle(
                                fontWeight: FontWeight.w300,
                                fontSize: 14.0,
                              ),
                            )),
                            (info_order["info"]["condition2"]==""?SizedBox(height:1):
                            Text(info_order["info"]["condition2"]+":"+info_order["info"]["value_condition2"],
                              style:const TextStyle(
                                fontWeight: FontWeight.w300,
                                fontSize: 14.0,
                              ),
                            )),
                          ],
                        ),
                      )
                    ),
                  ],
                ),
                Padding(padding: EdgeInsets.all(9),
                    child:Container(
                        decoration: BoxDecoration(
                          //color: Colors.white12,
                          border: Border.all(color:Colors.black38),
                        ),
                        child:Padding(
                          padding:EdgeInsets.zero,
                          child:Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(padding: EdgeInsets.only(left:5 ,top: 1,bottom: 5),child:Text("Thông tin đơn hàng",style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color:Colors.red ))),
                              Divider(height: 1,color: Colors.black),
                              Padding(
                                  padding:EdgeInsets.only(left: 10),
                                  child: Row(
                                      children: [
                                        Padding(padding: EdgeInsets.zero,child:Text("Mã đơn hàng :",style: const TextStyle(fontWeight: FontWeight.bold),)),
                                        Expanded(child:Padding(padding:EdgeInsets.only(left: 5) ,child:Text(info_order["info"]["_id"]))),
                                      ])
                              ),
                              Padding(
                                  padding:EdgeInsets.only(left: 10),
                                  child: Row(
                                      children: [
                                        Padding(padding: EdgeInsets.zero,child:Text("Tình trạng đơn hàng :",style: const TextStyle(fontWeight: FontWeight.bold),)),
                                        Expanded(child:Padding(padding:EdgeInsets.only(left: 5) ,child:Text(info_order["info"]["str_status"]))),
                                      ])
                              ),
                              SizedBox(height: 5),
                              Padding(
                                  padding:EdgeInsets.only(left: 10),
                                  child: Row(
                                      children: [
                                        Padding(padding: EdgeInsets.zero,child:Text("Đơn hàng :",style: const TextStyle(fontWeight: FontWeight.bold),)),
                                        Expanded(child:Padding(padding:EdgeInsets.only(left: 5) ,child:Text(info_order["info"]["paid"]))),
                                      ])
                              ),
                              SizedBox(height: 5),
                              Padding(
                                  padding:EdgeInsets.only(left: 10),
                                  child: Row(
                                      children: [
                                        Padding(padding: EdgeInsets.zero,child:Text("Thanh toán: ",style: const TextStyle(fontWeight: FontWeight.bold),)),
                                        Expanded(child:Padding(padding:EdgeInsets.only(left: 5) ,child:Text(info_order["info"]["payment"]))),
                                      ])
                              ),
                              SizedBox(height: 5),
                              Padding(
                                  padding:EdgeInsets.only(left: 10),
                                  child: Row(
                                      children: [
                                        Padding(padding: EdgeInsets.zero,child:Text("Ngày đặt: ",style: const TextStyle(fontWeight: FontWeight.bold),)),
                                        Expanded(child:Padding(padding:EdgeInsets.only(left: 5) ,child:Text(info_order["info"]["createdAt"]))),
                                      ])
                              ),
                              SizedBox(height: 5),
                            ],
                          ) ,
                        )
                    )
                ),
                Padding(padding: EdgeInsets.all(9),
                    child:Container(
                        decoration: BoxDecoration(
                          //color: Colors.white12,
                          border: Border.all(color:Colors.black38),
                        ),
                        child:Padding(
                          padding:EdgeInsets.zero,
                          child:Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(padding: EdgeInsets.only(left:5 ,top: 1,bottom: 5),child:Text("Giá đơn hàng",style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color:Colors.red ))),
                              Divider(height: 1,color: Colors.black),
                              Padding(
                                  padding:EdgeInsets.only(left: 10),
                                  child: Row(
                                      children: [
                                        Padding(padding: EdgeInsets.zero,child:Text("Giá sản phẩm :",style: const TextStyle(fontWeight: FontWeight.bold),)),
                                        Expanded(child:Padding(padding:EdgeInsets.only(left: 5) ,child:Text(info_order["info"]["str_price"]))),
                                      ])
                              ),
                              SizedBox(height: 5),
                              Padding(
                                  padding:EdgeInsets.only(left: 10),
                                  child: Row(
                                      children: [
                                        Padding(padding: EdgeInsets.zero,child:Text("Số lượng :",style: const TextStyle(fontWeight: FontWeight.bold),)),
                                        Expanded(child:Padding(padding:EdgeInsets.only(left: 5) ,child:Text(info_order["info"]["str_quantity"]))),
                                      ])
                              ),
                              SizedBox(height: 5),
                              Padding(
                                  padding:EdgeInsets.only(left: 10),
                                  child: Row(
                                      children: [
                                        Padding(padding: EdgeInsets.zero,child:Text("Phí giao hàng :",style: const TextStyle(fontWeight: FontWeight.bold),)),
                                        Expanded(child:Padding(padding:EdgeInsets.only(left: 5) ,child:Text(info_order["info"]["str_delivery_price"]))),
                                      ])
                              ),
                              SizedBox(height: 5),
                              Padding(
                                  padding:EdgeInsets.only(left: 10),
                                  child: Row(
                                      children: [
                                        Padding(padding: EdgeInsets.zero,child:Text("Tổng tiền cần thanh toán :",style: const TextStyle(fontWeight: FontWeight.bold),)),
                                        Expanded(child:Padding(padding:EdgeInsets.only(left: 5) ,child:Text(info_order["info"]["str_total_price"]))),
                                      ])
                              ),
                              SizedBox(height: 5),
                            ],
                          ) ,
                        )
                    )
                ),
                Padding(padding: EdgeInsets.all(9),
                  child:Container(
                    decoration: BoxDecoration(
                      //color: Colors.white12,
                      border: Border.all(color:Colors.black38),
                    ),
                    child:Padding(
                      padding:EdgeInsets.zero,
                      child:Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(padding: EdgeInsets.only(left:5 ,top: 1,bottom: 5),child:Text("Địa chỉ giao hàng",style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color:Colors.red ))),
                          Divider(height: 1,color: Colors.black),
                          Padding(
                              padding:EdgeInsets.only(left: 10),
                              child: Row(
                                children: [
                                  Padding(padding: EdgeInsets.zero,child:Text("Địa chỉ :",style: const TextStyle(fontWeight: FontWeight.bold),)),
                                  Expanded(child:Padding(padding:EdgeInsets.only(left: 5) ,child:Text(info_order["info"]["receiver_address"]))),
                              ])
                          ),
                          SizedBox(height: 5),
                          Padding(
                              padding:EdgeInsets.only(left: 10),
                              child: Row(
                                  children: [
                                    Padding(padding: EdgeInsets.zero,child:Text("Postcode :",style: const TextStyle(fontWeight: FontWeight.bold),)),
                                    Expanded(child:Padding(padding:EdgeInsets.only(left: 5) ,child:Text(info_order["info"]["receiver_postcode"]))),
                                  ])
                          ),
                          SizedBox(height: 5),
                          Padding(
                              padding:EdgeInsets.only(left: 10),
                              child: Row(
                                  children: [
                                    Padding(padding: EdgeInsets.zero,child:Text("Người nhận :",style: const TextStyle(fontWeight: FontWeight.bold),)),
                                    Expanded(child:Padding(padding:EdgeInsets.only(left: 5) ,child:Text(info_order["info"]["receiver"]))),
                                  ])
                          ),
                          SizedBox(height: 5),
                          Padding(
                              padding:EdgeInsets.only(left: 10),
                              child: Row(
                                  children: [
                                    Padding(padding: EdgeInsets.zero,child:Text("Điện thoại :",style: const TextStyle(fontWeight: FontWeight.bold),)),
                                    Expanded(child:Padding(padding:EdgeInsets.only(left: 5) ,child:Text(info_order["info"]["receiver_phone"]))),
                                  ])
                          ),
                          SizedBox(height: 5),
                        ],
                      ) ,
                    )
                  )
                ),
                info_order["list_order_diary"]==null || info_order["list_order_diary"].toString()=="[]" ?
                SizedBox(height: 1)
                :Padding(
                  padding: EdgeInsets.all(9),
                    child:Container(
                      decoration: BoxDecoration(border: Border.all(color:Colors.black38)),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(padding: EdgeInsets.only(left:5 ,top: 1,bottom: 5),child:Text("Nhật ký đơn hàng",style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color:Colors.red ))),
                            Divider(height: 1,color: Colors.black),
                            Padding(
                              padding:EdgeInsets.only(left: 5),
                              child:ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: (info_order["list_order_diary"]!=null?info_order["list_order_diary"].length:0),
                                itemBuilder: (context, index) {
                                  return _buildRow(info_order["list_order_diary"][index]);
                                },
                              )
                            )
                          ]),
                    )
                ),
                (info_order["info"]["status"]==2?Padding(
                  padding: EdgeInsets.all(9),
                  child:SigninButton(
                    child: Text("Tiến hành giao hàng", style: TextStyle(fontFamily: "RobotoMedium", fontSize: 16, color: Colors.white)),
                    onPressed: () {
                      Navigator.of(context).push(
                          new MaterialPageRoute(builder: (BuildContext context){
                            return DeliveryFeePage(order_id:widget.order_id);
                          })
                      );
                    },
                  ),
                ):Padding(padding: EdgeInsets.zero))
              ],
            )
        ))
    );
  }
}
