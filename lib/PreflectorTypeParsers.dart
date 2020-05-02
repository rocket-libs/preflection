import 'package:preflection/PreflectorError.dart';

class PreflectorTypeParsers{
  static final Map<Type,dynamic Function(dynamic)> _typeHelpers = {};
  
  static registerInBuiltParsers(){
    register<double>(_InbuiltHelpers.getDouble);
    register<bool>(_InbuiltHelpers.getBool);
    register<DateTime>(_InbuiltHelpers.getDateTime);
    register<int>(_InbuiltHelpers.getInt);
    register<String>(_InbuiltHelpers.getString);
  }

  static register<TType>(TType Function(dynamic value) fnParser){
    _registrationWriter<TType>(fnParser);
    _registerListParser<TType>();
  }

  static _registerListParser<TType>(){
    _registrationWriter<List<TType>>((value) => _listDeserializer<TType>(value));
  }

  static _registrationWriter<TType>(TType Function(dynamic value) fnParser){
    _typeHelpers[TType] = fnParser;
  }

  static _listDeserializer<TType>(dynamic value){
    if(value == null){
      return null;
    }else{
      return (value as List).map((item) => item as TType).toList();
    }
  }

  static TType Function(dynamic) getParser<TType>(){
    final parserDoesNotExist = _typeHelpers.containsKey(TType) == false;
    if(parserDoesNotExist){
      throw new PreflectorError("No parser for type '$TType' has been registered in preflector");
    }else{
      return _typeHelpers[TType];
    }
  }

}

class _InbuiltHelpers {
  static double getDouble(value) {
    if (_isEmpty(value)) {
      return null;
    } else {
      return double.parse(value.toString());
    }
  }

  static int getInt(value) {
    if (_isEmpty(value)) {
      return null;
    } else {
      return int.parse(value.toString());
    }
  }

  static String getString(value){
    if(_isEmpty(value)){
      return null;
    }else{
      return value.toString();
    }
  }

  static bool _isEmpty(value) {
    return value == null || value.toString().isEmpty;
  }

  static bool getBool(value) {
    if (_isEmpty(value)) {
      return null;
    } else {
      return value.toString().toLowerCase() == "true";
    }
  }

  static DateTime getDateTime(value) {
    if (_isEmpty(value)) {
      return null;
    } else {
      return DateTime.parse(value.toString());
    }
  }
}


