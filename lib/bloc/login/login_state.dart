part of 'login_cubit.dart';

class LoginState extends Equatable {
  const LoginState(
      {this.email = const Email.pure(),
        this.password = const Password.pure(),
        this.status = FormzStatus.pure,
        this.errorMessage,
        this.isValid = false});

  final Email email;
  final Password password;
  final FormzStatus status;
  final String? errorMessage;
  final bool isValid;

  @override
  List<Object> get props =>
      [email, password, status, isValid, errorMessage ?? ''];

  LoginState copyWith(
      {Email? email,
        Password? password,
        FormzStatus? status,
        String? errorMessage,
        bool? isValid}) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
      isValid: isValid ?? this.isValid,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
