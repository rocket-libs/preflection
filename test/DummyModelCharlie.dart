import 'package:preflection/MapReader.dart';
import 'package:preflection/Preflectable.dart';
import 'package:flutter/foundation.dart';

@immutable
class DummyModelCharlie extends Preflectable<DummyModelCharlie>{
  final DateTime date;

  DummyModelCharlie({this.date});
  @override
  merge({DateTime dateNew}) {
    return new DummyModelCharlie(
      date: resolveValue(date, dateNew)
    );
  }

  @override
  singleFromMap(Map<String, dynamic> map) {
    final mapReader = new MapReader(map);
    return new DummyModelCharlie(
      date: mapReader.read<DateTime>("date")
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "date": date.toString()
    };
  }

}