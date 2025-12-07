import 'package:equatable/equatable.dart';
import '../../domain/entities/game_enums.dart';

abstract class GameEvent extends Equatable {
  const GameEvent();

  @override
  List<Object> get props => [];
}

class AddCommand extends GameEvent {
  final AgentCommand command;

  const AddCommand(this.command);

  @override
  List<Object> get props => [command];
}

class RunCommands extends GameEvent {
  const RunCommands();
}

class ExecutionStepCompleted extends GameEvent {
  final int commandIndex;

  const ExecutionStepCompleted(this.commandIndex);

  @override
  List<Object> get props => [commandIndex];
}
