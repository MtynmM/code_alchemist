import 'package:flutter_bloc/flutter_bloc.dart';
import 'game_event.dart';
import 'game_state.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  GameBloc() : super(const GameState()) {
    on<AddCommand>(_onAddCommand);
    on<RunCommands>(_onRunCommands);
    on<ExecutionStepCompleted>(_onExecutionStepCompleted);
  }

  void _onAddCommand(AddCommand event, Emitter<GameState> emit) {
    if (state.status == GameStatus.planning) {
      final updatedCommands = List.of(state.commands)..add(event.command);
      emit(state.copyWith(commands: updatedCommands));
    }
  }

  Future<void> _onRunCommands(RunCommands event, Emitter<GameState> emit) async {
    if (state.commands.isEmpty) return;

    emit(state.copyWith(status: GameStatus.running, currentCommandIndex: 0));
  }

  void _onExecutionStepCompleted(ExecutionStepCompleted event, Emitter<GameState> emit) {
    emit(state.copyWith(currentCommandIndex: event.commandIndex));

    // Check if finished
    if (event.commandIndex >= state.commands.length - 1) {
      emit(state.copyWith(status: GameStatus.completed));
    }
  }
}
