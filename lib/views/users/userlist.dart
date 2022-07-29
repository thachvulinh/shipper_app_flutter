import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../app/controllers/userscontroller.dart';
import '../../common/session.dart';
import '../../designs/widgets/src/wave.dart';
import '../../designs/widgets/users_profile.dart';
import 'userdetail.dart';

class UsersListPage extends StatefulWidget {
const UsersListPage({Key? key}) : super(key: key);
@override
  State<UsersListPage> createState() => UsersListPageState();
}
class UsersListPageState extends State<UsersListPage>{
  int loading=1;
  var list_user;
  LoadData() async {
    var data_login= (await Session_Login().getSession_Login());
    var listuser= await UsersController().GetListUser(data_login['user_login_id']);
    setState(() {
      list_user=listuser;
    });
  }
  @override
  void initState() {
    // TODO: implement initState
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
    Widget _buildRow(item){
      return InkWell(child:UsersProfile(
            id:item["id"],
            name:item["name"],
            phone: item["phone"],
            email: item["email"],
            avatar:item["avatar"],
            bgavatar:item["bgavatar"],
            rank_name:(item["ranks"][0]["name"]!=null?item["ranks"][0]["name"]:'')
        ),
        onTap: (){
          Navigator.of(context).push(
              new MaterialPageRoute(builder: (BuildContext context){
                return UserDetailPage(user_id:item["_id"]);
              })
          );
        }
      );
    }
    return Column(
      children: [
        loading==1?Container(width: double.infinity, height: 500,child:SpinKitWave(color: Colors.black, type: SpinKitWaveType.start)):
        list_user==null || list_user.toString()=="[]" ? SizedBox(
          child: 'Không có người dùng'.text.makeCentered(),
          height: Get.height * 0.3,
        ):
        Expanded(
          child: GridView.count(
            crossAxisCount: 2,
            children: List.generate(list_user.length, (index) {
              return index % 2 == 0 ? ElasticInLeft(child: _buildRow(list_user[index])) : ElasticInRight(child: _buildRow(list_user[index]));
            }),
          ),
        ),
      ],
    );
  }
}
