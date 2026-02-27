import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localdriver/blocSocketIO/BlocSocketIO.dart';
import 'package:localdriver/blocSocketIO/BlocSocketIOEvent.dart';
import 'package:localdriver/main.dart';
import 'package:localdriver/src/presentation/pages/auth/login/LoginContent.dart';
import 'package:localdriver/src/presentation/pages/auth/login/LoginPage.dart';
import 'package:localdriver/src/presentation/pages/client/historyTrip/ClientHistoryTripPage.dart';
import 'package:localdriver/src/presentation/pages/client/home/bloc/ClientHomeBloc.dart';
import 'package:localdriver/src/presentation/pages/client/home/bloc/ClientHomeEvent.dart';
import 'package:localdriver/src/presentation/pages/client/home/bloc/ClientHomeState.dart';
import 'package:localdriver/src/presentation/pages/client/mapSeeker/ClientMapSeekerPage.dart';
import 'package:localdriver/src/presentation/pages/home-tutorial/ClientHomeTutPage.dart';
import 'package:localdriver/src/presentation/pages/profile/info/ProfileInfoPage.dart';
import 'package:localdriver/src/presentation/pages/roles/RolesPage.dart';

class ClientHomePage extends StatefulWidget {
  const ClientHomePage({super.key});

  @override
  State<ClientHomePage> createState() => _ClientHomePageState();
}

class _ClientHomePageState extends State<ClientHomePage> {
  List<Widget> pageList = <Widget>[
    ClientMapSeekerPage(),
    ClientHistoryTripPage(),
    ProfileInfoPage(),
    RolesPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar:
          true,
      appBar: AppBar(
        backgroundColor: Colors.black.withOpacity(0.1),
        elevation: 0,
        scrolledUnderElevation: 0,
        // backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        shadowColor: Colors.transparent,
        title: Text(
          'LOCAL DRIVER',
          style: TextStyle(
              color:
                  Colors.white),
        ),
        iconTheme:
            IconThemeData(color: Colors.white),
      ),
      body: BlocBuilder<ClientHomeBloc, ClientHomeState>(
        builder: (context, state) {
          return pageList[state.pageIndex];
        },
      ),
      drawer: BlocBuilder<ClientHomeBloc, ClientHomeState>(
        builder: (context, state) {
          return Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                DrawerHeader(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          colors: [
                            Color.fromARGB(255, 12, 38, 145),
                            Color.fromARGB(255, 34, 156, 249),
                          ]),
                    ),
                    child: Column(
                      children: [
                        Icon(Icons.person, size: 100,),
                        Text(
                          'Menú del cliente',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    )),
                ListTile(
                  title: Text('Mapa de busqueda'),
                  selected: state.pageIndex == 0,
                  onTap: () {
                    context
                        .read<ClientHomeBloc>()
                        .add(ChangeDrawerPage(pageIndex: 0));
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: Text('Historial de viajes'),
                  selected: state.pageIndex == 1,
                  onTap: () {
                    context
                        .read<ClientHomeBloc>()
                        .add(ChangeDrawerPage(pageIndex: 1));
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: Text('Perfil del usuario'),
                  selected: state.pageIndex == 2,
                  onTap: () {
                    context
                        .read<ClientHomeBloc>()
                        .add(ChangeDrawerPage(pageIndex: 2));
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: Text('Roles de usuario'),
                  selected: state.pageIndex == 3,
                  onTap: () {
                    context
                        .read<ClientHomeBloc>()
                        .add(ChangeDrawerPage(pageIndex: 3));
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: Text('Cerrar sesion'),
                  onTap: () {
                    // context.read<ClientHomeBloc>().add(Logout());
                    // context.read<BlocSocketIO>().add(DisconnectSocketIO());
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => ClientHomeTutPage()),
                        (route) => false);
                  },
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
