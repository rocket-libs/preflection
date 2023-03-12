import 'package:flutter_test/flutter_test.dart';
import 'package:preflection/PreflectorError.dart';

void main() {
  test("toString() returns error message", () {
    const String errorMessage = "Something nasty";
    var error = new PreflectorError(errorMessage);
    expect(error.toString(), errorMessage);
  });
}
