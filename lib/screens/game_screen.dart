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
            children: <Widget>[
              Expanded(child: Center(child: Text('Nós'))),
              Center(child: Text('Truco', style: TextStyle(fontSize: 30),)),
              Expanded(child: Center(child: Text('Eles'))),
            ],
          ),
        ),
        body: Container(
          color: Colors.green[600],
          child: Column(
            children: <Widget>[
              
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    
                    _ourPoint(),
                    
                    Center(child: Text('x', style: TextStyle(color: Colors.white, fontSize: 72.0),),),
                    
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
                padding: const EdgeInsets.symmetric(horizontal: 10),
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
                height: 90,
                child: Text('...'),
              ),
            
            ],
          ),
        ),
      ),
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
            fontSize: 74.0,
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
            fontSize: 74.0,
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
                    return Center(
                      child: Text(
                        '${state.ourPoints[state.ourPoints.length - (index + 1)].toString()}  ${state.theyPoints[state.theyPoints.length - (index + 1)].toString()}',
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