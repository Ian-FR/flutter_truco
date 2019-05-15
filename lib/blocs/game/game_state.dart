import 'package:meta/meta.dart';

class GameState {
  
  final List<int> ourPoints;
  final List<int> theyPoints;
  final int ourPoint;
  final int theyPoint;
  
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
    );
  }

  // @override
  // String toString() {
  //   return '''GamState {
  //     ourPoints: $ourPoints,
  //     theyPoints: $theyPoints,
  //     ourPoint: $ourPoint,
  //     theyPoint: $theyPoint,
  //   }''';
  // }

}