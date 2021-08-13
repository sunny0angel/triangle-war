import 'package:flame/components.dart';
import 'package:flame/sprite.dart';

class PlayerSpriteSheet {
  static Future<SpriteAnimation> get idleLeft => SpriteAnimation.load(
      "player/knight_idle_left.png",
      SpriteAnimationData.sequenced(
        amount: 6,
        stepTime: 0.15,
        textureSize: Vector2(16, 16),
      ));

  static Future<SpriteAnimation> get idleRight => SpriteAnimation.load(
      "player/knight_idle.png",
      SpriteAnimationData.sequenced(
        amount: 6,
        stepTime: 0.15,
        textureSize: Vector2(16, 16),
      ));

  static Future<SpriteAnimation> get runRight => SpriteAnimation.load(
      "player/knight_run.png",
      SpriteAnimationData.sequenced(
        amount: 6,
        stepTime: 0.15,
        textureSize: Vector2(16, 16),
      ));

  static Future<SpriteAnimation> get runLeft => SpriteAnimation.load(
      "player/knight_run_left.png",
      SpriteAnimationData.sequenced(
        amount: 6,
        stepTime: 0.15,
        textureSize: Vector2(16, 16),
      ));

  // static SimpleDirectionAnimation get simpleDirectionAnimation =>
  //     SimpleDirectionAnimation(
  //       idleLeft: idleLeft,
  //       idleRight: idleRight,
  //       runLeft: runLeft,
  //       runRight: runRight,
  //     );
}
