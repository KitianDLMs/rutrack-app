import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localdriver/src/presentation/pages/auth/register/bloc/RegisterBloc.dart';
import 'package:localdriver/src/presentation/pages/auth/register/bloc/RegisterEvent.dart';
import 'package:localdriver/src/presentation/pages/auth/register/bloc/RegisterState.dart';
import 'package:localdriver/src/presentation/utils/BlocFormItem.dart';
import 'package:localdriver/src/presentation/widgets/DefaultButton.dart';
import 'package:localdriver/src/presentation/widgets/DefaultTextField.dart';

class RegisterContent extends StatelessWidget {
  final RegisterState state;

  const RegisterContent(this.state, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Imagen de fondo (misma del login)
          Image.asset(
            'assets/img/bg_city_dark.jpg',
            fit: BoxFit.cover,
          ),
          Container(
            color: Colors.black.withOpacity(0.6), // Capa oscura encima
          ),

          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 20),
                child: Form(
                  key: state.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Logo superior
                      Image.asset(
                        'assets/img/car_white.png',
                        width: 100,
                        height: 100,
                      ),
                      const SizedBox(height: 24),

                      // Título principal
                      const Text(
                        "Crear cuenta",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        "Completa los campos para registrarte",
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 40),

                      // Campos del formulario (igual que login)
                      DefaultTextField(
                        text: 'Nombre',
                        icon: Icons.person_outline,
                        onChanged: (text) {
                          context
                              .read<RegisterBloc>()
                              .add(NameChanged(name: BlocFormItem(value: text)));
                        },
                        validator: (_) => state.name.error,
                      ),
                      const SizedBox(height: 16),

                      DefaultTextField(
                        text: 'Apellido',
                        icon: Icons.person_2_outlined,
                        onChanged: (text) {
                          context
                              .read<RegisterBloc>()
                              .add(LastnameChanged(lastname: BlocFormItem(value: text)));
                        },
                        validator: (_) => state.lastname.error,
                      ),
                      const SizedBox(height: 16),

                      DefaultTextField(
                        text: 'Email',
                        icon: Icons.email_outlined,
                        onChanged: (text) {
                          context
                              .read<RegisterBloc>()
                              .add(EmailChanged(email: BlocFormItem(value: text)));
                        },
                        validator: (_) => state.email.error,
                      ),
                      const SizedBox(height: 16),

                      DefaultTextField(
                        text: 'Teléfono',
                        icon: Icons.phone_outlined,
                        onChanged: (text) {
                          context
                              .read<RegisterBloc>()
                              .add(PhoneChanged(phone: BlocFormItem(value: text)));
                        },
                        validator: (_) => state.phone.error,
                      ),
                      const SizedBox(height: 16),

                      DefaultTextField(
                        text: 'Contraseña',
                        icon: Icons.lock_outline,
                        obscureText: true,
                        onChanged: (text) {
                          context
                              .read<RegisterBloc>()
                              .add(PasswordChanged(password: BlocFormItem(value: text)));
                        },
                        validator: (_) => state.password.error,
                      ),
                      const SizedBox(height: 16),

                      DefaultTextField(
                        text: 'Confirmar contraseña',
                        icon: Icons.lock_outline,
                        obscureText: true,
                        onChanged: (text) {
                          context.read<RegisterBloc>().add(
                              ConfirmPasswordChanged(confirmPassword: BlocFormItem(value: text)));
                        },
                        validator: (_) => state.confirmPassword.error,
                      ),

                      const SizedBox(height: 30),

                      // Botón principal
                      DefaultButton(
                        text: 'Crear cuenta',
                        onPressed: () {
                          if (state.formKey!.currentState!.validate()) {
                            context.read<RegisterBloc>().add(FormSubmit());
                            context.read<RegisterBloc>().add(FormReset());
                          }
                        },
                      ),

                      const SizedBox(height: 20),

                      // Separador visual
                      Row(
                        children: [
                          Expanded(child: Divider(color: Colors.white24)),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              "O",
                              style: TextStyle(color: Colors.white54, fontSize: 15),
                            ),
                          ),
                          Expanded(child: Divider(color: Colors.white24)),
                        ],
                      ),

                      const SizedBox(height: 20),

                      // Volver al login
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "¿Ya tienes una cuenta?",
                            style: TextStyle(color: Colors.white70),
                          ),
                          const SizedBox(width: 8),
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: const Text(
                              "Inicia sesión",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 40),
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
