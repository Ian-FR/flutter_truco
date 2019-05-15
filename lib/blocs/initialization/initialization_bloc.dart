import 'package:bloc/bloc.dart';
import 'initialization_event.dart';
import 'initialization_state.dart';

class InitializationBloc
  extends Bloc<InitializationEvent, InitializationState> {
  
  @override
  InitializationState get initialState => InitializationState.notInitialized();

  @override
  Stream<InitializationState> mapEventToState(
    InitializationEvent event,
  ) async* {
    if (!currentState.initialized) {
      yield InitializationState.notInitialized();
    }
    if (event is AppStart) {
      for (int progress = 0; progress < 101; progress += 10) {
        await Future.delayed(const Duration(milliseconds: 100));
        yield InitializationState.progressing(progress);
      }
    }

    if (event is AppInitialized) {
      yield InitializationState.initialized();
    }
  }
}
