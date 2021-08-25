import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame/game.dart';
import 'package:flame/gestures.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flame_forge2d/forge2d_game.dart';
import 'package:forge2d/forge2d.dart';
import 'package:triangle_war/util/particle/balls.dart';
import 'package:triangle_war/util/particle/boundaries.dart';
import 'package:triangle_war/util/particle/joint_triangle.dart';

class Game extends Forge2DGame with HasTappableComponents, HasCollidables {
  Game() : super(gravity: Vector2(0, 0));

  @override
  Future<void> onLoad() async {
    super.onLoad();
    addAll(createBoundaries(this));
  }

  @override
  void onTapDown(int pointerId, TapDownInfo info) {
    super.onTapDown(pointerId, info);
    final ball = TransparentBall(info.eventPosition.game);
    add(ball);
    add(CircleShuffler(ball));
  }

  @override
  void update(double dt) {
    // TODO: implement update
    super.update(dt);
  }

  void onPolygonDestroy(Vector2 position) {
    final random = Random();
    List.generate(15, (i) {
      final randomVector = (Vector2.random() - Vector2.all(-0.5)).normalized();
      add(Ball(position + randomVector, radius: random.nextDouble()));
    });
  }
}
