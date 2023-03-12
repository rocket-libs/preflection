import 'package:preflection/Preflectable.dart';
import 'package:preflection/preflection.dart';

class Serializer {
  static List<TType?>? deserializeMany<TType extends Preflectable<TType>>(
      List<dynamic>? mapsList) {
    final List<TType?> list = new List<TType?>.empty(growable: true);
    if (mapsList == null) {
      return null;
    } else {
      final instance = PreflectorFactory.instance.create<TType>();
      for (var map in mapsList) {
        list.add(deserializeSingle(map, instance: instance));
      }
      return list;
    }
  }

  static TType? deserializeSingle<TType extends Preflectable>(
      Map<String, dynamic>? map,
      {TType? instance}) {
    if (map == null) {
      return null;
    } else {
      instance = instance ?? PreflectorFactory.instance.create<TType>();
      return instance.singleFromMap(map);
    }
  }

  static List<dynamic>? serializeMany<TType extends Preflectable?>(
      List<TType>? objectList) {
    final result = new List<dynamic>.empty(growable: true);
    if (objectList == null) {
      return null;
    } else {
      for (Preflectable? item in objectList) {
        result.add(item!.toJson());
      }
      return result;
    }
  }
}
