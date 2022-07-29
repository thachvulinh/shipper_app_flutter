import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shipper/common/constants.dart';
import 'package:velocity_x/velocity_x.dart';

class NavBarController with ChangeNotifier {
  // ignore: prefer_final_fields
  int _navBarIndex = 0;

  int get nBarindex {
    return _navBarIndex;
  }

  void changeNavBarIndex(int value) {
    _navBarIndex = value;
    notifyListeners();
  }

  Widget getCenteredTopText() {
    switch (_navBarIndex) {
      case 0:
        return Container(
          margin: const EdgeInsets.only(top: 10, bottom: 0),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
          decoration: BoxDecoration(
            border:
            Border.all(width: 2.2, color: Colors.white.withOpacity(0.8)),
            borderRadius: BorderRadius.circular(8),
          ),
          height: Get.height * 0.057,
          child: const Center(
              child:Padding(
                  padding: EdgeInsets.only(top: 10),
                  child:TextField(
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    cursorColor: Colors.white,
                    decoration: InputDecoration(
                      hintText: 'Tìm kiếm đơn hàng ',
                      hintStyle: TextStyle(
                        color: Color.fromARGB(255, 231, 228, 228),
                      ),
                      //border: InputBorder.none
                    ),
                  ))
          ),
        );
      case 1:
        return Container(
          margin: const EdgeInsets.only(top: 10, bottom: 0),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
          decoration: BoxDecoration(
            border:
                Border.all(width: 2.2, color: Colors.white.withOpacity(0.8)),
            borderRadius: BorderRadius.circular(8),
          ),
          height: Get.height * 0.057,
          child: const Center(
            child:Padding(
              padding: EdgeInsets.only(top: 10),
              child:TextField(
                style: TextStyle(
                  color: Colors.white,
                ),
                cursorColor: Colors.white,
                decoration: InputDecoration(
                    hintText: 'Tìm kiếm người dùng ',
                    hintStyle: TextStyle(
                      color: Color.fromARGB(255, 231, 228, 228),
                    ),
                    //border: InputBorder.none
                ),
              ))
          ),
        );
      case 2:
        return 'Tin Nhắn'
            .text
            .color(Colors.white)
            .minFontSize(20)
            .fontWeight(FontWeight.w600)
            .make();
      default:
        return 'Thông Tin Cá Nhân'
            .text
            .color(Colors.white)
            .minFontSize(20)
            .fontWeight(FontWeight.w600)
            .make();
    }
  }
}
