import 'package:preflection/MapReader.dart';
import 'package:preflection/Preflectable.dart';

import 'DummyModelBeta.dart';

class DummyModelAlpha extends Preflectable<DummyModelAlpha>{
  final String name;
  final double number;
  final bool flag;
  final DateTime date;
  final DummyModelBeta dummyModelBeta;

  DummyModelAlpha({this.name, this.number, this.flag, this.date, this.dummyModelBeta});
  
  @override
  DummyModelAlpha singleFromMap(Map<String, dynamic> map) {
    final mapReader = new MapReader(map);
    return new DummyModelAlpha(
      date: mapReader.read<DateTime>("date"),
      dummyModelBeta: mapReader.getSingle<DummyModelBeta>("dummyModelBeta"),
      flag: mapReader.read<bool>("flag"),
      name: mapReader.read<String>("name"),
      number: mapReader.read<double>("number")
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "date": date.toString(),
      "dummyModelBeta": dummyModelBeta.toJson(),
      "flag": flag,
      "name": name,
      "number": number,
    };
  }

}