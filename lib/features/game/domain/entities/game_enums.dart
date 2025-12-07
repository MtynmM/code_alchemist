enum AgentCommand {
  moveForward,
  turnRight,
  turnLeft,
  hack,
}

enum Direction {
  north,
  east,
  south,
  west;

  Direction get right {
    switch (this) {
      case Direction.north: return Direction.east;
      case Direction.east: return Direction.south;
      case Direction.south: return Direction.west;
      case Direction.west: return Direction.north;
    }
  }

  Direction get left {
    switch (this) {
      case Direction.north: return Direction.west;
      case Direction.west: return Direction.south;
      case Direction.south: return Direction.east;
      case Direction.east: return Direction.north;
    }
  }
}

enum AgentState {
  idle,
  moving,
  hacking,
  crashed,
}
