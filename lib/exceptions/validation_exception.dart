import 'dart:convert';

class ValidationException implements Exception {
  Map<String, dynamic> _errors = {};

  ValidationException(this._errors);

  factory ValidationException.fromErrorResponse(String raw) {
    Map<String, dynamic> response = json.decode(raw);
    Map<String, dynamic> errors = {};

    for (var e
        in ((response["errors"] ?? {}) as Map<String, dynamic>).entries) {
      errors[e.key] = e.value[0];
    }

    return ValidationException(errors);
  }

  Map<String, dynamic> get errors => _errors;
}
