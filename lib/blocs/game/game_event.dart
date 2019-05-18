import 'package:equatable/equatable.dart';

abstract class GameEvent extends Equatable {
  GameEvent([List props = const []]) : super(props);
}

class NewGame extends GameEvent {
  @override
  String toString() => 'NewGame';
}

class BackMatch extends GameEvent {
  @override
  String toString() => 'BackMatch';
}

class OurRound extends GameEvent {
  @override
  String toString() => 'OurRound';
}

class TheyRound extends GameEvent {
  @override
  String toString() => 'TheyRound';
}

class OurMoreOne extends GameEvent {
  @override
  String toString() => 'OurMoreOne';
}

class OurMoreThree extends GameEvent {
  @override
  String toString() => 'OurMoreThree';
}

class OurMoreSix extends GameEvent {
  @override
  String toString() => 'OurMoreSix';
}

class OurMoreNine extends GameEvent {
  @override
  String toString() => 'OurMoreNine';
}

class TheyMoreOne extends GameEvent {
  @override
  String toString() => 'TheyMoreOne';
}

class TheyMoreThree extends GameEvent {
  @override
  String toString() => 'TheyMoreThree';
}

class TheyMoreSix extends GameEvent {
  @override
  String toString() => 'TheyMoreSix';
}

class TheyMoreNine extends GameEvent {
  @override
  String toString() => 'TheyMoreNine';
}