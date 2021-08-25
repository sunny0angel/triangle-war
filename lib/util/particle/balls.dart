import 'dart:math' as math;
import 'dart:math';

import 'package:flame/palette.dart';
import 'package:flame_forge2d/body_component.dart';
import 'package:flame_forge2d/contact_callbacks.dart';
import 'package:flutter/material.dart';
import 'package:forge2d/forge2d.dart';

import 'boundaries.dart';

class Ball extends BodyComponent {
  late Paint originalPaint;
  bool giveNudge = false;
  final double radius;
  final Vector2 _position;
  double _timeSinceNudge = 0.0;
  static const double _minNudgeRest = 2.0;

  final Paint _blue = BasicPalette.blue.paint();

  Ball(this._position, {this.radius = 2}) {
    originalPaint = randomPaint();
    paint = originalPaint;
  }

  Paint randomPaint() {
    final rng = math.Random();
    return PaletteEntry(
      Color.fromARGB(
        100 + rng.nextInt(155),
        100 + rng.nextInt(155),
        100 + rng.nextInt(155),
        255,
      ),
    ).paint();
  }

  @override
  Body createBody() {
    final shape = CircleShape();
    shape.radius = radius;

    final fixtureDef = FixtureDef(shape)
      ..restitution = 0.8
      ..density = 1.0
      ..friction = 0.4;

    final bodyDef = BodyDef()
      // To be able to determine object in collision
      ..userData = this
      ..angularDamping = 0.8
      ..position = _position
      ..type = BodyType.dynamic;

    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }

  @override
  void renderCircle(Canvas c, Offset center, double radius) {
    super.renderCircle(c, center, radius);
    // final lineRotation = Offset(0, radius);
    // c.drawLine(center, center + lineRotation, _blue);
  }

  @override
  void update(double dt) {
    super.update(dt);
    _timeSinceNudge += dt;
    if (giveNudge) {
      giveNudge = false;
      if (_timeSinceNudge > _minNudgeRest) {
        body.applyLinearImpulse(Vector2(0, 1000));
        _timeSinceNudge = 0.0;
      }
    }
  }
}

class ShrapnelBall extends Ball {
  ShrapnelBall(Vector2 position, double radius)
      : super(position, radius: radius);

  late CircleShape _shape;
  late FixtureDef _fixtureDef;

  late BodyDef _bodyDef;

  @override
  Body createBody() {
    _shape = (CircleShape()..radius = radius);

    _fixtureDef = FixtureDef(_shape)
      ..restitution = 0.8
      ..density = 1.0
      ..friction = 0.4;

    _bodyDef = BodyDef()
      // To be able to determine object in collision
      ..userData = this
      ..angularDamping = Random().nextDouble()
      ..position = _position
      ..type = BodyType.dynamic
      ..bullet = true;

    return world.createBody(_bodyDef)..createFixture(_fixtureDef);
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (_shape.radius > 0.05) {
      _shape.radius = _shape.radius - 0.05;
      body.applyAngularImpulse(Random().nextDouble());
      body.applyLinearImpulse(Vector2.random() * 1000,
          point: Vector2.random() * 1000);
      _timeSinceNudge += dt;
    } else {
      this.remove();
    }
  }
}

class WhiteBall extends Ball {
  WhiteBall(Vector2 position) : super(position) {
    originalPaint = BasicPalette.white.paint();
    paint = originalPaint;
  }
}

class TransparentBall extends Ball {
  TransparentBall(Vector2 position) : super(position) {
    originalPaint = Paint()..color = Colors.transparent;
    paint = originalPaint;
  }
}

class BallContactCallback extends ContactCallback<Ball, Ball> {
  @override
  void begin(Ball ball1, Ball ball2, Contact contact) {
    if (ball1 is WhiteBall || ball2 is WhiteBall) {
      return;
    }
    if (ball1.paint != ball1.originalPaint) {
      ball1.paint = ball2.paint;
    } else {
      ball2.paint = ball1.paint;
    }
  }

  @override
  void end(Ball ball1, Ball ball2, Contact contact) {}
}

class WhiteBallContactCallback extends ContactCallback<Ball, WhiteBall> {
  @override
  void begin(Ball ball, WhiteBall whiteBall, Contact contact) {
    ball.giveNudge = true;
  }

  @override
  void end(Ball ball, WhiteBall whiteBall, Contact contact) {}
}

class BallWallContactCallback extends ContactCallback<Ball, Wall> {
  @override
  void begin(Ball ball, Wall wall, Contact contact) {
    wall.paint = ball.paint;
  }

  @override
  void end(Ball ball, Wall wall, Contact contact) {}
}
