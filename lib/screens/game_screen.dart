import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:truco/blocs/game/game.dart';


class GameScreen extends StatefulWidget {
  @override
  _GameScrenState createState() => _GameScrenState();
  }
  
class _GameScrenState extends State<GameScreen>{

  GameBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = GameBloc();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<GameBloc>(
      bloc: bloc,
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[

              Text('Nós'),
              Text('Truco', style: TextStyle(fontSize: 30)),
              Text('Eles'),
            
            ],
          ),
        ),
        body: BlocBuilder(
          bloc: bloc,
          builder: (BuildContext context, GameState state) {

            if (bloc.currentState.ourPoint > 11 || bloc.currentState.theyPoint > 11) {
              WidgetsBinding.instance.addPostFrameCallback((_){
                _newRoundDialog();
              });
            }

            return Container(
              color: Colors.green[600],
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[

                        _round(state.ourRounds.toString()),
                        Text('Rodadas', style: TextStyle(color: Colors.white70),),
                        _round(state.theyRounds.toString()),

                      ],
                    ),
                  ),
                  
                  Container(
                    padding: EdgeInsets.only(bottom: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        
                        _point(state.ourPoint.toString()),
                        Text('x', style: TextStyle(color: Colors.white, fontSize: 70.0),),
                        _point(state.theyPoint.toString()),
                      
                      ],
                    ),
                  ),

                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        
                        _ourButtons(bloc),
                        _plays(bloc),
                        _theyButtons(bloc),

                      ],
                    ),
                  ),

                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[

                        RaisedButton(
                          onPressed: () => bloc.dispatch(NewGame()),
                          child: Text('Novo Jogo'),
                        ),

                        RaisedButton(
                          onPressed: () => bloc.dispatch(BackPlay()),
                          child: Text('Voltar Jogada'),
                        ),
                      
                      ],
                    ),
                  ),

                  Container(
                    margin: EdgeInsets.only(top: 40),
                    padding: const EdgeInsets.only(top: 20),
                    height: 60,
                    // child: Text('...'),
                  ),
                
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Future<void> _newRoundDialog() {
    
    if (bloc.currentState.ourPoint >= 12) bloc.dispatch(OurRound());
    if (bloc.currentState.theyPoint >= 12) bloc.dispatch(TheyRound());
    
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Nós x Eles', textAlign: TextAlign.center),
          content: Text(
            '${bloc.currentState.ourRounds.toString()} x ${bloc.currentState.theyRounds.toString()}',
            textAlign: TextAlign.center,
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Nova Partida'),
              onPressed: () {
                bloc.dispatch(NewMatch());
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget _round(String round) {
    return Text(
      round,
      style: TextStyle(
        color: Colors.white,
      ),
    );
  }

  Widget _point(String point) {
    return Text(
      point,
      style: TextStyle(
        color: Colors.white,
        fontSize: 100.0,
      ),
    );
  }

  Widget _button(String title, GameBloc bloc, GameEvent event) {
    return FloatingActionButton(
      heroTag: null,
      onPressed: () {

        int ourPoint = bloc.currentState.ourPoint;
        int theyPoint = bloc.currentState.theyPoint;

        if (event is OurMoreOne && ourPoint < 12 && theyPoint < 12) {
          bloc.dispatch(event);
        }
        if (event is OurMoreThree && ourPoint < 12 && theyPoint < 12) {
          bloc.dispatch(event);
        }
        if (event is OurMoreSix && ourPoint < 11 && theyPoint < 11) {
          bloc.dispatch(event);
        }
        if (event is OurMoreNine && ourPoint < 11 && theyPoint < 11) {
          bloc.dispatch(event);
        }
        if (event is TheyMoreOne && theyPoint < 12 && ourPoint < 12) {
          bloc.dispatch(event);
        }
        if (event is TheyMoreThree && theyPoint < 12 && ourPoint < 12) {
          bloc.dispatch(event);
        }
        if (event is TheyMoreSix && theyPoint < 11 && ourPoint < 11) {
          bloc.dispatch(event);
        }
        if (event is TheyMoreNine && theyPoint < 11 && ourPoint < 11) {
          bloc.dispatch(event);
        }        
      },
      child: Text(title, style: TextStyle(fontSize: 18),),
    );
  }

  Widget _ourButtons(GameBloc bloc) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          _button('+1', bloc, OurMoreOne()),
          _button('+3', bloc, OurMoreThree()),
          _button('+6', bloc, OurMoreSix()),
          _button('+9', bloc, OurMoreNine()),
        ], 
      ),
    );
  }

  Widget _theyButtons(GameBloc bloc) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          _button('+1', bloc, TheyMoreOne()),
          _button('+3', bloc, TheyMoreThree()),
          _button('+6', bloc, TheyMoreSix()),
          _button('+9', bloc, TheyMoreNine()),
        ], 
      ),
    );
  }

  Widget _plays(GameBloc bloc) {
    return Expanded(
      child: Column(
        children: <Widget>[
          Text('Partidas', style: TextStyle(color: Colors.white70),),
          Flexible(
            child: BlocBuilder<GameEvent, GameState>(
              bloc: bloc,
              builder: (BuildContext context, GameState state) {
                return ListView.builder(
                  itemCount: state.ourPoints.length,
                  itemBuilder: (BuildContext context, int index) {

                    int our = state.ourPoints[state.ourPoints.length - (index + 1)];
                    int they = state.theyPoints[state.theyPoints.length - (index + 1)];
                    
                    return Center(
                      child: Text(
                        '${our.toString()}  ${they.toString()}',
                        style: TextStyle(
                          color: Colors.white30,
                          fontSize: 42.0,
                        ),
                      ),
                    );
                  },
                );
              }
            ),
          ),
        ],
      ),
    );    
  }

}