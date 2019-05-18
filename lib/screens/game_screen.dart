import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
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
        body: Container(
          color: Colors.green[600],
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[

                    _ourRounds(),
                    Text('Rodadas', style: TextStyle(color: Colors.white70),),
                    _theyRounds(),

                  ],
                ),
              ),
              
              Container(
                padding: EdgeInsets.only(bottom: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    
                    _ourPoint(),
                    Text('x', style: TextStyle(color: Colors.white, fontSize: 70.0),),
                    _theyPoint(),
                  
                  ],
                ),
              ),

              Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      
                      _ourButtons(),
                      _matches(bloc),
                      _theyButtons(),

                    ],
                  ),
              ),

              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[

                    RaisedButton(
                      onPressed: () => bloc.dispatch(NewGame()),
                      child: Text('Novo Jogo'),
                    ),

                    RaisedButton(
                      onPressed: () => bloc.dispatch(BackMatch()),
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
        ),
      ),
    );
  }

  Widget _ourRounds() {
    return BlocBuilder<GameEvent, GameState>(
      bloc: bloc,
      builder: (BuildContext context, GameState state) {
        if (bloc.currentState.ourPoint >= 12) {
          bloc.dispatch(OurRound());
        }
        return Text(
          state.ourRounds.toString(),
          style: TextStyle(
            color: Colors.white,
          ),
        );
      },
    );
  }

  Widget _theyRounds() {
    return BlocBuilder<GameEvent, GameState>(
      bloc: bloc,
      builder: (BuildContext context, GameState state) {
        if (bloc.currentState.theyPoint >= 12) {
          bloc.dispatch(TheyRound());
        }
        return Text(
          state.theyRounds.toString(),
          style: TextStyle(
            color: Colors.white,
          ),
        );
      },
    );
  }

  Widget _ourPoint() {
    return BlocBuilder<GameEvent, GameState>(
      bloc: bloc,
      builder: (BuildContext context, GameState state) {
        return Text(
          state.ourPoint.toString(),
          style: TextStyle(
            color: Colors.white,
            fontSize: 100.0,
          ),
        );
      },
    );
  }

  Widget _theyPoint() {
    return BlocBuilder<GameEvent, GameState>(
      bloc: bloc,
      builder: (BuildContext context, GameState state) {
        return Text(
          state.theyPoint.toString(),
          style: TextStyle(
            color: Colors.white,
            fontSize: 100.0,
          ),
        );
      },
    );
  }

  Widget _button(String title, GameEvent event) {
    return FloatingActionButton(
      heroTag: null,
      onPressed: () => bloc.dispatch(event),
      child: Text(title, style: TextStyle(fontSize: 18),),
    );
  }

  Widget _ourButtons() {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          _button('+1', OurMoreOne()),
          _button('+3', OurMoreThree()),
          _button('+6', OurMoreSix()),
          _button('+9', OurMoreNine()),
        ], 
      ),
    );
  }

  Widget _theyButtons() {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          _button('+1', TheyMoreOne()),
          _button('+3', TheyMoreThree()),
          _button('+6', TheyMoreSix()),
          _button('+9', TheyMoreNine()),
        ], 
      ),
    );
  }

  Widget _matches(GameBloc bloc) {
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