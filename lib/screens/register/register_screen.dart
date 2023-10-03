import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:logger/logger.dart';
import 'package:tcc/components/spacer.dart' as common;
import 'package:tcc/enums/family_income.dart';
import 'package:tcc/enums/gender.dart';
import 'package:tcc/enums/marital_status.dart';
import 'package:tcc/enums/schooling.dart';
import 'package:tcc/exceptions/validation_exception.dart';
import 'package:tcc/services/auth_service.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  final Logger logger = Logger();

  bool _isLoading = false;

  AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: Container(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
        // margin: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          // border: Border.all(width: 8, color: Colors.red),
          color: Theme.of(context).colorScheme.background,
        ),
        child: FormBuilder(
          key: _formKey,
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(top: 32, bottom: 32),
              child: Column(
                children: [
                  Icon(
                    Icons.psychology_outlined,
                    size: 64,
                    color: Theme.of(context).primaryColorLight,
                  ),
                  const Text(
                    "Crie sua conta",
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
                  const Text("Preencha o formulário a seguir"),
                  const common.Spacer(),
                  FormBuilderTextField(
                    name: 'name',
                    decoration: const InputDecoration(
                      labelText: 'Nome',
                    ),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(
                        errorText: "Informe o nome",
                      ),
                    ]),
                  ),
                  const common.Spacer(),
                  FormBuilderTextField(
                    name: 'email',
                    decoration: const InputDecoration(
                      labelText: 'E-mail',
                    ),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(
                        errorText: "Informe o e-mail",
                      ),
                    ]),
                  ),
                  const common.Spacer(),
                  FormBuilderDropdown(
                    name: 'gender',
                    items: Gender.getDefinitions().entries.map((e) {
                      return DropdownMenuItem(
                        value: e.key,
                        child: Text(e.value),
                      );
                    }).toList(),
                    decoration: const InputDecoration(
                      labelText: 'Sexo',
                    ),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(
                        errorText: "Informe o sexo",
                      ),
                    ]),
                  ),
                  const common.Spacer(),
                  FormBuilderTextField(
                    name: 'occupation',
                    decoration: const InputDecoration(
                      labelText: 'Ocupação',
                    ),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(
                        errorText: "Informe a ocupação",
                      ),
                    ]),
                  ),
                  const common.Spacer(),
                  FormBuilderDropdown(
                    name: 'marital_status',
                    items: MaritalStatus.getDefinitions().entries.map((e) {
                      return DropdownMenuItem(
                        value: e.key,
                        child: Text(e.value),
                      );
                    }).toList(),
                    decoration: const InputDecoration(
                      labelText: 'Estado civil',
                    ),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(
                        errorText: "Informe o estado civil",
                      ),
                    ]),
                  ),
                  const common.Spacer(),
                  FormBuilderDropdown(
                    name: 'family_income',
                    items: FamilyIncome.getDefinitions().entries.map((e) {
                      return DropdownMenuItem(
                        value: e.key,
                        child: Text(e.value),
                      );
                    }).toList(),
                    decoration: const InputDecoration(
                      labelText: 'Renda familiar',
                    ),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(
                        errorText: "Informe a renda familiar",
                      ),
                    ]),
                  ),
                  const common.Spacer(),
                  FormBuilderDropdown(
                    name: 'schooling',
                    items: Schooling.getDefinitions().entries.map((e) {
                      return DropdownMenuItem(
                        value: e.key,
                        child: Text(e.value),
                      );
                    }).toList(),
                    decoration: const InputDecoration(
                      labelText: 'Nível de escolaridade',
                    ),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(
                        errorText: "Informe o nível de escolaridade",
                      ),
                    ]),
                  ),
                  const common.Spacer(),
                  FormBuilderSwitch(
                    title: const Text(
                      'Tenho ou possuo familiares com doenças crônicas',
                      style: TextStyle(fontSize: 16, height: 0),
                    ),
                    name: 'family_with_chronic_illnesses',
                    initialValue: false,
                    contentPadding: EdgeInsets.zero,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.zero,
                      filled: false,
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      isDense: true,
                    ),
                    inactiveThumbColor: const Color(0xFFA3AED0),
                  ),
                  const common.Spacer(height: 8),
                  FormBuilderSwitch(
                    name: 'family_with_psychiatric_disorders',
                    title: const Text(
                      'Tenho ou possuo familiares com transtornos psiquiátricos',
                      style: TextStyle(fontSize: 16, height: 0),
                    ),
                    initialValue: false,
                    decoration: const InputDecoration(
                      filled: false,
                      contentPadding: EdgeInsets.zero,
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      isDense: true,
                    ),
                    inactiveThumbColor: const Color(0xFFA3AED0),
                  ),
                  const common.Spacer(),
                  FormBuilderTextField(
                    name: 'psychologist_registration_number',
                    decoration: const InputDecoration(
                      labelText: 'Nº de registro do psicólogo',
                    ),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(
                        errorText: 'Informe o número de registro',
                      ),
                    ]),
                  ),
                  const common.Spacer(),
                  FormBuilderTextField(
                    name: 'password',
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Senha',
                    ),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(
                        errorText: 'Informe a senha',
                      ),
                    ]),
                  ),
                  const common.Spacer(),
                  FormBuilderTextField(
                    name: "password_confirmation",
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: const InputDecoration(
                      labelText: 'Confirmar senha',
                    ),
                    obscureText: true,
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(
                        errorText: "Confirme a senha",
                      ),
                      (value) =>
                          _formKey.currentState?.fields['password']?.value !=
                                  value
                              ? 'A confirmação de senha não corresponde à senha'
                              : null,
                    ]),
                  ),
                  const common.Spacer(),
                  SizedBox(
                    width: double.infinity,
                    child: _isLoading
                        ? const Row(
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
                              Text('aguarde...'),
                            ],
                          )
                        : ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState?.saveAndValidate() ??
                                  false) {
                                register(context);
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  Theme.of(context).primaryColorLight,
                            ),
                            child: const Text(
                              "Registrar",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                  ),
                  const common.Spacer(),
                  const common.Spacer(),
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: "Já tem cadastro? ",
                          style: TextStyle(
                            color:
                                Theme.of(context).textTheme.bodyMedium?.color,
                          ),
                        ),
                        TextSpan(
                          text: 'Autentique-se',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColorLight,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.pop(context);
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
    );
  }

  void register(BuildContext context) async {
    setState(() {
      _isLoading = true;
    });

    try {
      await authService.register(
        data: _formKey.currentState?.value ?? {},
      );

      if (!context.mounted) return;
      Navigator.pushReplacementNamed(context, '/');
    } on ValidationException catch (error) {
      for (MapEntry e in error.errors.entries) {
        _formKey.currentState?.fields[e.key]?.invalidate(e.value);
      }
    } on HttpException catch (error) {
      error.message;
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  // void registerTask() {
  //   Workmanager().registerOneOffTask(
  //     "test",
  //     "test-test",
  //     initialDelay: const Duration(seconds: 4),
  //     inputData: {
  //       'name': 'Lucas',
  //     },
  //     existingWorkPolicy: ExistingWorkPolicy.append,
  //   );
  // }
}
