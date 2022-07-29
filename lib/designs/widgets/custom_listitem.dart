import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CustomListItem extends StatelessWidget {
  const CustomListItem({
    Key? key,
    required this.thumbnail,
    required this.id,
    required this.name,
    this.price,
    this.quantity,
    this.payment,
    this.delivery_price,
    this.total_price,
    this.color,
    this.condition1,
    this.value_condition1,
    this.condition2,
    this.value_condition2,
    this.paid,

    this.receiver,
    this.receiver_phone,
    this.receiver_address,
    this.receiver_postcode,
    this.createdAt,

  }) : super(key: key);
  final Widget thumbnail;
  final String id;
  final String name;
  final String? price;
  final String? quantity;
  final String? payment;
  final String? delivery_price;
  final String? total_price;
  final String? color;
  final String? condition1 ;
  final String? value_condition1 ;
  final String? condition2;
  final String? value_condition2;
  final String? paid;

  final String? receiver ;
  final String? receiver_phone ;
  final String? receiver_address  ;
  final String? receiver_postcode  ;
  final String? createdAt  ;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 2,
            child: thumbnail,
          ),
          Expanded(
            flex: 3,
            child: _VideoDescription(
              id:id,
              name: name,
              price: price,
              quantity: quantity,
              payment: payment,
              delivery_price: delivery_price,
              total_price:total_price,
              color: color,
              condition1: condition1,
              value_condition1: value_condition1,
              condition2: condition2,
              value_condition2: value_condition2,
              paid: paid,

              receiver: receiver,
              receiver_phone: receiver_phone,
              receiver_address: receiver_address,
              receiver_postcode: receiver_postcode,
              createdAt: createdAt,
            ),
          ),
          const Icon(
            Icons.more_vert,
            size: 16.0,
          ),
        ],
      ),
    );
  }
}
class _VideoDescription extends StatelessWidget {
  const _VideoDescription({
    Key? key,
    required this.id,
    required this.name,
    this.price,
    this.quantity,
    this.payment,
    this.delivery_price,
    this.total_price,
    this.color,
    this.condition1,
    this.value_condition1,
    this.condition2,
    this.value_condition2,
    this.paid,

    this.receiver,
    this.receiver_phone,
    this.receiver_address,
    this.receiver_postcode,
    this.createdAt,
  }) : super(key: key);
  final String id;
  final String name;
  final String? price;
  final String? quantity;
  final String? payment;
  final String? delivery_price;
  final String? total_price;
  final String? color;
  final String? condition1 ;
  final String? value_condition1 ;
  final String? condition2;
  final String? value_condition2;
  final String? paid;

  final String? receiver ;
  final String? receiver_phone ;
  final String? receiver_address  ;
  final String? receiver_postcode  ;
  final String? createdAt  ;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            name,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14.0,
            ),
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 2.0)),
          Text(
            "Mã: $id",
            style: const TextStyle(fontSize: 10.0),
          ),
          Text(
            "Tổng giá: $total_price ( ship:$delivery_price)",
            style: const TextStyle(fontSize: 10.0),
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 3.0)),
          Divider(
            height: 1,
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 3.0)),
          Text(
            "Địa chỉ: $receiver_address",
            style: const TextStyle(fontSize: 10.0),
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 2.0)),
          Text(
            "Người nhận: $receiver",
            style: const TextStyle(fontSize: 10.0),
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 2.0)),
          Text(
            "Số điện thoại: $receiver_phone",
            style: const TextStyle(fontSize: 10.0),
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 2.0)),
        ],
      ),
    );
  }
}
