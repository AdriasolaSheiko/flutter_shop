part of 'register_bloc.dart';

abstract class RegisterEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class TryRegisterEvent extends RegisterEvent {}

class UpdateFormEvent extends RegisterEvent {
  UpdateFormEvent({
    this.email,
    this.password,
    this.fullName,
    this.showPassword,
    this.isValidForm,
  });

  final String? email;
  final String? password;
  final String? fullName;
  final bool? showPassword;
  final bool? isValidForm;

  @override
  List<Object?> get props => [
        email,
        password,
        fullName,
        showPassword,
        isValidForm,
      ];
}
