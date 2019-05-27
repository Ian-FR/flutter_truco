import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:truco/blocs/initialization/initialization.dart';

class InitializationScreen extends StatefulWidget {
  @override
  _InitializationScreenState createState() => _InitializationScreenState();
}

class _InitializationScreenState extends State<InitializationScreen>{

  InitializationBloc _bloc;
  
  @override
  void initState() {
    super.initState();
    _bloc = InitializationBloc();
    _bloc.dispatch(AppStart());
  }

  @override
  void dispose() {
    _bloc?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext screenContext){
    return SafeArea(
      child: Scaffold(
        body: Container(
          color: Colors.grey[600],
          child: Center(
            child: BlocBuilder<InitializationEvent, InitializationState>(
              bloc: _bloc,
              builder: (BuildContext context, InitializationState state) {
                if (state.initialized) {
                  // Uma vez que a inicialização foi concluída
                  // vamos redirecionar para outra tela
                  // depois da renderização ter sido finalizada
                  WidgetsBinding.instance.addPostFrameCallback((_){
                    Navigator.of(context).pushReplacementNamed('/game');
                  });
                }
                return CircularProgressIndicator(backgroundColor: Colors.white);
              }
            ),
          ),
        ),
      ),
    );   
  }
}
