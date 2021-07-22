import 'package:preflection/PreflectorError.dart';

class PreflectorTypeParsers {
  static final instance = new PreflectorTypeParsers();

  final Map<Type, dynamic Function(dynamic)> _typeHelpers = {};

  PreflectorTypeParsers registerInBuiltParsers() {
    register<double?>(_InbuiltHelpers.getNullableDouble);
    register<bool?>(_InbuiltHelpers.getNullableBool);
    register<DateTime?>(_InbuiltHelpers.getNullableDateTime);
    register<int?>(_InbuiltHelpers.getNullableInt);
    register<String?>(_InbuiltHelpers.getNullableString);

    register<double>(_InbuiltHelpers.getDouble);
    register<bool>(_InbuiltHelpers.getBool);
    register<DateTime>(_InbuiltHelpers.getDateTime);
    register<int>(_InbuiltHelpers.getInt);
    register<String>(_InbuiltHelpers.getString);
    return this;
  }

  PreflectorTypeParsers register<TType>(
      TType Function(dynamic value) fnParser) {
    _registrationWriter<TType>(fnParser);
    registerListParser<TType>();
    return this;
  }

  registerListParser<TType>() {
    _registrationWriter<List<TType>>(
        (value) => _listDeserializer<TType>(value));
  }

  _registrationWriter<TType>(TType Function(dynamic value) fnParser) {
    _typeHelpers[TType] = fnParser;
  }

  _listDeserializer<TType>(dynamic value) {
    if (value == null) {
      return null;
    } else {
      return (value as List).map((item) => item as TType).toList();
    }
  }

  TType Function(dynamic)? getParser<TType>() {
    final parserDoesNotExist = _typeHelpers.containsKey(TType) == false;
    if (parserDoesNotExist) {
      throw new PreflectorError(
          "No parser for type '$TType' has been registered in preflector");
    } else {
      return _typeHelpers[TType] as TType Function(dynamic)?;
    }
  }
}

class _InbuiltHelpers {
  static double? getNullableDouble(value) {
    if (_isEmpty(value)) {
      return null;
    } else {
      return double.parse(value.toString());
    }
  }

  static double getDouble(value) {
    return getNullableDouble(value) ?? 0;
  }

  static int? getNullableInt(value) {
    if (_isEmpty(value)) {
      return null;
    } else {
      return int.parse(value.toString());
    }
  }

  static int getInt(value) {
    return getNullableInt(value) ?? 0;
  }

  static String? getNullableString(value) {
    if (_isEmpty(value)) {
      return null;
    } else {
      return value.toString();
    }
  }

  static String getString(value) {
    return getNullableString(value) ?? "";
  }

  static bool _isEmpty(value) {
    return value == null || value.toString().isEmpty;
  }

  static bool? getNullableBool(value) {
    if (_isEmpty(value)) {
      return null;
    } else {
      return value.toString().toLowerCase() == "true";
    }
  }

  static bool getBool(value) {
    return getNullableBool(value) ?? false;
  }

  static DateTime? getNullableDateTime(value) {
    if (_isEmpty(value)) {
      return null;
    } else {
      return DateTime.parse(value.toString());
    }
  }

  static DateTime getDateTime(value) {
    return getNullableDateTime(value) ?? new DateTime(1970, 01, 01);
  }
}
