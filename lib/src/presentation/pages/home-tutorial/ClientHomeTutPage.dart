import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:localdriver/blocSocketIO/BlocSocketIO.dart';
import 'package:localdriver/blocSocketIO/BlocSocketIOEvent.dart';
import 'package:localdriver/src/data/services/apple_signin_service.dart';
import 'package:localdriver/src/data/services/google_signin_service.dart';
import 'package:localdriver/src/presentation/pages/auth/login/LoginPage.dart';
import 'package:localdriver/src/presentation/pages/auth/login/bloc/LoginBloc.dart';
import 'package:localdriver/src/presentation/pages/auth/login/bloc/LoginEvent.dart';
import 'package:localdriver/src/presentation/pages/client/historyTrip/ClientHistoryTripPage.dart';
import 'package:localdriver/src/presentation/pages/client/home/ClientHomePage.dart';
import 'package:localdriver/src/presentation/pages/client/mapSeeker/ClientMapSeekerPage.dart';
import 'package:localdriver/src/presentation/pages/profile/info/ProfileInfoPage.dart';
import 'package:localdriver/src/presentation/pages/roles/RolesPage.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class ClientHomeTutPage extends StatefulWidget {
  const ClientHomeTutPage({super.key});

  @override
  State<ClientHomeTutPage> createState() => _ClientHomeTutPageState();
}

class _ClientHomeTutPageState extends State<ClientHomeTutPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final Widget initialAppPage = ClientHomePage();

  List<Widget> pageList = <Widget>[
    ClientMapSeekerPage(),
    ClientHistoryTripPage(),
    ProfileInfoPage(),
    RolesPage(),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _goToLogin() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
      (route) => false,
    );
  }

  void _skipTutorial() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => initialAppPage),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            children: [
              _buildFirstTutorialPage(
                title: "Rutrack",
                description:
                    "(para solicitar tu conductor debes iniciar sesión)",
                image: Icons.motorcycle,
              ),
              _buildTutorialPage(
                title: "Explora Conductores",
                description: "Encuentra conductores locales a toda hora.",
                image: Icons.car_repair,
              ),
              _buildLastTutorialPage(
                title: "Paga Seguro",
                description: "Paga con calma en plataformas confiables.",
                image: Icons.list_alt,
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: Container(
        color: Color(0xFF091B2A),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _currentPage > 0
                        ? ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 240, 240, 240),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 10),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            onPressed: () {
                              _pageController.previousPage(
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeInOut);
                            },
                            child: const Row(
                              children: [
                                Icon(Icons.arrow_back, color: Colors.black),
                                SizedBox(width: 8),
                                Text(
                                  "Atrás",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 17,
                                  ),
                                ),
                              ],
                            ),
                          )
                        : const SizedBox.shrink(),
                    _currentPage < 2
                        ? ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 240, 240, 240),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 10),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            onPressed: () {
                              _pageController.nextPage(
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeInOut);
                            },
                            child: const Row(
                              children: [
                                Text(
                                  "Siguiente",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 17,
                                  ),
                                ),
                                SizedBox(width: 8),
                                Icon(Icons.arrow_forward, color: Colors.black),
                              ],
                            ),
                          )
                        : const SizedBox.shrink(),
                  ],
                ),
                const SizedBox(height: 16),
                GestureDetector(
                  onTap: () {},
                  child: const Text(
                    "Términos y Condiciones",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFirstTutorialPage(
      {required String title,
      required String description,
      required IconData image}) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _imageCover(),
            const SizedBox(height: 32),
            Text(
              title,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 38,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              description,
              style: const TextStyle(color: Colors.white, fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                MaterialButton(
                  splashColor: Colors.transparent,
                  minWidth: double.infinity,
                  height: 40,
                  color: Colors.blue,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  onPressed: _goToLogin,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/img/180.png',
                        height: 20,
                      ),
                      const SizedBox(width: 10),
                      const Text(                      
                        " Iniciar sesión",
                        style: TextStyle(color: Colors.white, fontSize: 17),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 5,),
                MaterialButton(
                    splashColor: Colors.transparent,
                    minWidth: double.infinity,
                    height: 40,
                    color: Colors.red,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(FontAwesomeIcons.google, color: Colors.white),
                        Text(
                          '  Iniciar con Google',
                          style: TextStyle(color: Colors.white, fontSize: 17),
                        )
                      ],
                    ),
                    onPressed: () async {
                      final authResponse = await GoogleSignInService.signInWithGoogle();
                      if (authResponse != null) {
                        context.read<LoginBloc>().add(
                          SaveUserSession(authResponse: authResponse),
                        );
                        context.read<LoginBloc>().add(
                          UpdateNotificationToken(id: authResponse.user.id!),
                        );
                        context.read<BlocSocketIO>().add(ConnectSocketIO());
                        context.read<BlocSocketIO>().add(ListenDriverAssignedSocketIO());
                        if (authResponse.user.roles!.length > 1) {
                          Navigator.pushNamedAndRemoveUntil(context, 'roles', (route) => false);
                        } else {
                          Navigator.pushNamedAndRemoveUntil(context, 'client/home', (route) => false);
                        }
                      } else {
                        print('No se pudo iniciar con Google');
                      }
                    },
                ),
                SizedBox(height: 5,),
                SignInWithAppleButton(
                  text: 'Iniciar con Apple',
                  onPressed: () async {
                    final authResponse = await AppleSignInService.signInWithApple();
                    if (authResponse != null) {
                      context.read<LoginBloc>().add(
                        SaveUserSession(authResponse: authResponse),
                      );
                      context.read<LoginBloc>().add(
                        UpdateNotificationToken(id: authResponse.user.id!),
                      );
                      context.read<BlocSocketIO>().add(ConnectSocketIO());
                      context.read<BlocSocketIO>().add(ListenDriverAssignedSocketIO());
                      if (authResponse.user.roles!.length > 1) {
                        Navigator.pushNamedAndRemoveUntil(context, 'roles', (route) => false);
                      } else {
                        Navigator.pushNamedAndRemoveUntil(context, 'client/home', (route) => false);
                      }
                    } else {
                      print('Login Apple falló');
                    }
                  },
                ),
                SizedBox(height: 5,),
                MaterialButton(
                  splashColor: Colors.transparent,
                  minWidth: double.infinity,
                  height: 40,
                  color: const Color.fromARGB(255, 240, 240, 240),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  onPressed: _skipTutorial,
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.arrow_circle_up_rounded),
                      SizedBox(width: 10),
                      Text(
                        "Omitir",
                        style: TextStyle(color: Colors.black, fontSize: 17),
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildTutorialPage(
      {required String title,
      required String description,
      required IconData image}) {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(image, size: 150, color: Colors.red),
          const SizedBox(height: 32),
          Text(
            title,
            style: const TextStyle(
                color: Colors.white, fontSize: 34, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            description,
            style: const TextStyle(color: Colors.white, fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildLastTutorialPage(
      {required String title,
      required String description,
      required IconData image}) {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(image, size: 150, color: Colors.blue),
          const SizedBox(height: 32),
          Text(
            title,
            style: const TextStyle(
                color: Colors.white, fontSize: 34, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            description,
            style: const TextStyle(color: Colors.white, fontSize: 16),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              MaterialButton(
                  splashColor: Colors.transparent,
                  minWidth: double.infinity,
                  height: 40,
                  color: Colors.blue,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  onPressed: _goToLogin,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/img/180.png',
                        height: 20,
                      ),
                      const SizedBox(width: 10),
                      const Text(                      
                        " Iniciar sesión",
                        style: TextStyle(color: Colors.white, fontSize: 17),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 5,),
                MaterialButton(
                    splashColor: Colors.transparent,
                    minWidth: double.infinity,
                    height: 40,
                    color: Colors.red,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(FontAwesomeIcons.google, color: Colors.white),
                        Text(
                          '  Iniciar con Google',
                          style: TextStyle(color: Colors.white, fontSize: 17),
                        )
                      ],
                    ),
                    onPressed: () async {
                      final authResponse = await GoogleSignInService.signInWithGoogle();
                      if (authResponse != null) {
                        context.read<LoginBloc>().add(
                          SaveUserSession(authResponse: authResponse),
                        );
                        context.read<LoginBloc>().add(
                          UpdateNotificationToken(id: authResponse.user.id!),
                        );
                        context.read<BlocSocketIO>().add(ConnectSocketIO());
                        context.read<BlocSocketIO>().add(ListenDriverAssignedSocketIO());
                        if (authResponse.user.roles!.length > 1) {
                          Navigator.pushNamedAndRemoveUntil(context, 'roles', (route) => false);
                        } else {
                          Navigator.pushNamedAndRemoveUntil(context, 'client/home', (route) => false);
                        }
                      } else {
                        print('No se pudo iniciar con Google');
                      }
                    },
                  ),
                SizedBox(height: 5,),
                SignInWithAppleButton(
                  text: 'Iniciar con Apple',
                  onPressed: () async {

                    final authResponse = await AppleSignInService.signInWithApple();
                    print('authresponse $authResponse');
                    if (authResponse != null) {

                      context.read<LoginBloc>().add(
                        SaveUserSession(authResponse: authResponse),
                      );

                      context.read<LoginBloc>().add(
                        UpdateNotificationToken(id: authResponse.user.id!),
                      );

                      context.read<BlocSocketIO>().add(ConnectSocketIO());
                      context.read<BlocSocketIO>().add(ListenDriverAssignedSocketIO());

                      if (authResponse.user.roles!.length > 1) {
                        Navigator.pushNamedAndRemoveUntil(context, 'roles', (route) => false);
                      } else {
                        Navigator.pushNamedAndRemoveUntil(context, 'client/home', (route) => false);
                      }

                    } else {
                      print('Login Apple falló');
                    }
                  },
                ),
                SizedBox(height: 5,),
                MaterialButton(
                  splashColor: Colors.transparent,
                  minWidth: double.infinity,
                  height: 40,
                  color: const Color.fromARGB(255, 240, 240, 240),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  onPressed: _skipTutorial,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.arrow_circle_up_rounded),
                      SizedBox(width: 10),
                      Text(
                        "Omitir",
                        style: TextStyle(color: Colors.black, fontSize: 17),
                      ),
                    ],
                  ),
                ),
            ],
          )
        ],
      ),
    );
  }

  Widget _imageCover() {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.only(top: 20, bottom: 15),
        alignment: Alignment.center,
        child: Column(
          children: [
            Image.asset(
              'assets/img/180.png',
              width: 180,
              height: 180,
            ),
          ],
        ),
      ),
    );
  }
}
