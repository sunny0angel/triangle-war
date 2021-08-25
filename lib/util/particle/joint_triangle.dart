import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/gestures.dart';
import 'package:flame_forge2d/body_component.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:forge2d/forge2d.dart';

import 'balls.dart';

class CircleShuffler extends BodyComponent with Tappable {
  final Ball ball;

  CircleShuffler(this.ball);

  @override
  Body createBody() {
    final bodyDef = BodyDef()
      ..type = BodyType.dynamic
      ..position = ball.body.position.clone();
    const numPieces = 5;
    const radius = 6.0;
    final body = world.createBody(bodyDef);

    for (var i = 0; i < numPieces; i++) {
      final xPos = radius * cos(2 * pi * (i / numPieces));
      final yPos = radius * sin(2 * pi * (i / numPieces));

      final shape = CircleShape()
        ..radius = 1.2
        ..position.setValues(xPos, yPos);

      final fixtureDef = FixtureDef(shape)
        ..density = 50.0
        ..friction = .1
        ..restitution = .9;

      body.createFixture(fixtureDef);
    }

    final revoluteJointDef = RevoluteJointDef()
      ..initialize(body, ball.body, body.position);

    world.createJoint(revoluteJointDef);
    return body;
  }

  @override
  bool handleTapDown(int pointerId, TapDownInfo info) {
    super.handleTapDown(pointerId, info);
    this.remove();
    ball.remove();
    final random = Random();
    List.generate(15, (i) {
      final randomVector = (Vector2.random() - Vector2.all(-0.5)).normalized();
      this.gameRef.add(ShrapnelBall(
          this.ball.body.position + randomVector, random.nextDouble()));
    });
    return true;
  }
}
