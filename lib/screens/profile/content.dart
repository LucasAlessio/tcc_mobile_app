import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:tcc/components/alert_unauthorized.dart';
import 'package:tcc/components/error_callout.dart';
import 'package:tcc/logic/cubit/app_data_cubit.dart';
import 'package:tcc/logic/cubit/profile_cubit.dart';
import 'package:tcc/screens/profile/form.dart' as form_profile;

class Content extends StatelessWidget {
  const Content({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    getProfile(context);

    return BlocListener<ProfileCubit, ProfileStates?>(
      listener: (context, state) {
        if (state is ProfileError && state.unauthorized) {
          alertUnauthorized(context: context, message: state.message);
        }
      },
      child: BlocBuilder<ProfileCubit, ProfileStates?>(
        builder: (context, state) {
          if (state is ProfileLoading) {
            return Skeletonizer(
              enabled: true,
              child: form_profile.Form(data: const {}),
            );
          }

          if (state is ProfileError && !state.unauthorized) {
            return ErrorCallout(
              title: "Erro ao obter as informações do perfil",
              message: state.message,
            );
          }

          if (state is ProfileSuccess) {
            return form_profile.Form(
              data: state.data,
              isFetched: true,
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  void getProfile(BuildContext context) {
    AppDataCubit appData = context.read<AppDataCubit>();
    AppDataStates? data = appData.state;

    if (data is! AppDataAuthenticated) return;

    final ProfileCubit bloc = context.read<ProfileCubit>();
    bloc.getProfile(token: data.token);
  }
}
