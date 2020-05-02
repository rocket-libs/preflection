import 'package:flutter/foundation.dart';
import 'package:preflection/MapReader.dart';
import 'package:preflection/Preflectable.dart';
import 'package:preflection/Serializer.dart';
import 'package:preflection/preflection.dart';

import 'DummyModelBeta.dart';
import 'DummyModelCharlie.dart';

@immutable
class DummyModelAlpha extends Preflectable<DummyModelAlpha>{
  final String name;
  final double number;
  final bool flag;
  final DateTime date;
  final DummyModelBeta dummyModelBeta;
  final List<DummyModelCharlie> charlies;

  DummyModelAlpha({this.charlies,this.name, this.number, this.flag, this.date, this.dummyModelBeta});
  
  @override
  DummyModelAlpha singleFromMap(Map<String, dynamic> map) {
    final mapReader = new MapReader(map);
    return new DummyModelAlpha(
      date: mapReader.read<DateTime>("date"),
      dummyModelBeta: mapReader.getSingle<DummyModelBeta>("dummyModelBeta"),
      flag: mapReader.read<bool>("flag"),
      name: mapReader.read<String>("name"),
      number: mapReader.read<double>("number"),
      charlies: mapReader.getList<DummyModelCharlie>("charlies")
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "date": date?.toString(),
      "dummyModelBeta": dummyModelBeta?.toJson(),
      "flag": flag,
      "name": name,
      "number": number,
      "charlies": Serializer.serializeMany(charlies)
    };
  }

  @override
  DummyModelAlpha merge({String nameNew, double numberNew, bool flagNew, DateTime dateNew, DummyModelBeta dummyModelBetaNew, List<DummyModelCharlie> charliesNew}) {
    return new DummyModelAlpha(
      date: resolveValue(date, dateNew),
      dummyModelBeta: resolveValue(dummyModelBeta, dummyModelBetaNew),
      flag: resolveValue(flag, flagNew),
      name: resolveValue(name, nameNew),
      number: resolveValue(number, numberNew),
      charlies: resolveValue(charlies, charliesNew)
    );
  }

}