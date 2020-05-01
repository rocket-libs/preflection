import 'package:preflection/Preflectable.dart';
import 'package:preflection/PreflectorError.dart';
import 'package:preflection/PreflectorTypeParsers.dart';
import 'package:preflection/preflection.dart';

class MapReader {
  final Map _map;

  MapReader(this._map);

  TType read<TType>(String key) {
    _throwExceptionOnInsufficientData(key);
    final fnParser = PreflectorTypeParsers.getParser<TType>();
    return fnParser(_map[key]);
  }

  List<T> getList<T extends Preflectable<T>>(String key) {
    _throwExceptionOnInsufficientData(key);
    return Preflector.deserializeMany<T>(_map[key]);
  }

  T getSingle<T extends Preflectable<T>>(String key) {
    _throwExceptionOnInsufficientData(key);
    return Preflector.deserializeSingle(_map[key]);
  }

  _throwExceptionOnInsufficientData(String key){
    _throwExceptionOnNullMap();
    _throwExceptionOnMissingKey(key);
  }

  _throwExceptionOnMissingKey(key) {
    if (!_map.containsKey(key)) {
      throw new PreflectorError("Unknown key $key for map. Preflector cannot parse");
    }
  }

  _throwExceptionOnNullMap(){
    if (_map == null) {
      throw new PreflectorError("Map is null. Preflector cannot parse value");
    }
  }
  
}
