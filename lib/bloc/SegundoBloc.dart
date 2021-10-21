import 'dart:async';
import 'package:gestion_estados_bloc/bloc/CounterRepository.dart';

class DoubleBase {}

class DoubleEvent extends DoubleBase {}

class ClearEvent extends DoubleBase {}

class FetchEvent extends DoubleBase {}

class SegundoBloc {
  CounterRepository repository = CounterRepository();

  StreamController<DoubleBase> _input =
      StreamController(); //input para insertar los eventos
  StreamController<int> _output = StreamController(); //estado

  // Stream de tipo get que va a escuchar la pantalla, así cuando alguien llame el counterStream va a ver siempre lo
  // que se inserte en el output el cual es el estado que vamos a estar cambiando y con eso la interfaz se va a poder
  // ir actualizando.
  Stream<int> get counterStream => _output.stream;
  //Con esto el usuario va a hacer un add directamente del evento que quiere enviar
  StreamSink<DoubleBase> get sendEvent => _input.sink;

  SegundoBloc() {
    _input.stream.listen(_onEvent);
  }
  //método para cerrar los StreamController y liberar los recursos cuando ya no se necesitan
  void dispose() {
    _input.close();
    _output.close();
  }

  void _onEvent(DoubleBase event) {
    //preguntamos si el evento es de tipo DoubleEvent para que multiplique el valor del contador
    if (event is DoubleEvent) {
      repository.double();
    } else if (event is ClearEvent) {
      repository.clear();
    }

    //Se manda el nuevo valor del counter, de esa manera cuando alguien agregue un nuevo evento al input StreamController
    //nosotros vamos a estar escuchando ese evento por medio del stream.listen del constructor y se va a llamar al método
    //que va a ejecutar la acción según el tipo de evento que sea y luego va a agregar un nuevo estado a la salida
    //que va a estar siendo escuchado por la interfaz y va a actualizar la pantalla.
    _output.add(repository.get());
  }
}
