import 'package:flutter/material.dart';
import 'package:game/src/lobby/errors/no_open_channel_error.dart';
import 'package:game/src/lobby/models/player_item.dart';
import 'package:phoenix_socket/phoenix_socket.dart';

import '../models/game_item.dart';

// ignore: constant_identifier_names
const SOCKET_URL = 'ws://localhost:4000/socket/websocket';

class LobbyService extends ChangeNotifier {
  bool connected = false;
  late PhoenixSocket _socket;
  PhoenixChannel? _channel;
  final Games _games = [];

  /// A service that handles the communication based on
  /// websockets
  LobbyService() {
    _socket = PhoenixSocket(SOCKET_URL)..connect();

    // Listen to socket closure
    _socket.closeStream.listen((event) {
      connected = false;
    });

    // Listen to socket opening
    _socket.openStream.listen((event) {
      _channel = _socket.addChannel(topic: "room:lobby");
      _channel?.join();
      connected = false;
    });
  }

  /// Creates a Game
  /// [game] the game you want to join
  /// [notify] (ATTENTION) for changing the game server
  void createGame({required Game game, notify = false}) {
    if (notify) {
      _channel!.push("create-game", game.toJSON());
    }

    _games.add(game);
  }

  /// Deletes a Game
  /// [game] the game you want to join
  /// [notify] (ATTENTION) for changing the game server
  void deleteGame({required Game game, notify = true}) {
    if (notify) {
      _channel!.push("delete-game", game.toJSON());
    }

    _games.remove(game);
  }

  /// Joins the Game
  /// [game] the game you want to join
  /// [player] your player
  /// [notify] (ATTENTION) for changing the game server
  void joinGame({required Game game, required Player player, notify = true}) {
    if (notify) {
      _channel!.push(
          "join-game", {"game": game.toJSON(), "player": player.toJSON()});
    }

    var index = _games.indexOf(game);
    _games[index].players.add(player);
  }

  /// Leaves the Game
  /// [game] the game you want to join
  /// [player] your player
  /// [notify] (ATTENTION) for changing the game server
  void leaveGame({required Game game, required Player player, notify = true}) {
    if (notify) {
      _channel!.push(
          "leave-game", {"game": game.toJSON(), "player": player.toJSON()});
    }

    var index = _games.indexOf(game);
    _games[index].players.remove(player);
  }

  /// Syncronizes the Games state with the gameserver
  /// used for initial state
  void _syncGames(message) {
    _games.clear();
    _games.addAll((message.payload!['games'] as List).map(Game.fromJSON));
  }

  Stream<Games> get games async* {
    if (_channel == null || !_channel!.canPush) {
      throw NoOpenChannelError();
    }

    await for (var message in _channel!.messages) {
      switch (message.topic) {
        case "sync-games":
          _syncGames(message.payload);
          break;
        case "create-game":
          createGame(game: Game.fromJSON(message.payload), notify: false);
          break;
        case "delete-game":
          deleteGame(game: Game.fromJSON(message.payload), notify: false);
          break;
        case "join-game":
          joinGame(
              game: Game.fromJSON(message.payload!['game']),
              player: Player.fromJSON(message.payload!["player"]),
              notify: false);
          break;

        case "leave-game":
          leaveGame(
              game: Game.fromJSON(message.payload!['game']),
              player: Player.fromJSON(message.payload!["player"]),
              notify: false);
          break;
        default:
      }
    }
  }
}
