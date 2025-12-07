import 'dart:ui';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flutter/animation.dart';
import '../../../../core/theme/app_theme.dart';
import '../../domain/entities/game_enums.dart';

class CodePlayer extends PositionComponent {
  int gridX = 0;
  int gridY = 0;
  final double tileSize;
  Direction direction = Direction.east;
  final int maxGridX;
  final int maxGridY;

  CodePlayer({
    required this.tileSize,
    this.maxGridX = 10,
    this.maxGridY = 10,
  }) : super(size: Vector2.all(tileSize / 1.5));

  @override
  Future<void> onLoad() async {
    // Initial position centered in the tile
    position = _getPixelPosition(gridX, gridY);
    anchor = Anchor.center;
  }

  @override
  void render(Canvas canvas) {
    final paint = Paint()
      ..color = AppColors.neonCyan
      ..style = PaintingStyle.fill
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4.0);

    final path = Path();
    final w = size.x;
    final h = size.y;

    // Draw a "Data Spark" shape (triangle/arrow) based on direction
    switch (direction) {
      case Direction.north:
        path.moveTo(w / 2, 0);
        path.lineTo(w, h);
        path.lineTo(w / 2, h * 0.7);
        path.lineTo(0, h);
        break;
      case Direction.east:
        path.moveTo(w, h / 2);
        path.lineTo(0, h);
        path.lineTo(w * 0.3, h / 2);
        path.lineTo(0, 0);
        break;
      case Direction.south:
        path.moveTo(w / 2, h);
        path.lineTo(0, 0);
        path.lineTo(w / 2, h * 0.3);
        path.lineTo(w, 0);
        break;
      case Direction.west:
        path.moveTo(0, h / 2);
        path.lineTo(w, 0);
        path.lineTo(w * 0.7, h / 2);
        path.lineTo(w, h);
        break;
    }
    path.close();
    canvas.drawPath(path, paint);
  }

  Vector2 _getPixelPosition(int x, int y) {
    return Vector2(
      x * tileSize + tileSize / 2,
      y * tileSize + tileSize / 2,
    );
  }

  Future<void> moveForward() async {
    int nextX = gridX;
    int nextY = gridY;

    switch (direction) {
      case Direction.north:
        nextY--;
        break;
      case Direction.east:
        nextX++;
        break;
      case Direction.south:
        nextY++;
        break;
      case Direction.west:
        nextX--;
        break;
    }

    // Boundary check
    if (nextX >= 0 && nextX < maxGridX && nextY >= 0 && nextY < maxGridY) {
      gridX = nextX;
      gridY = nextY;

      final targetPos = _getPixelPosition(gridX, gridY);

      await add(
        MoveEffect.to(
          targetPos,
          EffectController(duration: 0.3, curve: Curves.easeInOutExpo),
        ),
      );
    } else {
      // Hit wall effect (shake or flash) - simplified for now
      // We could add a ShakeEffect here
    }
  }

  void turnRight() {
    direction = direction.right;
    // Force re-render to rotate the shape
    // In a sprite component we would rotate the angle, but here we redraw the path
    // For smoother rotation we could animate `angle` property instead of redrawing
    // But for the "glitch" aesthetic, snapping is fine, or we can animate the rotation:

    // Let's actually use the component's angle for rotation to allow tweening if needed
    // But our render logic depends on direction enum.
    // Ideally we should use `angle` and rotate the canvas.
    // For now, simple state change.
  }

  void turnLeft() {
    direction = direction.left;
  }
}
