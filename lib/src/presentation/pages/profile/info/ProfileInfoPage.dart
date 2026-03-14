import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localdriver/src/presentation/pages/profile/info/ProfileInfoContent.dart';
import 'package:localdriver/src/presentation/pages/profile/info/bloc/ProfileInfoBloc.dart';
import 'package:localdriver/src/presentation/pages/profile/info/bloc/ProfileInfoState.dart';

class ProfileInfoPage extends StatefulWidget {
  const ProfileInfoPage({super.key});

  @override
  State<ProfileInfoPage> createState() => _ProfileInfoPageState();
}

class _ProfileInfoPageState extends State<ProfileInfoPage> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: BlocListener<ProfileInfoBloc, ProfileInfoState>(
        listener: (context, state) {
          if (state.success == true) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Cuenta eliminada correctamente')),
            );
            Navigator.pushNamedAndRemoveUntil(
              context,
              'client/home/tut',
              (route) => false
            );
          }
        },
        child: BlocBuilder<ProfileInfoBloc, ProfileInfoState>(
          builder: (context, state) {

            if (state.success == true) {
              return SizedBox();
            }
            return ProfileInfoContent(state.user);
          },
        ),
      ),
    );
  }
}