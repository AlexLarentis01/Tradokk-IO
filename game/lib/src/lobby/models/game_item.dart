import 'package:game/src/lobby/models/player_item.dart';
import 'package:quiver/core.dart';

typedef Games = List<Game>;

class Game {
  /// The Model Rapresenting a game
  const Game(this.id, this.map_id, this.players);

  /// A UUIDv6 identifiing a game
  final String id;

  /// A int id for the locally saved map
  final int map_id;

  /// The list of players joind in this game
  final Players players;

  Map<String, dynamic> toJSON() {
    return {
      "id": id,
      "map_id": map_id,
      "players": players.map((e) => e.toJSON())
    };
  }

  factory Game.fromJSON(json) {
    return Game(json['id'], json['map_id'],
        (json['players'] as List).map((e) => Player.fromJSON) as List<Player>);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is Game &&
        other.id == id &&
        other.map_id == map_id &&
        other.players == players;
  }

  @override
  int get hashCode => hash3(id, map_id, players);
}
