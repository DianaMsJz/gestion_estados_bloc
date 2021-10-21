import 'package:flutter/material.dart';
import 'package:gestion_estados_bloc/bloc/SegundoBloc.dart';

class SegundaPantalla extends StatefulWidget {
  SegundaPantalla({Key? key}) : super(key: key);

  @override
  _SegundaPantallaState createState() => _SegundaPantallaState();
}

class _SegundaPantallaState extends State<SegundaPantalla> {
  SegundoBloc _bloc = SegundoBloc();

  @override
  void initState() {
    super.initState();
    _bloc.sendEvent.add(FetchEvent());
  }

  @override
  //para liberar los recursos
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Segunda pantalla'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Now counter is: ',
            ),
            //el StreamBuilder permite redibujar la pantalla
            StreamBuilder<int>(
                stream: _bloc.counterStream,
                builder: (context, snapshot) {
                  return Text(
                    '${snapshot.data}',
                    style: Theme.of(context).textTheme.headline4,
                  );
                }),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
            heroTag: 'Button1',
            onPressed: () {
              _bloc.sendEvent.add(ClearEvent());
            },
            tooltip: 'Clear',
            child: Icon(Icons.clear),
          ),
          //Separa los botones
          SizedBox(width: 8),
          FloatingActionButton(
            heroTag: 'Button2',
            onPressed: () {
              _bloc.sendEvent.add(DoubleEvent());
            },
            tooltip: 'Increment',
            child: Icon(Icons.trending_up),
          ),
        ],
      ),
    );
  }
}
