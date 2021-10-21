import 'package:flutter/material.dart';
import 'package:gestion_estados_bloc/bloc/CounterBloc.dart';
import 'package:gestion_estados_bloc/segunda_pantalla.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

//ESTADO
class _MyHomePageState extends State<MyHomePage> {
  //Se usa el bloc directamente en el estado
  CounterBloc _bloc = CounterBloc();

  @override
  //se libera el bloc cuando no se use
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          MaterialButton(
            minWidth: 10,
            color: Colors.pink,
            child: Icon(
              Icons.arrow_circle_up,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.of(context).push(
                new MaterialPageRoute(builder: (BuildContext context) {
                  return SegundaPantalla();
                }),
                //escuchar cuando se devuelve de esa ruta
                //la pantalla
              ).then((_) {
                _bloc.sendEvent.add(FetchCounter());
              });
            },
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            //el StreamBuilder permite redibujar la pantalla
            StreamBuilder<int>(
                stream: _bloc.counterStream,
                initialData:
                    0, // se usa en caso de que el stream no de ningún evento,
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
        //Alinea los botones a la derecha
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
            heroTag: 'Button1',
            onPressed: () {
              //se manda el ClearCounter a bloc como un nuevo evento
              _bloc.sendEvent.add(ClearCounter());
            },
            tooltip: 'Clear',
            child: Icon(Icons.clear),
          ),
          //Separa los botones
          SizedBox(width: 8),
          FloatingActionButton(
            heroTag: 'Button2',
            //se manda el IncrementCounter a bloc como un nuevo evento
            onPressed: () {
              _bloc.sendEvent.add(IncrementCounter());
            },
            tooltip: 'Increment',
            child: Icon(Icons.add),
          ),
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
