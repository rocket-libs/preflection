import 'package:flutter_test/flutter_test.dart';
import 'package:preflection/PreflectorError.dart';
import 'package:preflection/PreflectorTypeParsers.dart';

import 'DummyModelAlpha.dart';

void main(){
  
  test("Missing parser causes exception",(){
    expect(() => PreflectorTypeParsers.getParser<DummyModelAlpha>(),
     throwsA((e) => e != null && e is PreflectorError)
    );
  });
}