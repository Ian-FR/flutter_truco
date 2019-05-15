import 'package:flutter/material.dart';

class InitializationState {
  
  final bool initialized;
  final bool initializing;
  final int progress; 

  InitializationState({
    @required this.initialized,
    this.initializing,
    this.progress,
  });

  factory InitializationState.notInitialized() {
    return InitializationState(
      initialized: false,
    );
  }

   factory InitializationState.progressing(int progress) {
    return InitializationState(
      initialized: progress == 100,
      initializing: true,
      progress: progress,
    );
  }

   factory InitializationState.initialized() {
    return InitializationState(
      initialized: true,
      progress: 100,
    );
  }

  // @override
  // String toString() {
  //   return '''InitializationState {
  //     initialized: $initialized,
  //     initializing: $initializing,
  //     progress: $progress,
  //   }''';
  // }
  
}