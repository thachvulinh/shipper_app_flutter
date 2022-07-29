import 'dart:convert';
import 'package:flutter_session/flutter_session.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'constants.dart';
class SocketIO{
  Socket socket = io(url_server, <String, dynamic>{"transports": ["websocket"], "autoConnect": false,});
  connectToServer() {
    try {
      socket.connect();
      // socket.on('connect', (data) {print('connected');print(socket.connected);});
      // socket.onDisconnect((_) => print('disconnect'));
    } catch (e) {
      print(e);
    }
    return socket;
  }
}