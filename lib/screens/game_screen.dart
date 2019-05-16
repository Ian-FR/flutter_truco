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
          color: Colors.green,
          child: Column(
            children: <Widget>[
              
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Center(
                        child: _ourPoint(),
                      ),
                    ),
                    Center(child: Text('x', style: TextStyle(
                      color: Colors.white,
                      fontSize: 72.0,
                    ),),),
                    Expanded(
                      child: Center(
                        child: _theyPoint(),
                      ),
                    ),
                  ],
                ),
              ),

              Expanded(
                child: Center(
                  child: Row(
                    children: <Widget>[
                      
                      _ourButtons(),

                      Expanded(
                        child: Column(
                          children: <Widget>[
                            Text('Partidas', style: TextStyle(color: Colors.white70),),
                            BlocBuilder<GameEvent, GameState>(
                              bloc: bloc,
                              builder: (BuildContext context, GameState state) {
                                return _matches(state.ourPoints, state.theyPoints);
                              },
                            ),
                          ],
                        ),
                      ),

                      _theyButtons(),

                    ],
                  ),
                ),
              ),

              Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: RaisedButton(
                        onPressed: () => bloc.dispatch(NewGame()),
                        child: Text('Novo Jogo'),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: RaisedButton(
                        onPressed: () => bloc.dispatch(BackMatch()),
                        child: Text('Voltar Jogada'),
                      ),
                    ),
                  ),
                ],
              ),

              Container(
                margin: EdgeInsets.only(top: 40),
                padding: const EdgeInsets.only(top: 20),
                height: 90,
                child: Text('...')
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

  Widget _ourButtons() {
    return Expanded(
      child: Column(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.all(8.0),
            child: FloatingActionButton(
              heroTag: null,
              onPressed: () => bloc.dispatch(OurMoreOne()),
              child: Text('+1', style: TextStyle(fontSize: 18),),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(8.0),
            child: FloatingActionButton(
              heroTag: null,
              onPressed: () => bloc.dispatch(OurMoreThree()),
              child: Text('+3', style: TextStyle(fontSize: 18),),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(8.0),
            child: FloatingActionButton(
              heroTag: null,
              onPressed: () => bloc.dispatch(OurMoreSix()),
              child: Text('+6', style: TextStyle(fontSize: 18),),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(8.0),
            child: FloatingActionButton(
              heroTag: null,
              onPressed: () => bloc.dispatch(OurMoreNine()),
              child: Text('+9', style: TextStyle(fontSize: 18),),
            ),
          ),
        ], 
      ),
    );
  }

  Widget _theyButtons() {
    return Expanded(
      child: Column(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.all(8.0),
            child: FloatingActionButton(
              heroTag: null,
              onPressed: () => bloc.dispatch(TheyMoreOne()),
              child: Text('+1', style: TextStyle(fontSize: 18),),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(8.0),
            child: FloatingActionButton(
              heroTag: null,
              onPressed: () => bloc.dispatch(TheyMoreThree()),
              child: Text('+3', style: TextStyle(fontSize: 18),),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(8.0),
            child: FloatingActionButton(
              heroTag: null,
              onPressed: () => bloc.dispatch(TheyMoreSix()),
              child: Text('+6', style: TextStyle(fontSize: 18),),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(8.0),
            child: FloatingActionButton(
              heroTag: null,
              onPressed: () => bloc.dispatch(TheyMoreNine()),
              child: Text('+9', style: TextStyle(fontSize: 18),),
            ),
          ),
        ], 
      ),
    );
  }

  Widget _matches(List<int> our, List<int> they) {
    return  Flexible(
      child: ListView.builder(
        itemCount: our.length,
        itemBuilder: (BuildContext context, int index) {
          return Center(
            child: Text(
              '${our[our.length - (index + 1)].toString()}  ${they[they.length - (index + 1)].toString()}',
              style: TextStyle(
                color: Colors.white30,
                fontSize: 42.0,
              ),
            ),
          );
        },
      ),
    );
  }
}