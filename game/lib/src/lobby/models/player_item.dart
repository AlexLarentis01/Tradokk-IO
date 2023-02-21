import 'package:quiver/core.dart';

typedef Players = List<Player>;

class Player {
  const Player(this.id, this.username);

  /// A UUIDv6 identifying the user
  final String id;

  /// A unique textual sequence for the user
  final String username;

  factory Player.fromJSON(json) {
    return Player(json['uuid'], json["username"]);
  }

  Map<String, dynamic> toJSON() {
    return {"id": id, "username": username};
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is Player && other.id == id && other.username == username;
  }

  @override
  int get hashCode => hash2(id, username);
}
