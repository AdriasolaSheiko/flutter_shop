import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shop/repositories/auth_repository.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc()
      : super(const InitState(
          model: Model(
            email: '',
            password: '',
            fullName: '',
            isValidForm: false,
            showPassword: false,
          ),
        )) {
    on<TryRegisterEvent>(_onTryRegisterEvent);
    on<UpdateFormEvent>(_onUpdateFormEvent);
  }

  void _onTryRegisterEvent(TryRegisterEvent event, emit) async {
    emit(LoadingState(model: state.model));
    try {
      final success = await AuthRepository().register(
        email: state.model.email,
        password: state.model.password,
        fullName: state.model.fullName,
      );

      if (success) {
        emit(
          SuccesRegisterState(
            model: state.model,
          ),
        );
      } else {
        emit(
          FailRegisterState(
            model: state.model,
          ),
        );
      }
    } catch (_) {
      emit(
        FailRegisterState(
          model: state.model,
        ),
      );
    }
  }

  void _onUpdateFormEvent(UpdateFormEvent event, emit) {
    emit(
      UpdateFormState(
        model: state.model.copyWith(
          email: event.email,
          password: event.password,
          fullName: event.fullName,
          showPassword: event.showPassword,
        ),
      ),
    );

    if (isValidForm()) {
      emit(
        ValidFormState(
          model: state.model.copyWith(
            isValidForm: true,
          ),
        ),
      );
    } else {
      emit(
        InvalidFormState(
          model: state.model.copyWith(isValidForm: false),
        ),
      );
    }
  }

  bool isValidForm() {
    return state.model.email.isNotEmpty &&
        state.model.password.isNotEmpty &&
        state.model.fullName.isNotEmpty;
  }
}
