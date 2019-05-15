import 'package:bloc/bloc.dart';
import 'game_event.dart';
import 'game_state.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  @override
  GameState get initialState => GameState.newGame();

  @override
  Stream<GameState> mapEventToState(
    GameEvent event,
  ) async* {
    if (event is NewGame) {
      yield GameState.newGame();
    }
    if (event is BackMatch) {
      yield* _backMatch();
    }
    if (event is OurMoreOne) {
      yield* _ourMoreOne();
    }
    if (event is TheyMoreOne) {
      yield* _theyMoreOne();
    }
    if (event is OurMoreThree) {
      yield* _ourMoreThree();
    }
    if (event is TheyMoreThree) {
      yield* _theyMoreThree();
    }
    if (event is OurMoreSix) {
      yield* _ourMoreSix();
    }
    if (event is TheyMoreSix) {
      yield* _theyMoreSix();
    }
    if (event is OurMoreNine) {
      yield* _ourMoreNine();
    }
    if (event is TheyMoreNine) {
      yield* _theyMoreNine();
    }
  }

  Stream<GameState> _backMatch() async* {
    
    int ourPoint = currentState.ourPoints[currentState.ourPoints.length - 1];
    int theyPoint = currentState.theyPoints[currentState.theyPoints.length - 1];
    List<int> ourPoints = currentState.ourPoints;
    List<int> theyPoints = currentState.theyPoints;
    
    ourPoints.removeLast();
    theyPoints.removeLast();

    yield GameState(
      ourPoints: ourPoints,
      theyPoints: theyPoints,
      ourPoint: ourPoint,
      theyPoint: theyPoint,
    );
  }

  Stream<GameState> _ourMoreOne() async* {
    yield* _ourAdd(currentState, 1);
  }

  Stream<GameState> _theyMoreOne() async* {
    yield* _theyAdd(currentState, 1);
  }

  Stream<GameState> _ourMoreThree() async* {
    yield* _ourAdd(currentState, 3);
  }

  Stream<GameState> _theyMoreThree() async* {
    yield* _theyAdd(currentState, 3);
  }

  Stream<GameState> _ourMoreSix() async* {
    yield* _ourAdd(currentState, 6);
  }

  Stream<GameState> _theyMoreSix() async* {
    yield* _theyAdd(currentState, 6);
  }
  
  Stream<GameState> _ourMoreNine() async* {
    yield* _ourAdd(currentState, 9);
  }

  Stream<GameState> _theyMoreNine() async* {
    yield* _theyAdd(currentState, 9);
  }

  Stream<GameState> _theyAdd(GameState state, int point) async* {
    
    int ourPoint = state.ourPoint;
    int theyPoint = state.theyPoint;
    List<int> ourPoints = state.ourPoints ?? [0];
    List<int> theyPoints = state.theyPoints ?? [0];
    
    ourPoints.add(ourPoint ?? 0);
    theyPoints.add(theyPoint ?? 0);
    
    yield GameState(
      ourPoints: ourPoints,
      theyPoints: theyPoints,
      ourPoint: ourPoint,
      theyPoint: theyPoint + point,
    );
  }

  Stream<GameState> _ourAdd(GameState state, int point) async* {
    
    int ourPoint = state.ourPoint;
    int theyPoint = state.theyPoint;
    List<int> ourPoints = state.ourPoints ?? [0];
    List<int> theyPoints = state.theyPoints ?? [0];
    
    ourPoints.add(ourPoint ?? 0);
    theyPoints.add(theyPoint ?? 0);
    
    yield GameState(
      ourPoints: ourPoints,
      theyPoints: theyPoints,
      ourPoint: ourPoint + point,
      theyPoint: theyPoint,
    );
  }

}