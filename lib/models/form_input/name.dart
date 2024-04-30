
import 'package:formz/formz.dart';

enum NameValidationError{invalid}

class Name extends FormzInput<String, NameValidationError> {
  /// {@macro email}
  const Name.pure() : super.pure('');

  /// {@macro email}
  const Name.dirty([super.value = '']) : super.dirty();

  static final RegExp _nameRegExp = RegExp(
    r'^[\w\-,.][^0-9_!¡?÷?¿/\\+=@#$%ˆ&*(){}|~<>;:[\]]{1,}$',
  );

  @override
  NameValidationError? validator(String? value) {
    return _nameRegExp.hasMatch(value ?? '')
        ? null
        : NameValidationError.invalid;
  }
}