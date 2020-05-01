import 'package:preflection/Preflectable.dart';

class DummyModelBeta extends Preflectable<DummyModelBeta>{
  final String name;

  DummyModelBeta({this.name});
  
  @override
  DummyModelBeta singleFromMap(Map<String, dynamic> map) {
    return new DummyModelBeta(name: map["name"]);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "name" : name
    };
  }

}