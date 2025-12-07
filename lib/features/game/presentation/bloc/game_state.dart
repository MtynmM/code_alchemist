import 'package:equatable/equatable.dart';
import '../../domain/entities/game_enums.dart';

enum GameStatus { planning, running, completed, failed }

class GameState extends Equatable {
  final GameStatus status;
  final List<AgentCommand> commands;
  final int currentCommandIndex;
  final String? errorMessage;

  const GameState({
    this.status = GameStatus.planning,
    this.commands = const [],
    this.currentCommandIndex = -1,
    this.errorMessage,
  });

  GameState copyWith({
    GameStatus? status,
    List<AgentCommand>? commands,
    int? currentCommandIndex,
    String? errorMessage,
  }) {
    return GameState(
      status: status ?? this.status,
      commands: commands ?? this.commands,
      currentCommandIndex: currentCommandIndex ?? this.currentCommandIndex,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, commands, currentCommandIndex, errorMessage];
}
