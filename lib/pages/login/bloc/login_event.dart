part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class TryLoginEvent extends LoginEvent {}

class UpdateFormEvent extends LoginEvent {
  UpdateFormEvent({
    this.email,
    this.password,
    this.showPassword,
  });

  final String? email;
  final String? password;
  final bool? showPassword;

  @override
  List<Object?> get props => [
        email,
        password,
        showPassword,
      ];
}
