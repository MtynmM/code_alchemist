import 'package:flame/camera.dart';
import 'package:flame/game.dart';
import '../../domain/entities/game_enums.dart';
import '../components/code_player.dart';
import '../components/digital_background.dart';

class CodeAlchemistGame extends FlameGame {
  late final CodePlayer _player;
  late final DigitalBackground _background;

  // Grid settings
  final int cols = 10;
  final int rows = 15;
  final double tileSize = 64.0;

  @override
  Future<void> onLoad() async {
    // Setup Camera
    camera = CameraComponent.withFixedResolution(
      width: cols * tileSize,
      height: rows * tileSize,
    );
    camera.viewfinder.anchor = Anchor.topLeft;

    // Setup World
    world = World();
    camera.world = world;
    add(camera); // Add camera to the game

    // Add Background
    _background = DigitalBackground(
      cols: cols,
      rows: rows,
      tileSize: tileSize
    );
    await world.add(_background);

    // Add Player
    _player = CodePlayer(
      tileSize: tileSize,
      maxGridX: cols,
      maxGridY: rows
    );
    await world.add(_player);
  }

  Future<void> executeBatch(List<AgentCommand> commands, {required Function(int) onStepComplete}) async {
    for (int i = 0; i < commands.length; i++) {
      onStepComplete(i);
      await _executeCommand(commands[i]);
      // Small delay between commands for pacing
      await Future.delayed(const Duration(milliseconds: 100));
    }
  }

  Future<void> _executeCommand(AgentCommand command) async {
    switch (command) {
      case AgentCommand.moveForward:
        await _player.moveForward();
        // Wait for animation to finish?
        // MoveEffect duration is 0.3s. We should ideally wait.
        // The await inside moveForward only awaits the ADDITION of the effect, not completion.
        // To sync, we can add a delay matching the effect duration.
        await Future.delayed(const Duration(milliseconds: 350));
        break;
      case AgentCommand.turnRight:
        _player.turnRight();
        await Future.delayed(const Duration(milliseconds: 200));
        break;
      case AgentCommand.turnLeft:
        _player.turnLeft();
        await Future.delayed(const Duration(milliseconds: 200));
        break;
      case AgentCommand.hack:
        // Trigger hack animation
        await Future.delayed(const Duration(milliseconds: 500));
        break;
    }
  }
}
