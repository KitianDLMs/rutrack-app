import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localdriver/blocSocketIO/BlocSocketIO.dart';
import 'package:localdriver/blocSocketIO/BlocSocketIOEvent.dart';
import 'package:localdriver/src/data/dataSource/local/SharefPref.dart' as sharedPref;
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
  bool isLogged = false;
  List<Widget> pageList = <Widget>[
    ClientMapSeekerPage(),
    ClientHistoryTripPage(),
    ProfileInfoPage(),
    RolesPage(),
  ];

  @override
  void initState() {
    super.initState();
    _checkSession();
  }


  void _checkSession() async {    
    final token = await sharedPref.SharefPref().read('user');
    setState(() {
      isLogged = token != null;
    });
  }

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
          'Flete',
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
                if (isLogged)
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
                if (isLogged)
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
                if(isLogged)
                ListTile(
                  title: Text('Cerrar sesion'),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('Cerrar sesión'),
                          content: Text('¿Estás seguro que quieres salir de la app Flete?'),
                          actions: [

                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text('Cancelar'),
                            ),
                            TextButton(
                              child: Text(
                                'Sí, salir',
                                style: TextStyle(color: Colors.red),
                              ),
                              onPressed: () {
                                 Navigator.pop(context);

                                context.read<ClientHomeBloc>().add(Logout());
                                context.read<BlocSocketIO>().add(DisconnectSocketIO());

                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(builder: (context) => ClientHomeTutPage()),
                                  (route) => false,
                                );
                              },
                            ),               

                          ],
                        );
                      },
                    );
                  },
                ),
                if(!isLogged)
                ListTile(
                  title: Text('Salir'),
                  onTap: () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => ClientHomeTutPage()),
                        (route) => false);
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
