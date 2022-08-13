import 'package:chiken_run/actores/charlie_chicken.dart';
import 'package:chiken_run/actores/fruits.dart';
import 'package:flame/collisions.dart';
import 'package:flame/flame.dart';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/image_composition.dart';
import 'package:flame/palette.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:flutter/material.dart' hide Image;
import 'package:tiled/tiled.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Flame.device.fullScreen();
  Flame.device.setLandscape();
  runApp(GameWidget(game: ChickenRunGame()));
}

class ChickenRunGame extends FlameGame
    with HasDraggables, HasCollisionDetection {
  late SpriteAnimationComponent chicken;

  late final JoystickComponent joystickComponent;
  bool chickenFlipped = false;
  @override
  Future<void>? onLoad() async {
    // TODO: implement onLoad

    await super.onLoad();
    print("load game");
    var homeMap = await TiledComponent.load('level_1.tmx', Vector2(16, 16));
    add(homeMap);
    double mapHeight = 16.0 * homeMap.tileMap.map.height;
    double mapw = 16.0 * homeMap.tileMap.map.width;
    List<TiledObject> fruitsObject =
        homeMap.tileMap.getLayer<ObjectGroup>('fruit')!.objects;

    for (var fruit in fruitsObject) {
      add(Fruits2(fruit));
    }

    // chickenSprite = SpriteComponent.fromImage(chickenImage,
    //     srcSize: Vector2(32, 34), srcPosition: Vector2(32, 4))
    //   ..size = Vector2(32, 34) * chickenScaleFactor
    //   ..position = Vector2.all(200);
    camera.viewport = FixedResolutionViewport(Vector2(mapw, mapHeight));

    final knobPaint = BasicPalette.blue.withAlpha(200).paint();
    final backgroundPaint = BasicPalette.blue.withAlpha(100).paint();
    joystickComponent = JoystickComponent(
        knob: CircleComponent(radius: 30, paint: knobPaint),
        background: CircleComponent(radius: 100, paint: backgroundPaint),
        margin: const EdgeInsets.only(left: 40, bottom: 40));
    chicken = CharlieChicken();
    add(chicken);
    add(joystickComponent);
  }

  @override
  void update(double dt) {
    // TODO: implement update
    super.update(dt);
    bool moveLeft = joystickComponent.relativeDelta[0] < 0;
    bool moveRiht = joystickComponent.relativeDelta[0] > 0;
    bool moveUp = joystickComponent.relativeDelta[1] < 0;
    bool moveDown = joystickComponent.relativeDelta[1] > 0;
    double chickenVectorX = (joystickComponent.relativeDelta * 300 * dt)[0];
    double chickenVectorY = (joystickComponent.relativeDelta * 300 * dt)[1];
    if ((moveLeft && chicken.x > 0) || (moveRiht && chicken.x < size[0])) {
      chicken.position.add(Vector2(chickenVectorX, 0));
    }
    if ((moveUp && chicken.y > 0) ||
        (moveDown && chicken.y < size[1] - chicken.height - 80)) {
      chicken.position.add(Vector2(0, chickenVectorY));
    }

    if (joystickComponent.relativeDelta[0] < 0 && chickenFlipped) {
      chickenFlipped = false;
      chicken.flipHorizontallyAroundCenter();
    }
    if (joystickComponent.relativeDelta[0] > 0 && !chickenFlipped) {
      chickenFlipped = true;
      chicken.flipHorizontallyAroundCenter();
    }
  }
}
