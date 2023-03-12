import 'package:flutter_test/flutter_test.dart';
import 'package:preflection/Preflectable.dart';
import 'package:preflection/PreflectorTypeParsers.dart';
import 'package:preflection/Serializer.dart';
import 'package:preflection/preflection.dart';

import 'DummyModelAlpha.dart';
import 'DummyModelBeta.dart';
import 'DummyModelCharlie.dart';

void main() {
  PreflectorFactory.instance
      .addCreator<DummyModelBeta>(() => new DummyModelBeta())
      .addCreator<DummyModelAlpha>(() => new DummyModelAlpha())
      .addCreator<DummyModelCharlie>(() => new DummyModelCharlie());
  PreflectorTypeParsers.instance.registerInBuiltParsers();

  group("Serialization And Deserialization:", () {
    final dummyModelBeta = new DummyModelBeta(name: "Johnny Bravo");

    final charlies = new List<DummyModelCharlie>.empty(growable: true)
      ..add(new DummyModelCharlie(date: DateTime.now()))
      ..add(new DummyModelCharlie(date: DateTime.now().add(Duration(days: 2))));

    final dummyAlphaModel = new DummyModelAlpha(
        date: DateTime.now(),
        dummyModelBeta: dummyModelBeta,
        flag: true,
        name: "John Doe",
        number: 33,
        charlies: charlies);

    void _conversionCycle<TModel extends Preflectable>(
        Preflectable dummyModel) {
      final serializedModel = dummyModel.toJson();
      final TModel deserialized =
          Serializer.deserializeSingle<TModel>(serializedModel)!;
      final reserialized = deserialized.toJson();
      expect(reserialized, serializedModel);
    }

    test("Simple Conversion",
        () => _conversionCycle<DummyModelBeta>(dummyModelBeta));
    test(
        "Simple Conversion With number",
        () =>
            _conversionCycle<DummyModelBeta>(dummyModelBeta.merge(number: 3)));
    test("Complex Conversion",
        () => _conversionCycle<DummyModelAlpha>(dummyAlphaModel));

    test("Nulls are not mutated",
        () => _conversionCycle<DummyModelAlpha>(new DummyModelAlpha()));

    test("List Conversion", () {
      final listAlphasMap = List<DummyModelAlpha>.empty(growable: true)
        ..add(dummyAlphaModel)
        ..add(dummyAlphaModel);

      final serialized = Serializer.serializeMany(listAlphasMap);
      final listAlphasRehydrated =
          Serializer.deserializeMany<DummyModelAlpha>(serialized)!;
      final reserialized = Serializer.serializeMany(listAlphasRehydrated);

      expect(listAlphasRehydrated.length, 2);
      expect(reserialized, serialized);
    });

    test("Null map returns null", () {
      expect(Serializer.deserializeSingle(null), null);
    });

    group("Resolve Value:", () {
      test("old value is kept when new value is null", () {
        final oldValue = 3;
        final result = resolveValue(oldValue, null);
        expect(result, oldValue);
      });

      test("New is picked up when old value is null", () {
        final newValue = 3;
        final result = resolveValue(null, newValue);
        expect(result, newValue);
      });

      test("New overwrites old", () {
        final newValue = 3;
        final oldValue = 7;
        final result = resolveValue(oldValue, newValue);
        expect(result, newValue);
      });
    });
  });
}
