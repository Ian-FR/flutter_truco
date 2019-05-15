import 'package:equatable/equatable.dart';

abstract class InitializationEvent extends Equatable {
  InitializationEvent([List props = const []]) : super(props);
}

class AppStart extends InitializationEvent {
  @override
  String toString() => 'AppStart';
}

class AppInitialized extends InitializationEvent {
  @override
  String toString() => 'AppInitialized';
}