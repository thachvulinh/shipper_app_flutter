import 'package:flutter/material.dart';

class Com {
  alert_dialog(BuildContext context,String title,String content){
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content.replaceAll('<br/>','\n')),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'OK'),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
  alert_dialog_button1(BuildContext context,String title,String content,String textbutton,Function() onPressed){
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content.replaceAll('<br/>','\n')),
          actions: <Widget>[
            TextButton(
              onPressed:onPressed,
              child:Text(textbutton),
            ),
          ],
        );
      },
    );
  }
}