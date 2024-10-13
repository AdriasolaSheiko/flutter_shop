// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shop/pages/register/bloc/register_bloc.dart';
import 'package:flutter_shop/widgets/dialog_simple.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registrarme'),
      ),
      body: BlocProvider(create: (_) => RegisterBloc(), child: const _Body()),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<String?> emailErrorNotifier = ValueNotifier(null);
    final ValueNotifier<String?> passwordErrorNotifier = ValueNotifier(null);
    final ValueNotifier<String?> fullNameErrorNotifier = ValueNotifier(null);
    final TextEditingController passwordController = TextEditingController();
    final registerbloc = BlocProvider.of<RegisterBloc>(context);
    return BlocListener<RegisterBloc, RegisterState>(
      listener: (context, state) async {
        if (state is SuccesRegisterState) {
          await const DialogSimple(
                  message:
                      'Registro exitoso, ya puedes iniciar sesión con tu usuario y contraseña')
              .show(context);
          Navigator.of(context).pop();
        }
        if (state is FailRegisterState) {
          await const DialogSimple(
                  message:
                      'Ocurrio un error, asegurate de que tu correo no haya sido regsitrado anterior mente o intentalo de nuevo más tarde')
              .show(context);
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ValueListenableBuilder<String?>(
                        valueListenable: emailErrorNotifier,
                        builder: (context, textValue, _) {
                          return TextField(
                            decoration: InputDecoration(
                              labelText: 'Correo electrónico',
                              errorText: textValue,
                            ),
                            onChanged: (value) {
                              registerbloc.add(UpdateFormEvent(email: value));
                              if (value.isEmpty) {
                                emailErrorNotifier.value = 'Campo necesario';
                              } else {
                                emailErrorNotifier.value = null;
                              }
                            },
                          );
                        }),
                    ValueListenableBuilder<String?>(
                        valueListenable: fullNameErrorNotifier,
                        builder: (context, textValue, _) {
                          return TextField(
                            decoration: InputDecoration(
                              labelText: 'Nombre completo',
                              errorText: textValue,
                            ),
                            onChanged: (value) {
                              registerbloc
                                  .add(UpdateFormEvent(fullName: value));
                              if (value.isEmpty) {
                                fullNameErrorNotifier.value = 'Campo necesario';
                              } else {
                                fullNameErrorNotifier.value = null;
                              }
                            },
                          );
                        }),
                    BlocBuilder<RegisterBloc, RegisterState>(
                        builder: (context, state) {
                      return ValueListenableBuilder<String?>(
                          valueListenable: passwordErrorNotifier,
                          builder: (context, textValue, _) {
                            return TextField(
                              controller: passwordController,
                              decoration: InputDecoration(
                                  labelText: 'Contraseña',
                                  errorText: textValue,
                                  suffixIcon: InkWell(
                                    onTap: () {
                                      registerbloc.add(
                                        UpdateFormEvent(
                                          showPassword:
                                              !state.model.showPassword,
                                        ),
                                      );
                                    },
                                    child: Icon(state.model.showPassword
                                        ? Icons.visibility_off
                                        : Icons.visibility),
                                  )),
                              obscureText: !state.model.showPassword,
                              onChanged: (value) {
                                registerbloc
                                    .add(UpdateFormEvent(password: value));
                                if (value.isEmpty) {
                                  passwordErrorNotifier.value =
                                      'Campo necesario';
                                } else {
                                  passwordErrorNotifier.value = null;
                                }
                              },
                            );
                          });
                    }),
                  ],
                ),
              ),
            ),
            BlocBuilder<RegisterBloc, RegisterState>(builder: (context, state) {
              return state is LoadingState
                  ? const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: SizedBox(
                        height: 30,
                        width: 30,
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    )
                  : ElevatedButton(
                      onPressed: registerbloc.isValidForm()
                          ? () {
                              registerbloc.add(TryRegisterEvent());
                            }
                          : null,
                      child: const Text(
                        'Completar Registro',
                      ),
                    );
            })
          ],
        ),
      ),
    );
  }
}
