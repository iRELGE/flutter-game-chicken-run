import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/image_composition.dart';

class CharlieChicken extends SpriteAnimationComponent {
  double chickenScaleFactor = 3.0;
  //late SpriteComponent chickenSprite;

  @override
  Future<void>? onLoad() async {
    // TODO: implement onLoad
    await super.onLoad();
    print("load player");
    Image chickenImage = await Flame.images.load('chickenRun.png');
    SpriteAnimation chickenAnimation = SpriteAnimation.fromFrameData(
        chickenImage,
        SpriteAnimationData.sequenced(
            amount: 14, stepTime: 0.1, textureSize: Vector2(32, 34)));

    animation = chickenAnimation;
    size = Vector2(32, 34) * chickenScaleFactor;
    position = Vector2(300, 100);
    add(RectangleHitbox());
    debugMode = true;
  }
}
