import 'package:flutter_test/flutter_test.dart';
import 'package:preflection/Preflectable.dart';
import 'package:preflection/PreflectorError.dart';
import 'package:preflection/PreflectorTypeParsers.dart';
import 'package:preflection/preflection.dart';

import 'DummyModelAlpha.dart';
import 'DummyModelBeta.dart';
import 'DummyModelCharlie.dart';



void main(){
  Preflector.addTypeToFactory<DummyModelBeta>(() => new DummyModelBeta());
  Preflector.addTypeToFactory<DummyModelAlpha>(() => new DummyModelAlpha());
  Preflector.addTypeToFactory<DummyModelCharlie>(() => new DummyModelCharlie());
  PreflectorTypeParsers.registerInBuiltParsers();
  
  group("Serialization And Deserialization:",(){
    final dummyModelBeta = new DummyModelBeta(
        name: "Johnny Bravo"
    );

    final charlies = new List<DummyModelCharlie>()
    ..add(new DummyModelCharlie(
      date: DateTime.now()
    ))
    ..add(new DummyModelCharlie(
      date: DateTime.now().add(Duration(days:  2))
    ));

    final dummyAlphaModel = new DummyModelAlpha(
      date: DateTime.now(),
      dummyModelBeta: dummyModelBeta,
      flag: true,
      name: "John Doe",
      number: 33,
      charlies: charlies
    );

    void _conversionCycle<TModel extends Preflectable>(Preflectable dummyModel){
      
      final serializedModel = dummyModel.toJson();
      final deserialized = Preflector.deserializeSingle<TModel>(serializedModel);
      final reserialized = deserialized.toJson();
      expect(reserialized, serializedModel);
    }
    test("Simple Conversion",() => _conversionCycle<DummyModelBeta>(dummyModelBeta));
    test("Complex Conversion",() => _conversionCycle<DummyModelAlpha>(dummyAlphaModel));

    test("List Conversion",(){
      final listAlphasMap = List<DummyModelAlpha>()
      ..add(dummyAlphaModel)
      ..add(dummyAlphaModel);

      final serialized = Preflector.serializeMany(listAlphasMap);
      final listAlphasRehydrated = Preflector.deserializeMany<DummyModelAlpha>(serialized);
      final reserialized = Preflector.serializeMany(listAlphasRehydrated);

      expect(listAlphasRehydrated.length, 2);
      expect(reserialized, serialized);
    });

    test("Null map returns null",() {
      expect(Preflector.deserializeSingle(null), null);
    });

    test("deserializeMany returns empty list on null",() {
      final result = Preflector.deserializeMany<DummyModelBeta>(null);
      final isNotNull = result != null;
      expect(isNotNull, true);
      expect(result.length, 0);
    });

  });
  
}