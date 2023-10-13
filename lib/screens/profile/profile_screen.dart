import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tcc/components/menu_widget.dart';
import 'package:tcc/logic/cubit/profile_cubit.dart';
import 'package:tcc/logic/cubit/update_profile_cubit.dart';
import 'package:tcc/screens/profile/content.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Perfil"),
        leading: const MenuWidget(),
      ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider<ProfileCubit>(
            create: (context) => ProfileCubit(),
          ),
          BlocProvider<UpdateProfileCubit>(
            create: (context) => UpdateProfileCubit(),
          ),
        ],
        child: const Content(),
      ),
      primary: true,
    );
  }
}
