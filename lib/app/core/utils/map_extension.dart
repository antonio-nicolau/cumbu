extension HasKeyAndIsValidType on Map {
  bool hasKeyAndIsMapDynamic(String key) {
    return containsKey(key) && this[key] != null && this[key] is Map<String, dynamic>;
  }

  bool hasKeyAndIsList(String key) {
    return containsKey(key) && this[key] != null && this[key] is List;
  }

  bool hasKeyAndIsString(String key) {
    return containsKey(key) && this[key] != null && this[key] is String;
  }

  bool hasKeyAndIsInt(String key) {
    return containsKey(key) && this[key] != null && this[key] is int;
  }

  bool hasKeyAndIsDouble(String key) {
    return containsKey(key) && this[key] != null && this[key] is double;
  }

  bool hasKeyAndIsBool(String key) {
    return containsKey(key) && this[key] != null && this[key] is bool;
  }
}
