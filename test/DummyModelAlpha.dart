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
    return new DummyModelAlpha(
      date: 
    )
  }

  @override
  Map<String, dynamic> toJson() {
    // TODO: implement toJson
    return null;
  }

}