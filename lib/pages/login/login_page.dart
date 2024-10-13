import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shop/pages/login/bloc/login_bloc.dart';
import 'package:flutter_shop/models/register_model.dart';
import 'package:flutter_shop/pages/admin/admin_page.dart';
import 'package:flutter_shop/pages/home/home_page.dart';
import 'package:flutter_shop/pages/register/register_page.dart';
import 'package:flutter_shop/widgets/dialog_simple.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({
    super.key,
    required this.prefs,
  });

  final SharedPreferences prefs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff224b79),
      body: BlocProvider(
        create: (_) => LoginBloc(prefs: prefs),
        child: _Body(
          prefs: prefs,
        ),
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({
    Key? key,
    required this.prefs,
  }) : super(
          key: key,
        );

  final SharedPreferences prefs;

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<String?> emailErrorNotifier = ValueNotifier(null);
    final ValueNotifier<String?> passwordErrorNotifier = ValueNotifier(null);
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final loginBloc = BlocProvider.of<LoginBloc>(context);

    if (prefs.getString('register_data') != null &&
        prefs.getString('register_data') != '') {
      emailController.text =
          registerModelFromJson(prefs.getString('register_data') ?? '').email;
    }
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) async {
        if (state is SuccesLoginState) {
          if (state.model.isAdmin) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (_) => const AdminPage(),
              ),
            );
          } else {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (_) => const HomePage(),
              ),
            );
          }
        }
        if (state is FailLoginState) {
          await const DialogSimple(
            message:
                'Tus datos son incorrectos o el administrador aín no te ha dado acceso.',
          ).show(context);
        }
      },
      child: Column(
        children: [
          const Spacer(),
          const Text(
            'FLUTTER SHOP',
            style: TextStyle(
              color: Colors.white,
              fontSize: 40,
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    ValueListenableBuilder<String?>(
                        valueListenable: emailErrorNotifier,
                        builder: (context, textValue, _) {
                          return TextField(
                            controller: emailController,
                            decoration: InputDecoration(
                              labelText: 'Correo electrónico',
                              errorText: textValue,
                            ),
                            onChanged: (value) {
                              loginBloc.add(UpdateFormEvent(email: value));
                              if (value.isEmpty) {
                                emailErrorNotifier.value = 'Campo necesario';
                              } else {
                                emailErrorNotifier.value = null;
                              }
                            },
                          );
                        }),
                    BlocBuilder<LoginBloc, LoginState>(
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
                                      loginBloc.add(
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
                                loginBloc.add(UpdateFormEvent(password: value));
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
                    const SizedBox(
                      height: 8,
                    ),
                    BlocBuilder<LoginBloc, LoginState>(
                        builder: (context, state) {
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
                          : Column(
                              children: [
                                const SizedBox(
                                  height: 16.0,
                                ),
                                ElevatedButton(
                                  onPressed: loginBloc.isValidForm()
                                      ? () {
                                          loginBloc.add(
                                            TryLoginEvent(),
                                          );
                                        }
                                      : null,
                                  child: const Text('Iniciar sesión'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (_) => const RegisterPage(),
                                      ),
                                    );
                                  },
                                  child: const Text(
                                    'Registrarme',
                                  ),
                                ),
                              ],
                            );
                    })
                  ],
                ),
              ),
            ),
          ),
          const Spacer(
            flex: 2,
          )
        ],
      ),
    );
  }
}
