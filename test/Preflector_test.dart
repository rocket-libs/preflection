import 'package:flutter_test/flutter_test.dart';
import 'package:preflection/PreflectorTypeParsers.dart';
import 'package:preflection/preflection.dart';

import 'DummyModelBeta.dart';



void main(){
  Preflector.addTypeToFactory<DummyModelBeta>(() => new DummyModelBeta());
  PreflectorTypeParsers.registerInBuiltParsers();
  test("addTypeToFactory happy path",(){
    final dummyModelBeta = new DummyModelBeta(
      name: "Johnny Bravo"
    );
    final serializedModel = dummyModelBeta.toJson();
    final deserialized = Preflector.deserializeSingle<DummyModelBeta>(serializedModel);
    final reserialized = deserialized.toJson();
    expect(reserialized, serializedModel);
  });
}