import 'package:uuid/uuid.dart';

class Utils {
  //Metodo para generar id unico.
  static int uuidToInt() {
    return Uuid().v4().hashCode;
  }
}
