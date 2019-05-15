import 'package:meta/meta.dart';

class GameState {
  final int ourPoint;
  final List<int> ourPoints;
  final int theyPoint;
  final List<int> theyPoints;
  GameState({
    @required this.ourPoints,
    @required this.theyPoints,
    this.ourPoint,
    this.theyPoint,
  });

  factory GameState.newGame() {
    return GameState(
      ourPoints: [],
      theyPoints: [],
      ourPoint: 0,
      theyPoint: 0,
      // matches: [{'ourPoint': 0, 'theyPoint' : 0}],
    );
  }
}