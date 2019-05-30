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
    if (event is NewMatch) {
      yield* _newMatch();
    }
    if (event is BackPlay) {
      yield* _backPlay();
    }
    if (event is OurRound) {
      yield* _ourRound();
    }
    if (event is TheyRound) {
      yield* _theyRound();
    }
    if (event is OurMoreOne) {
      yield* _ourAdd(currentState, 1);
    }
    if (event is OurMoreThree) {
      yield* _ourAdd(currentState, 3);
    }
    if (event is OurMoreSix) {
      yield* _ourAdd(currentState, 6);
    }
    if (event is OurMoreNine) {
      yield* _ourAdd(currentState, 9);
    }
    if (event is TheyMoreOne) {
      yield* _theyAdd(currentState, 1);
    }
    if (event is TheyMoreThree) {
      yield* _theyAdd(currentState, 3);
    }
    if (event is TheyMoreSix) {
      yield* _theyAdd(currentState, 6);
    }
    if (event is TheyMoreNine) {
      yield* _theyAdd(currentState, 9);
    }
  }

  Stream<GameState> _newMatch() async* {
    yield GameState(
      ourPoints: [],
      theyPoints: [],
      ourPoint: 0,
      theyPoint: 0,
      ourRounds: currentState.ourRounds,
      theyRounds: currentState.theyRounds,
    );
  }

  Stream<GameState> _ourRound() async* {
    int ourRounds = currentState.ourRounds;

    yield GameState(
      ourPoints: currentState.ourPoints,
      theyPoints: currentState.theyPoints,
      ourPoint: 0,
      theyPoint: 0,
      ourRounds: ourRounds + 1,
      theyRounds: currentState.theyRounds,
    );
  }

  Stream<GameState> _theyRound() async* {
    int theyRounds = currentState.theyRounds;

    yield GameState(
      ourPoints: currentState.ourPoints,
      theyPoints: currentState.theyPoints,
      ourPoint: 0,
      theyPoint: 0,
      ourRounds: currentState.ourRounds,
      theyRounds: theyRounds + 1,
    );
  }

  Stream<GameState> _backPlay() async* {
    
    int ourPoint;
    int theyPoint;

    ourPoint = currentState.ourPoints.length == 0 ? 0 : currentState.ourPoints[currentState.ourPoints.length - 1];
    theyPoint = currentState.theyPoints.length == 0 ? 0 : currentState.theyPoints[currentState.theyPoints.length - 1];

    List<int> ourPoints = currentState.ourPoints;
    List<int> theyPoints = currentState.theyPoints;
    
    if (ourPoints.length > 0) ourPoints.removeLast();
    if (theyPoints.length > 0) theyPoints.removeLast();

    yield GameState(
      ourPoints: ourPoints,
      theyPoints: theyPoints,
      ourPoint: ourPoint,
      theyPoint: theyPoint,
      ourRounds: currentState.ourRounds,
      theyRounds: currentState.theyRounds,
    );
  }

  Stream<GameState> _theyAdd(GameState state, int point) async* {
    
    int ourPoint = state.ourPoint;
    int theyPoint = state.theyPoint;
    
    List<int> ourPoints = state.ourPoints;
    List<int> theyPoints = state.theyPoints;
    
    ourPoints.add(ourPoint);
    theyPoints.add(theyPoint);

    yield GameState(
      ourPoints: ourPoints,
      theyPoints: theyPoints,
      ourPoint: ourPoint,
      theyPoint: theyPoint + point,
      ourRounds: currentState.ourRounds,
      theyRounds: currentState.theyRounds,
    );
  }

  Stream<GameState> _ourAdd(GameState state, int point) async* {
    
    int ourPoint = state.ourPoint;
    int theyPoint = state.theyPoint;

    List<int> ourPoints = state.ourPoints;
    List<int> theyPoints = state.theyPoints;
    
    ourPoints.add(ourPoint);
    theyPoints.add(theyPoint);
    
    yield GameState(
      ourPoints: ourPoints,
      theyPoints: theyPoints,
      ourPoint: ourPoint + point,
      theyPoint: theyPoint,
      ourRounds: currentState.ourRounds,
      theyRounds: currentState.theyRounds,
    );
  }

}