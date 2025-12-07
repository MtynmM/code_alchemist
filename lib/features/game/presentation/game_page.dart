import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../logic/code_alchemist_game.dart';
import 'bloc/game_bloc.dart';
import 'bloc/game_state.dart';
import 'command_terminal.dart';
import '../../../../core/di/injection_container.dart';

class GamePage extends StatelessWidget {
  const GamePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<GameBloc>(),
      child: const GameView(),
    );
  }
}

class GameView extends StatefulWidget {
  const GameView({super.key});

  @override
  State<GameView> createState() => _GameViewState();
}

class _GameViewState extends State<GameView> {
  late final CodeAlchemistGame _game;

  @override
  void initState() {
    super.initState();
    _game = CodeAlchemistGame();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 1. The Game Layer
          GameWidget(
            game: _game,
          ),

          // 2. The UI Layer (Glassmorphism Terminal)
          const CommandTerminal(),

          // 3. Bloc Listener for Execution
          BlocListener<GameBloc, GameState>(
            listener: (context, state) {
              if (state.status == GameStatus.running && state.currentCommandIndex == 0) {
                // Trigger execution in Flame
                _game.executeBatch(
                  state.commands,
                  onStepComplete: (index) {
                    context.read<GameBloc>().add(ExecutionStepCompleted(index));
                  },
                );
              }
            },
            child: const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}
