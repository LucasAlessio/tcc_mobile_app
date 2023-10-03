import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:logger/logger.dart';
import 'package:tcc/components/menu_widget.dart';
import 'package:tcc/components/spacer.dart' as common;
import 'package:tcc/logic/cubit/update_password_cubit.dart';
import 'package:tcc/screens/password/save_button.dart';

class PasswordScreen extends StatefulWidget {
  const PasswordScreen({Key? key}) : super(key: key);

  @override
  State<PasswordScreen> createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<PasswordScreen> {
  final Logger logger = Logger();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Segurança"),
        leading: const MenuWidget(),
      ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider<UpdatePasswordCubit>(
            create: (context) => UpdatePasswordCubit(),
          ),
        ],
        child: const PasswordContent(),
      ),
    );
  }
}

class PasswordContent extends StatelessWidget {
  const PasswordContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form();
  }
}

class Form extends StatelessWidget {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

  Form({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      // margin: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        // border: Border.all(width: 8, color: Colors.red),
        color: Theme.of(context).colorScheme.background,
      ),
      child: FormBuilder(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(top: 8, bottom: 32),
          child: Column(
            children: [
              const Text(
                "Mantenha sua conta segura através do formulário abaixo para atualizar sua senha.",
              ),
              const Padding(
                padding: EdgeInsets.only(top: 8, bottom: 8),
                child: Divider(
                  thickness: 1,
                ),
              ),
              FormBuilderTextField(
                name: 'current_password',
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Senha atual',
                ),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(
                    errorText: 'Informe a senha atual',
                  ),
                ]),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 8, bottom: 8),
                child: Divider(
                  thickness: 1,
                ),
              ),
              FormBuilderTextField(
                name: 'password',
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Nova senha',
                ),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(
                    errorText: 'Informe a nova senha',
                  ),
                ]),
              ),
              const common.Spacer(),
              FormBuilderTextField(
                name: "password_confirmation",
                decoration: const InputDecoration(
                  labelText: 'Confirmar nova senha',
                ),
                obscureText: true,
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(
                    errorText: "Confirme a nova senha",
                  ),
                  (value) =>
                      _formKey.currentState?.fields['password']?.value != value
                          ? 'A confirmação de senha não corresponde à senha'
                          : null,
                ]),
              ),
              const common.Spacer(),
              SizedBox(
                width: double.infinity,
                child: SaveButton(
                  formKey: _formKey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
