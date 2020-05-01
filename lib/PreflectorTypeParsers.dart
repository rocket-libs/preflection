import 'package:flutter_guid/flutter_guid.dart';
import 'package:preflection/PreflectorError.dart';

class PreflectorTypeParsers{
  static final Map<Type,dynamic Function(dynamic)> _typeHelpers = {};
  
  static registerInBuiltParsers(){
    register<double>(_InbuiltHelpers.getDouble);
    register<bool>(_InbuiltHelpers.getBool);
    register<DateTime>(_InbuiltHelpers.getDateTime);
    register<int>(_InbuiltHelpers.getInt);
    register<String>(_InbuiltHelpers.getString);
    register<Guid>(_InbuiltHelpers.getGuid);
  }

  static register<TType>(TType Function(dynamic value) fnParser){
    _typeHelpers[TType] = fnParser;
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
      return 0.0;
    } else {
      return double.parse(value.toString());
    }
  }

  static int getInt(value) {
    if (_isEmpty(value)) {
      return 0;
    } else {
      return int.parse(value.toString());
    }
  }

  static String getString(value){
    if(_isEmpty(value)){
      return "";
    }else{
      return value.toString();
    }
  }

  static bool _isEmpty(value) {
    return value == null || value.toString().isEmpty;
  }

  static bool getBool(value) {
    if (_isEmpty(value)) {
      return false;
    } else {
      return value.toString().toLowerCase() == "true";
    }
  }

  static DateTime getDateTime(value) {
    if (_isEmpty(value)) {
      final referenceDate = DateTime.now();
      final epoch = referenceDate.subtract(
        Duration(milliseconds: referenceDate.millisecondsSinceEpoch)
      );
      return epoch;
    } else {
      return DateTime.parse(value.toString());
    }
  }

  static Guid getGuid(value){
    return new Guid(value);
  }

}


