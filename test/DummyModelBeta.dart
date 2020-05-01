import 'package:flutter/foundation.dart';
import 'package:preflection/MapReader.dart';
import 'package:preflection/Preflectable.dart';

@immutable
class DummyModelBeta extends Preflectable<DummyModelBeta>{
  final String name;

  DummyModelBeta({this.name});
  
  @override
  DummyModelBeta singleFromMap(Map<String, dynamic> map) {
    final mapReader = new MapReader(map);
    return new DummyModelBeta(
      name: mapReader.read<String>("name")
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "name" : name
    };
  }

  @override
  DummyModelBeta merge({String name}) {
    return new DummyModelBeta(name: name);
  }

}