import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localdriver/blocSocketIO/BlocSocketIO.dart';
import 'package:localdriver/blocSocketIO/BlocSocketIOEvent.dart';
import 'package:localdriver/main.dart';
import 'package:localdriver/src/presentation/pages/client/mapSeeker/ClientMapSeekerPage.dart';
import 'package:localdriver/src/presentation/pages/driver/carInfo/DriverCarInfoPage.dart';
import 'package:localdriver/src/presentation/pages/driver/clientRequests/DriverClientRequestsPage.dart';
import 'package:localdriver/src/presentation/pages/driver/historyTrip/DriverHistoryTripPage.dart';
import 'package:localdriver/src/presentation/pages/driver/home/bloc/DriverHomeBloc.dart';
import 'package:localdriver/src/presentation/pages/driver/home/bloc/DriverHomeState.dart';
import 'package:localdriver/src/presentation/pages/driver/home/bloc/DriverHomeEvent.dart';
import 'package:localdriver/src/presentation/pages/driver/mapLocation/DriverMapLocationPage.dart';
import 'package:localdriver/src/presentation/pages/home-tutorial/ClientHomeTutPage.dart';
import 'package:localdriver/src/presentation/pages/profile/info/ProfileInfoPage.dart';
import 'package:localdriver/src/presentation/pages/roles/RolesPage.dart';

class DriverHomePage extends StatefulWidget {
  const DriverHomePage({super.key});

  @override
  State<DriverHomePage> createState() => _DriverHomePageState();
}

class _DriverHomePageState extends State<DriverHomePage> {
  List<Widget> pageList = <Widget>[
    DriverMapLocationPage(),
    DriverClientRequestsPage(),
    DriverCarInfoPage(),
    DriverHistoryTripPage(),
    ProfileInfoPage(),
    RolesPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'LOCAL DRIVER',
        ),
        // flexibleSpace: Container(
        //   decoration: BoxDecoration(
        //     gradient: LinearGradient(
        //       begin: Alignment.topRight,
        //       end: Alignment.bottomLeft,
        //       colors: [
        //         Color.fromARGB(255, 12, 38, 145),
        //         Color.fromARGB(255, 34, 156, 249),
        //       ]
        //     ),
        //   )
        // ),
      ),
      body: BlocBuilder<DriverHomeBloc, DriverHomeState>(
        builder: (context, state) {
          return pageList[state.pageIndex];
        },
      ),
      drawer: BlocBuilder<DriverHomeBloc, DriverHomeState>(
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
                      ]
                    ),
                  ),
                  child: Text(
                    'Menu del Conductor',
                    style: TextStyle(color: Colors.white),
                  )
                ),
                ListTile(
                  title: Text('Mapa de localizacion'),
                  selected: state.pageIndex == 0,
                  onTap: () {
                    context.read<DriverHomeBloc>().add(ChangeDrawerPage(pageIndex: 0));
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: Text('Solicitudes de viaje'),
                  selected: state.pageIndex == 1,
                  onTap: () {
                    context.read<DriverHomeBloc>().add(ChangeDrawerPage(pageIndex: 1));
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: Text('Mi Vehiculo'),
                  selected: state.pageIndex == 2,
                  onTap: () {
                    context.read<DriverHomeBloc>().add(ChangeDrawerPage(pageIndex: 2));
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: Text('Historial de viajes'),
                  selected: state.pageIndex == 3,
                  onTap: () {
                    context
                        .read<DriverHomeBloc>()
                        .add(ChangeDrawerPage(pageIndex: 3));
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: Text('Perfil del usuario'),
                  selected: state.pageIndex == 4,
                  onTap: () {
                    context
                        .read<DriverHomeBloc>()
                        .add(ChangeDrawerPage(pageIndex: 4));
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: Text('Roles de usuario'),
                  selected: state.pageIndex == 5,
                  onTap: () {
                    context
                        .read<DriverHomeBloc>()
                        .add(ChangeDrawerPage(pageIndex: 5));
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: Text('Cerrar sesion'),
                  onTap: () {
                    context.read<DriverHomeBloc>().add(Logout());
                    context.read<BlocSocketIO>().add(DisconnectSocketIO());
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
