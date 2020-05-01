class MapReader {
  final Map map;

  MapReader(this.map);

  Guid getGuid(String key) {
    if (map == null) {
      return null;
    } else {
      _throwExceptionOnMissingKey(key);
      return new Guid(map[key]);
    }
  }

  _throwExceptionOnMissingKey(key) {
    if (!map.containsKey(key)) {
      throw new Exception("Unknown key $key for map");
    }
  }

  getDateTime(String key) {
    if (map == null) {
      return null;
    }
    return TypeHelper.getDateTime(map[key]);
  }

  getBool(String key) {
    if (map == null) {
      return false;
    }
    var value = map[key];
    return TypeHelper.getBool(value);
  }

  getDouble(String key) {
    if (map == null) {
      return 0.0;
    } else {
      return TypeHelper.getDouble(map[key]);
    }
  }

  int getInt(key) {
    if (map == null) {
      return 0;
    } else {
      return TypeHelper.getInt(map[key]);
    }
  }

  String getString(String key) {
    if (map == null) {
      return null;
    } else {
      return map[key];
    }
  }

  List<T> getList<T extends Model<T>>(String key) {
    return ModelDeserializationHelper.deserializeMany<T>(map[key]);
  }

  T getSingle<T extends Model<T>>(String key) {
    if(map== null){
      return null;
    }else{
      return ModelDeserializationHelper.deserializeSingle(map[key]);
    }
  }
}
