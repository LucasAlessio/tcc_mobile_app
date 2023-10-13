import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:tcc/components/spacer.dart' as common;
import 'package:tcc/enums/family_income.dart';
import 'package:tcc/enums/gender.dart';
import 'package:tcc/enums/marital_status.dart';
import 'package:tcc/enums/schooling.dart';
import 'package:tcc/screens/profile/save_button.dart';

class Form extends StatelessWidget {
  final Map<String, dynamic> data;
  final bool isFetched;
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

  Form({
    Key? key,
    required this.data,
    this.isFetched = false,
  }) : super(key: key);

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
        initialValue: data,
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(top: 8, bottom: 32),
            child: Column(
              children: [
                const Text(
                  "Mantenha os dados do seu perfil atualizados através do formulário abaixo.",
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 8, bottom: 8),
                  child: Divider(
                    thickness: 1,
                  ),
                ),
                const common.Spacer(
                  height: 8,
                ),
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
                Builder(
                  builder: (context) {
                    if (!isFetched) {
                      return const SizedBox.shrink();
                    }

                    return SizedBox(
                      width: double.infinity,
                      child: SaveButton(
                        formKey: _formKey,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
