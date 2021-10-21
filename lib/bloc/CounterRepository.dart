//Clase para mantener un estado entre dos pantallas, dos bloc diferentes. Actua como una
//interfaz en el medio para que el bloc no conozca detalles de dónde vienen los datos.

class CounterRepository {
  int _count = 0;

  //Para pasar este repositorio a las pantallas, se crea una instancia del repositorio
  //que sea compartida por todos los bloc

  // se genera una instancia privada que llame al constructor
  static CounterRepository _instance = CounterRepository._internal();

  //se define un constructor privado
  CounterRepository._internal();

  //Factory es el método que genera las instancias, retorna la instancia
  factory CounterRepository() {
    return _instance;
  }

  //para contener el valor del count y que se mantenga oculto
  int get() {
    return _count;
  }

  void increment() {
    _count++;
  }

  void clear() {
    _count = 0;
  }

  void double() {
    _count *= 2;
  }
}
