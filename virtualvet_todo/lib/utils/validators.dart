class Validators {
  static String Function(String) validateTitle([String error]) {
    return (String value) {
      if (value.isEmpty) {
        return error ?? 'Title is required.';
      }
      if (value.isEmpty) {
        return error ?? 'Title should be greater than 4 chars';
      }
      return null;
    };
  }
}
