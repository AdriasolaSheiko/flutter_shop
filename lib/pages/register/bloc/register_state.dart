part of 'register_bloc.dart';

abstract class RegisterState extends Equatable {
  const RegisterState({
    required this.model,
  });
  final Model model;

  @override
  List<Object?> get props => [
        model,
      ];
}

class InitState extends RegisterState {
  const InitState({
    required Model model,
  }) : super(
          model: model,
        );
}

class LoadingState extends RegisterState {
  const LoadingState({
    required Model model,
  }) : super(
          model: model,
        );
}

class SuccesRegisterState extends RegisterState {
  const SuccesRegisterState({
    required Model model,
  }) : super(
          model: model,
        );
}

class FailRegisterState extends RegisterState {
  const FailRegisterState({
    required Model model,
  }) : super(
          model: model,
        );
}

class UpdateFormState extends RegisterState {
  const UpdateFormState({
    required Model model,
  }) : super(
          model: model,
        );
}

class ValidFormState extends RegisterState {
  const ValidFormState({
    required Model model,
  }) : super(
          model: model,
        );
}

class InvalidFormState extends RegisterState {
  const InvalidFormState({
    required Model model,
  }) : super(
          model: model,
        );
}

class Model extends Equatable {
  const Model({
    required this.email,
    required this.password,
    required this.fullName,
    required this.isValidForm,
    required this.showPassword,
  });

  final String email;
  final String password;
  final String fullName;
  final bool isValidForm;
  final bool showPassword;

  Model copyWith({
    String? email,
    String? password,
    String? fullName,
    bool? isValidForm,
    bool? showPassword,
  }) =>
      Model(
        email: email ?? this.email,
        password: password ?? this.password,
        fullName: fullName ?? this.fullName,
        isValidForm: isValidForm ?? this.isValidForm,
        showPassword: showPassword ?? this.showPassword,
      );

  @override
  List<Object?> get props => [
        email,
        password,
        fullName,
        isValidForm,
        showPassword,
        isValidForm,
        showPassword,
      ];
}
