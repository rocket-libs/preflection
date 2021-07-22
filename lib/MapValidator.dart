import 'PreflectorError.dart';
import 'PreflectorErrorCodes.dart';

class MapValidator{
  final Map _map;

  MapValidator(this._map){
    _throwErrorOnNullMap();
  }

  

  throwErrorOnMissingKey(key) {
    if (!_map.containsKey(key)) {
      throw new PreflectorError("Unknown key $key for map. Preflector cannot parse",code: PreflectorErrorCodes.MapMissingSpecifiedKey);
    }
  }

  _throwErrorOnNullMap(){
    if (_map == null) {
      throw new PreflectorError("Map is null. Preflector cannot parse value", code: PreflectorErrorCodes.MapIsNull);
    }
  }
}