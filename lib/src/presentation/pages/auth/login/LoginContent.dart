import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localdriver/src/presentation/pages/auth/login/bloc/LoginBloc.dart';
import 'package:localdriver/src/presentation/pages/auth/login/bloc/LoginEvent.dart';
import 'package:localdriver/src/presentation/pages/auth/login/bloc/LoginState.dart';
import 'package:localdriver/src/presentation/utils/BlocFormItem.dart';
import 'package:localdriver/src/presentation/widgets/DefaultButton.dart';
import 'package:localdriver/src/presentation/widgets/DefaultTextField.dart';

class LoginContent extends StatelessWidget {
  final LoginState state;

  const LoginContent(this.state, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor:
          Colors.transparent,

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        automaticallyImplyLeading: false,

        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pushReplacementNamed(context, 'client/home/tut');
          },
        ),
      ),

      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/img/bg_city_dark.jpg',
            fit: BoxFit.cover,
          ),
          Container(
            color: Colors.black.withOpacity(0.6),
          ),
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 28, vertical: 20),
                child: Form(
                  key: state.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/img/car_white.png',
                        width: 100,
                        height: 100,
                      ),
                      const SizedBox(height: 24),
                      const Text(
                        "Bienvenido de nuevo",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        "Inicia sesión para continuar",
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 40),
                      DefaultTextField(
                        onChanged: (text) {
                          context.read<LoginBloc>().add(
                              EmailChanged(email: BlocFormItem(value: text)));
                        },
                        validator: (value) => state.email.error,
                        text: 'Email',
                        icon: Icons.email_outlined,
                      ),
                      const SizedBox(height: 16),
                      DefaultTextField(
                        onChanged: (text) {
                          context.read<LoginBloc>().add(PasswordChanged(
                              password: BlocFormItem(value: text)));
                        },
                        validator: (value) => state.password.error,
                        obscureText: true,
                        text: 'Contraseña',
                        icon: Icons.lock_outline,
                      ),
                      const SizedBox(height: 30),
                      DefaultButton(
                        text: 'Iniciar sesión',
                        onPressed: () {
                          if (state.formKey!.currentState!.validate()) {
                            context.read<LoginBloc>().add(FormSubmit());
                          } else {
                            print('El formulario no es válido');
                          }
                        },
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(child: Divider(color: Colors.white24)),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              "O",
                              style: TextStyle(
                                  color: Colors.white54, fontSize: 15),
                            ),
                          ),
                          Expanded(child: Divider(color: Colors.white24)),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "¿No tienes una cuenta?",
                            style: TextStyle(color: Colors.white70),
                          ),
                          const SizedBox(width: 8),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, 'register');
                            },
                            child: const Text(
                              "Regístrate",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
