import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shop/models/register_model.dart';
import 'package:flutter_shop/repositories/auth_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({
    required SharedPreferences prefs,
  }) : super(InitState(
          model: Model(
            email: prefs.getString('register_data') == null ||
                    prefs.getString('register_data') == ''
                ? ''
                : registerModelFromJson(prefs.getString('register_data')!)
                    .email,
            password: '',
            isValidForm: false,
            showPassword: false,
            isAdmin: false,
          ),
        )) {
    on<TryLoginEvent>(_onTryLoginEvent);
    on<UpdateFormEvent>(_onUpdateFormEvent);
  }

  void _onTryLoginEvent(TryLoginEvent event, emit) async {
    emit(LoadingState(model: state.model));
    try {
      final loginResponse = await AuthRepository()
          .login(email: state.model.email, password: state.model.password);

      if (loginResponse != null) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString(
          'register_data',
          registerModelToJson(
            loginResponse,
          ),
        );

        emit(
          SuccesLoginState(
            model: state.model.copyWith(
              isAdmin: loginResponse.isAdmin,
            ),
          ),
        );
      } else {
        emit(
          FailLoginState(
            model: state.model,
          ),
        );
      }
    } catch (_) {
      emit(
        FailLoginState(
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
    return state.model.email.isNotEmpty && state.model.password.isNotEmpty;
  }
}
