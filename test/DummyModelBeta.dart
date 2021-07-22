import 'package:flutter/foundation.dart';
import 'package:preflection/MapReader.dart';
import 'package:preflection/Preflectable.dart';

@immutable
class DummyModelBeta extends Preflectable<DummyModelBeta>{
  final String? name;
  final int? number;

  DummyModelBeta({this.number, this.name});
  
  @override
  DummyModelBeta singleFromMap(Map<String, dynamic> map) {
    final mapReader = new MapReader(map);
    return new DummyModelBeta(
      name: mapReader.read<String>("name"),
      number: mapReader.read<int>("number"),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "name" : name,
      "number": number,
    };
  }

  @override
  DummyModelBeta merge({String? name,int? number}) {
    return new DummyModelBeta(name: name, number: number);
  }

}