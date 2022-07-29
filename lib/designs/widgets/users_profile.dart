import 'package:flutter/material.dart';
import 'package:shipper/common/constants.dart';
import 'package:velocity_x/velocity_x.dart';

class UsersProfile extends StatelessWidget {
  const UsersProfile({
    Key? key,
    required this.id,
    this.name,
    this.avatar,
    this.bgavatar,
    this.rank_name,
    this.phone,
    this.email
  }) : super(key: key);
  final String id;
  final String? name;
  final String? phone;
  final String? email;
  final String? avatar;
  final String? bgavatar;
  final String? rank_name;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: kaccentColor,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Stack(
        alignment: AlignmentDirectional.topCenter,
        children: [
          Container(
            height: 100,
            decoration: BoxDecoration(
                border: Border.all(color:Colors.black12),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
                image: DecorationImage(
                  alignment: Alignment.topCenter,
                  fit: BoxFit.fill,
                  image:NetworkImage(bgavatar!),
                )
            ),
          ),
          Positioned(
            top: 60,
            child: Column(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: ktxtwhiteColor,
                  child: CircleAvatar(
                    radius: 32,
                    backgroundImage: NetworkImage(avatar!),
                  ),
                ),
                (name!=null?Text(name!,style: TextStyle(fontWeight: FontWeight.w500,color:ktxtwhiteColor,fontSize:12)):Padding(padding:EdgeInsets.zero)),
                (rank_name!=null?Text(rank_name!,style: TextStyle(fontWeight: FontWeight.w400,color:ktxtwhiteColor,fontSize:10)):Padding(padding:EdgeInsets.zero)),
                (phone!=null?Text(phone!,style: TextStyle(fontWeight: FontWeight.w400,color:ktxtwhiteColor,fontSize:8)):Padding(padding:EdgeInsets.zero)),
                (email!=null?Text(email!,style: TextStyle(fontWeight: FontWeight.w400,color:ktxtwhiteColor,fontSize:8)):Padding(padding:EdgeInsets.zero)),
              ],
            ),
          )
        ],
      ),
    );
  }
}
