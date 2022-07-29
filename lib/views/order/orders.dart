import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:animate_do/animate_do.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../app/controllers/orderscontroller.dart';
import '../../app/controllers/postscontroller.dart';
import '../../common/constants.dart';
import '../../common/session.dart';
import '../../designs/widgets/custom_listitem.dart';
import '../../designs/widgets/post_widget.dart';
import 'order_detail.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({Key? key}) : super(key: key);
  @override
  State<OrderPage> createState() => OrderPageState();
}
class OrderPageState extends State<OrderPage>{
  var user_login;
  var list_order;
  int status= 2;
  _getSession() async {
    var data_login= await Session_Login().getSession_Login();
    var list_myorder= await OrdersController().list_myorder(data_login,status);
    setState(() {
      user_login=data_login;
      list_order=list_myorder;
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
    Widget _buildRow(item){
      return InkWell(
          child:CustomListItem(
            id: item["_id"],
            name: item["name"],
            price:item["str_price"],
            quantity:item["str_quantity"],
            payment:item["payment"],
            delivery_price:item["str_delivery_price"],
            total_price:item["str_total_price"],
            color:item["color"],
            condition1:item["condition1"],
            value_condition1:item["value_condition1"],
            condition2:item["condition2"],
            value_condition2:item["value_condition2"],
            paid:item["paid"],

            receiver: item["receiver"],
            receiver_phone: item["receiver_phone"],
            receiver_address: item["receiver_address"],
            receiver_postcode: item["receiver_postcode"],
            createdAt: item["createdAt"],
            thumbnail: Container(
              //decoration: const BoxDecoration(color: Colors.blue),
              decoration: BoxDecoration(
                color: Colors.white12,
                border: Border.all(color:Colors.black12),
                image: DecorationImage(
                  image: NetworkImage(
                    item["image"],
                  ),
                  fit: BoxFit.fill,
                ),
              ),
              height: 120,
            ),
          ),
          onTap: () {
            Navigator.of(context).push(
                new MaterialPageRoute(builder: (BuildContext context){
                  return OrderDetailPage(order_id:item["_id"]);
                })
            );
          }
      );
    }
    return SingleChildScrollView(
      physics: const ScrollPhysics(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child:Row(
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      status=2;
                      _getSession();
                    });
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    child: Container(
                      height: Get.height * 0.07,
                      width: Get.width * 0.27,
                      color: (status==2?Colors.purpleAccent:Colors.black26),
                      child: Center(child:Text("CHỜ GIAO HÀNG",style: TextStyle(fontWeight:FontWeight.bold,fontSize: 10,color: Colors.white)))
                    ),
                  ),
                ),
                SizedBox(
                  width: 2,
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      status=3;
                      _getSession();
                    });
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    child: Container(
                        height: Get.height * 0.07,
                        width: Get.width * 0.27,
                        color: (status==3?Colors.purpleAccent:Colors.black26),
                        child: Center(child:Text("CHỜ ĐÁNH GIÁ",style: TextStyle(fontWeight:FontWeight.bold,fontSize: 10,color: Colors.white)))
                    ),
                  ),
                ),
                SizedBox(
                  width: 2,
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      status=4;
                      _getSession();
                    });
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    child: Container(
                        height: Get.height * 0.07,
                        width: Get.width * 0.27,
                        color: (status==4?Colors.purpleAccent:Colors.black26),
                        child: Center(child:Text("ĐÃ GIAO HÀNG",style: TextStyle(fontWeight:FontWeight.bold,fontSize: 10,color: Colors.white)))
                    ),
                  ),
                ),
              ],
            ),
          ),
          Divider(height: 1),
          list_order==null || list_order.toString()=="[]" ? SizedBox(
            child: 'Không có đơn vận chuyển'.text.makeCentered(),
            height: Get.height * 0.3,
          )
              :ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: (list_order!=null?list_order.length:0),
            itemBuilder: (context, index) {
              return _buildRow(list_order[index]);
            },
          ),
        ],
      ),
    );
  }
}
