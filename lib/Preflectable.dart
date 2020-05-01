

abstract class Preflectable<TType>{
  TType singleFromMap(Map<String, dynamic> map);

  Map<String, dynamic> toJson();

  TType merge();
}

T resolveValue<T>(T currentValue, T newValue) {
  return newValue == null ? currentValue : newValue;
}
