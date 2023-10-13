import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:tcc/components/alert.dart';
import 'package:tcc/components/spacer.dart' as common;
import 'package:tcc/logic/cubit/app_data_cubit.dart';
import 'package:tcc/logic/cubit/login_cubit.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  final LoginCubit _bloc = LoginCubit();
  bool _passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: BlocListener<LoginCubit, LoginStates?>(
        bloc: _bloc,
        listener: (context, state) {
          if (state is LoginSuccess) {
            AppDataCubit appData = context.read<AppDataCubit>();
            appData.loadData();

            Navigator.pushReplacementNamed(context, '/');
          }

          if (state is LoginError) {
            alert(
              context: context,
              title: "Efetuar login",
              message: state.message,
              buttonText: "Ok",
            );
          }

          if (state is LoginValidationError) {
            for (MapEntry e in state.errors.entries) {
              _formKey.currentState?.fields[e.key]?.invalidate(e.value);
            }
          }
        },
        child: Container(
          padding: const EdgeInsets.all(16),
          // margin: const EdgeInsets.all(32),
          decoration: BoxDecoration(
            // border: Border.all(width: 8, color: Colors.red),
            color: Theme.of(context).colorScheme.background,
          ),
          child: FormBuilder(
            key: _formKey,
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Icon(
                      Icons.psychology_outlined,
                      size: 64,
                      color: Theme.of(context).primaryColorLight,
                    ),
                    const Text(
                      "APP TCC SEM NOME",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 8, bottom: 8),
                      child: Divider(
                        thickness: 1,
                      ),
                    ),
                    const Text("Acesse sua conta"),
                    const common.Spacer(),
                    FormBuilderTextField(
                      name: 'email',
                      decoration: const InputDecoration(
                        labelText: 'E-mail',
                        prefixIcon: Icon(
                          Icons.email_outlined,
                        ),
                      ),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(
                          errorText: "Informe o e-mail",
                        ),
                      ]),
                    ),
                    const common.Spacer(),
                    FormBuilderTextField(
                      name: 'password',
                      obscureText: !_passwordVisible,
                      enableSuggestions: false,
                      autocorrect: false,
                      decoration: InputDecoration(
                        labelText: 'Senha',
                        prefixIcon: const Icon(
                          Icons.password,
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _passwordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () => setState(() {
                            _passwordVisible = !_passwordVisible;
                          }),
                        ),
                      ),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(
                          errorText: "Informe a senha",
                        ),
                      ]),
                    ),
                    const common.Spacer(),
                    SizedBox(
                      width: double.infinity,
                      child: BlocBuilder<LoginCubit, LoginStates?>(
                        bloc: _bloc,
                        builder: (context, state) {
                          if (state is LoginLoading) {
                            return const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(top: 14, bottom: 14),
                                  child: SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 16,
                                ),
                                Text('efetuando login...'),
                              ],
                            );
                          }

                          return ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState?.saveAndValidate() ??
                                  false) {
                                login();
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  Theme.of(context).primaryColorLight,
                            ),
                            child: const Text(
                              "Entrar",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const common.Spacer(),
                    const common.Spacer(),
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: "Ainda não tem uma conta? ",
                            style: TextStyle(
                              color:
                                  Theme.of(context).textTheme.bodyMedium?.color,
                            ),
                          ),
                          TextSpan(
                            text: 'Registre-se',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).primaryColorLight,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.pushNamed(context, '/register');
                              },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void login() {
    _bloc.login(
      data: _formKey.currentState?.value ?? {},
    );
  }
}
