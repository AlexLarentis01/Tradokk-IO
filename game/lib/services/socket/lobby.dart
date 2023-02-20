import 'dart:io';

import 'package:flutter/material.dart';
import 'package:phoenix_socket/phoenix_socket.dart';

const socket_url = 'ws://localhost:4000/socket/websocket';

class LobbySocket extends ChangeNotifier {
  bool connected = false;
  late PhoenixSocket _socket;
  PhoenixChannel? _channel;
  final games = [];

  LobbySocket() {
    _socket = PhoenixSocket(socket_url)..connect();
    _socket.closeStream.listen((event) {
      connected = false;
    });
    _socket.openStream.listen((event) {
      _channel = _socket.addChannel(topic: "room:lobby");
      _channel?.join();
    });
  }

  void connectToLobby() {}

  void send(message) {
    print(_channel?.topic);

    _channel?.push("shout", {"payload": message});
  }

  Stream<String> listen() async* {
    _socket.openStream.listen((event) {
      _channel = _socket.addChannel(topic: 'lobby');
      connected = true;
    });
  }
}
