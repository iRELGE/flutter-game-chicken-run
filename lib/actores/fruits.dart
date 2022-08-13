import 'package:chiken_run/actores/charlie_chicken.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/image_composition.dart';
import 'package:tiled/tiled.dart';

// class Fruits extends SpriteComponent with HasGameRef, CollisionCallbacks {
//   final TiledObject fruits;

//   Fruits(this.fruits);
//   @override
//   Future<void>? onLoad() async {
//     // TODO: implement onLoad
//     await super.onLoad();
//     sprite = await gameRef.loadSprite('world/strawberry.png')
//       ..srcSize = Vector2.all(96);
//     position = Vector2(fruits.x, fruits.y);
//     add(RectangleHitbox(
//         size: Vector2(fruits.width, fruits.height),
//         anchor: Anchor.center,
//         position: size / 2));
//     debugMode = true;
//   }
// }

class Fruits2 extends SpriteAnimationComponent with CollisionCallbacks {
  final TiledObject fruits;

  Fruits2(this.fruits);
  @override
  Future<void>? onLoad() async {
    // TODO: implement onLoad
    await super.onLoad();

    Image fruitImage = await Flame.images.load('world/strawberry.png');
    SpriteAnimation fruitAnimation = SpriteAnimation.fromFrameData(
        fruitImage,
        SpriteAnimationData.sequenced(
            amount: 17, stepTime: 0.1, textureSize: Vector2(32, 34)));

    animation = fruitAnimation;
    size = Vector2(32, 34) * 3.0;
    position = Vector2(fruits.x, fruits.y);

    add(RectangleHitbox(
        size: Vector2(fruits.width, fruits.height),
        anchor: Anchor.center,
        position: size / 2));
    debugMode = true;
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    // TODO: implement onCollision
    super.onCollision(intersectionPoints, other);
    if (other is CharlieChicken) {
      removeFromParent();
    }
  }
}
