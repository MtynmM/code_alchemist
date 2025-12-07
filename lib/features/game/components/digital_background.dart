import 'dart:ui';
import 'package:flame/components.dart';
import '../../../../core/theme/app_theme.dart';

class DigitalBackground extends PositionComponent {
  final int cols;
  final int rows;
  final double tileSize;
  late final Picture _gridPicture;

  DigitalBackground({
    this.cols = 20,
    this.rows = 20,
    this.tileSize = 64.0,
  });

  @override
  Future<void> onLoad() async {
    _gridPicture = _recordGrid();
  }

  Picture _recordGrid() {
    final recorder = PictureRecorder();
    final canvas = Canvas(recorder);
    final paint = Paint()
      ..color = AppColors.neonCyan.withOpacity(0.2)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    final glowPaint = Paint()
      ..color = AppColors.neonCyan.withOpacity(0.05)
      ..style = PaintingStyle.fill;

    for (int i = 0; i < cols; i++) {
      for (int j = 0; j < rows; j++) {
        final rect = Rect.fromLTWH(i * tileSize, j * tileSize, tileSize, tileSize);
        canvas.drawRect(rect, paint);

        // Add some random "glitch" or filled tiles for texture
        if ((i + j) % 7 == 0) {
          canvas.drawRect(rect.deflate(4), glowPaint);
        }
      }
    }
    return recorder.endRecording();
  }

  @override
  void render(Canvas canvas) {
    canvas.drawPicture(_gridPicture);
  }
}
