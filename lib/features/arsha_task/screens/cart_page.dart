import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/components.dart';
import 'package:flame/input.dart';

class CricketGame extends FlameGame with PanDetector {
  late SpriteComponent bat;
  late SpriteComponent ball;
  bool isBallMoving = false;
  double ballSpeed = 300;

  @override
  Future<void> onLoad() async {
    bat = SpriteComponent()
      ..sprite = await loadSprite('bat.png')
      ..size = Vector2(30, 80)
      ..position = Vector2(size.x / 2, size.y - 100);

    ball = SpriteComponent()
      ..sprite = await loadSprite('ball.png')
      ..size = Vector2(30, 30)
      ..position = Vector2(size.x / 2, 50);

    add(bat);
    add(ball);
  }

  @override
  void onPanUpdate(DragUpdateInfo info) {
    bat.position.x += info.delta.global.x;
  }

  @override
  void onPanEnd(DragEndInfo info) {
    if (!isBallMoving) {
      isBallMoving = true;
    }
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (isBallMoving) {
      ball.position.y += ballSpeed * dt;

      // Check for collision with the bat
      if (ball.toRect().overlaps(bat.toRect())) {
        ballSpeed = ballSpeed.abs(); // Ensure the ball moves downward
      }

      // Reset ball if it goes off-screen at the top
      if (ball.position.y < 0) {
        ball.position.y = 50;
        isBallMoving = false;
      }

      // Reset ball if it goes off-screen at the bottom
      if (ball.position.y > size.y) {
        ball.position.y = 50;
        isBallMoving = false;
      }
    }
  }

}
