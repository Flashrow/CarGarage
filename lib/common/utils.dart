extension FullSexName on String? {
  String getSexName() {
    if (this != null) {
      if (this!.toLowerCase() == "m") {
        return "male";
      } else if (this!.toLowerCase() == "f") {
        return "female";
      } else {
        return "other";
      }
    }
    return "unavailable";
  }
}
