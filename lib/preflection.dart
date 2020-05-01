library preflection;

import 'package:bargain_di/ObjectFactory.dart';
import 'package:preflection/Preflectable.dart';



class Preflector {
  static final _objectFactory = new ObjectFactory();
    

  static void addTypeToFactory<TType>(TType Function() typeCreator){
    _objectFactory.register<TType>(typeCreator);
  }
  

  static List<TType> deserializeMany<TType extends Preflectable<TType>>(
      List<dynamic> mapsList) {
    final List<TType> list = new List<TType>();
    if(mapsList == null){
      return list;
    }else{
      final instance = _objectFactory.getInstance<TType>();
      
      for (var map in mapsList) {
        list.add(deserializeSingle(map, instance: instance));
      }
      return list;
    }
  }

  static TType deserializeSingle<TType extends Preflectable>(
      Map<String, dynamic> map,
      {TType instance}) {
    if(map == null){
      return null;
    }else{
      instance = instance ?? _objectFactory.getInstance<TType>();
      return instance.singleFromMap(map);
    }
  }

  static List<dynamic> serializeMany<TType extends Preflectable>(
      List<TType> objectList) {
    final result = new List<dynamic>();
    if(objectList == null){
      return null;
    }else{
      for (Preflectable item in objectList) {
        result.add(item.toJson());
      }
      return result;
    }
  }
}
