import 'dart:async';
import 'package:gestion_estados_bloc/bloc/CounterRepository.dart';
import 'package:gestion_estados_bloc/bloc/SegundoBloc.dart';

class CounterBase {}

class IncrementCounter extends CounterBase {}

class ClearCounter extends CounterBase {}

class FetchCounter extends CounterBase {}

class CounterBloc {
  //el constructor llama al factory que retorna la instancia completa
  CounterRepository repository = CounterRepository();
  //StreamController: Clase que permite tener interfaz con un sink para insertar eventos y un stream para escucharlos
  StreamController<CounterBase> _input =
      StreamController(); //input para insertar los eventos
  StreamController<int> _output = StreamController(); //estado

  // Stream de tipo get que va a escuchar la pantalla, así cuando alguien llame el counterStream va a ver siempre lo
  // que se inserte en el output el cual es el estado que vamos a estar cambiando y con eso la interfaz se va a poder
  // ir actualizando.
  Stream<int> get counterStream => _output.stream;
  //Con esto el usuario va a hacer un add directamente del evento que quiere enviar
  StreamSink<CounterBase> get sendEvent => _input.sink;

  //En el constructor le decimos que queremos escuchar los eventos por medio de un método llamado "onEvent"
  CounterBloc() {
    _input.stream.listen(_onEvent);
  }
  //método para cerrar los StreamController y liberar los recursos cuando ya no se necesitan
  void dispose() {
    _input.close();
    _output.close();
  }

  void _onEvent(CounterBase event) {
    //preguntamos si el evento es de tipo IncrementCounter que incremente el contador
    if (event is IncrementCounter) {
      repository.increment();
    } else if (event is ClearEvent) {
      //Si el evento es ClearCounter vuelve a 0 el contador
      repository.clear();
    }

    //Se manda el nuevo valor del counter, de esa manera cuando alguien agregue un nuevo evento al input StreamController
    //nosotros vamos a estar escuchando ese evento por medio del stream.listen del constructor y se va a llamar al método
    //que va a ejecutar la acción según el tipo de evento que sea y luego va a agregar un nuevo estado a la salida
    //que va a estar siendo escuchado por la interfaz y va a actualizar la pantalla.
    _output.add(repository.get());
  }
}
