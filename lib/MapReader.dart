import 'package:preflection/MapValidator.dart';
import 'package:preflection/Preflectable.dart';
import 'package:preflection/PreflectorTypeParsers.dart';
import 'package:preflection/Serializer.dart';

class MapReader {
  final Map _map;
  late MapValidator _mapValidator;

  MapReader(this._map){
    _mapValidator = new MapValidator(_map);
  }

  TType read<TType>(String key) {
    _mapValidator.throwErrorOnMissingKey(key);
    final fnParser = PreflectorTypeParsers.instance.getParser<TType>()!;
    return fnParser(_map[key]);
  }

  List<T?>? getList<T extends Preflectable<T>>(String key) {
    _mapValidator.throwErrorOnMissingKey(key);
    return Serializer.deserializeMany<T>(_map[key]);
  }

  T? getSingle<T extends Preflectable<T>>(String key) {
    _mapValidator.throwErrorOnMissingKey(key);
    return Serializer.deserializeSingle(_map[key]);
  }

  
  
}
