import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_theme.dart';
import '../../domain/entities/game_enums.dart';
import 'bloc/game_bloc.dart';
import 'bloc/game_event.dart';
import 'bloc/game_state.dart';

class CommandTerminal extends StatelessWidget {
  const CommandTerminal({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 20,
      top: 50,
      bottom: 50,
      width: 120,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            color: AppColors.darkGlass,
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
            child: Column(
              children: [
                const Text(
                  'TERMINAL',
                  style: TextStyle(
                    color: AppColors.neonCyan,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5,
                  ),
                ),
                const Divider(color: AppColors.neonCyan),
                Expanded(
                  child: BlocBuilder<GameBloc, GameState>(
                    builder: (context, state) {
                      return ListView.separated(
                        itemCount: state.commands.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 8),
                        itemBuilder: (context, index) {
                          final command = state.commands[index];
                          final isActive = index == state.currentCommandIndex;

                          return Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: isActive
                                ? AppColors.neonCyan.withOpacity(0.3)
                                : Colors.black45,
                              border: Border.all(
                                color: isActive ? AppColors.neonCyan : Colors.transparent
                              ),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Icon(
                              _getIconForCommand(command),
                              color: isActive ? Colors.white : AppColors.neonCyan,
                              size: 20,
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
                const SizedBox(height: 16),
                _buildControlButtons(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildControlButtons(BuildContext context) {
    return Column(
      children: [
        _TerminalButton(
          icon: Icons.arrow_upward,
          onTap: () => context.read<GameBloc>().add(const AddCommand(AgentCommand.moveForward)),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _TerminalButton(
              icon: Icons.turn_left,
              onTap: () => context.read<GameBloc>().add(const AddCommand(AgentCommand.turnLeft)),
            ),
            _TerminalButton(
              icon: Icons.turn_right,
              onTap: () => context.read<GameBloc>().add(const AddCommand(AgentCommand.turnRight)),
            ),
          ],
        ),
        const SizedBox(height: 16),
        FloatingActionButton(
          mini: true,
          backgroundColor: AppColors.neonCrimson,
          onPressed: () => context.read<GameBloc>().add(const RunCommands()),
          child: const Icon(Icons.play_arrow),
        ),
      ],
    );
  }

  IconData _getIconForCommand(AgentCommand command) {
    switch (command) {
      case AgentCommand.moveForward: return Icons.arrow_upward;
      case AgentCommand.turnRight: return Icons.turn_right;
      case AgentCommand.turnLeft: return Icons.turn_left;
      case AgentCommand.hack: return Icons.data_object;
    }
  }
}

class _TerminalButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _TerminalButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.neonCyan.withOpacity(0.5)),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: AppColors.neonCyan, size: 20),
      ),
    );
  }
}
