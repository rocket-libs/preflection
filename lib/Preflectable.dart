

abstract class Preflectable<TType>{
  TType singleFromMap(Map<String, dynamic> map);

  Map<String, dynamic> toJson();
}
