part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState({
    required this.model,
  });
  final Model model;

  @override
  List<Object?> get props => [
        model,
      ];
}

class InitState extends LoginState {
  const InitState({
    required super.model,
  });
}

class LoadingState extends LoginState {
  const LoadingState({
    required super.model,
  });
}

class SuccesLoginState extends LoginState {
  const SuccesLoginState({
    required super.model,
  });
}

class FailLoginState extends LoginState {
  const FailLoginState({
    required super.model,
  });
}

class UpdateFormState extends LoginState {
  const UpdateFormState({
    required super.model,
  });
}

class ValidFormState extends LoginState {
  const ValidFormState({
    required super.model,
  });
}

class InvalidFormState extends LoginState {
  const InvalidFormState({
    required super.model,
  });
}

class Model extends Equatable {
  const Model({
    required this.email,
    required this.password,
    required this.isValidForm,
    required this.showPassword,
    required this.isAdmin,
  });

  final String email;
  final String password;
  final bool isValidForm;
  final bool showPassword;
  final bool isAdmin;

  Model copyWith({
    String? email,
    String? password,
    bool? isValidForm,
    bool? showPassword,
    bool? isAdmin,
  }) =>
      Model(
        email: email ?? this.email,
        password: password ?? this.password,
        isValidForm: isValidForm ?? this.isValidForm,
        showPassword: showPassword ?? this.showPassword,
        isAdmin: isAdmin ?? this.isAdmin,
      );

  @override
  List<Object?> get props => [
        email,
        password,
        isValidForm,
        showPassword,
        isAdmin,
      ];
}
