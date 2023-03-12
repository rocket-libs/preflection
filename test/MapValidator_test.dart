import 'package:flutter_test/flutter_test.dart';
import 'package:preflection/MapValidator.dart';
import 'package:preflection/PreflectorError.dart';

void main() {
  group("Errors:", () {
    test("Null map throws error", () {
      expect(() => new MapValidator(null),
          throwsA((e) => e != null && e is PreflectorError));
    });

    group("Key Availability:", () {
      _keyTester(Map map, String candidateKey, bool expectError) {
        if (expectError) {
          expect(
              () => new MapValidator(map).throwErrorOnMissingKey(candidateKey),
              throwsA((e) => e != null && e is PreflectorError));
        } else {
          expect(
              new MapValidator(map).throwErrorOnMissingKey(candidateKey), null);
        }
      }

      test("Missing key causes error", () => _keyTester({}, "alpha", true));
      test("Existing key does not causes error",
          () => _keyTester({"alpha": "alpha"}, "alpha", false));
    });
  });
}
