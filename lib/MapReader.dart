import 'package:preflection/MapValidator.dart';
import 'package:preflection/Preflectable.dart';
import 'package:preflection/PreflectorTypeParsers.dart';
import 'package:preflection/preflection.dart';

class MapReader {
  final Map _map;
  MapValidator _mapValidator;

  MapReader(this._map){
    _mapValidator = new MapValidator(_map);
  }

  TType read<TType>(String key) {
    _mapValidator.throwErrorOnMissingKey(key);
    final fnParser = PreflectorTypeParsers.getParser<TType>();
    return fnParser(_map[key]);
  }

  List<T> getList<T extends Preflectable<T>>(String key) {
    _mapValidator.throwErrorOnMissingKey(key);
    return Preflector.deserializeMany<T>(_map[key]);
  }

  T getSingle<T extends Preflectable<T>>(String key) {
    _mapValidator.throwErrorOnMissingKey(key);
    return Preflector.deserializeSingle(_map[key]);
  }

  
  
}
