import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:indriver_clone_flutter/blocSocketIO/BlocSocketIO.dart';
import 'package:indriver_clone_flutter/blocSocketIO/BlocSocketIOEvent.dart';
import 'package:indriver_clone_flutter/main.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/driver/clientRequests/DriverClientRequestsPage.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/driver/home/bloc/DriverHomeBloc.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/driver/home/bloc/DriverHomeState.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/driver/home/bloc/DriverHomeEvent.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/driver/mapLocation/DriverMapLocationPage.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/profile/info/ProfileInfoPage.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/roles/RolesPage.dart';

class DriverHomePage extends StatefulWidget {
  const DriverHomePage({Key? key}) : super(key: key);

  @override
  State<DriverHomePage> createState() => _DriverHomePageState();
}

class _DriverHomePageState extends State<DriverHomePage> {
  final List<Widget> pageList = [
    DriverMapLocationPage(),
    DriverClientRequestsPage(),
    ProfileInfoPage(),
    RolesPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menu de opciones'),
      ),
      body: BlocBuilder<DriverHomeBloc, DriverHomeState>(
        builder: (context, state) {
          // Asegurarse de que pageIndex esté en el rango correcto
          final int pageIndex = state.pageIndex.clamp(0, pageList.length - 1);
          return pageList[pageIndex];
        },
      ),
      drawer: BlocBuilder<DriverHomeBloc, DriverHomeState>(
        builder: (context, state) {
          return Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                const DrawerHeader(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [
                          Color.fromARGB(255, 12, 38, 145),
                          Color.fromARGB(255, 34, 156, 249),
                        ]),
                  ),
                  child: Text(
                    'Menu del Conductor',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                ListTile(
                  title: const Text('Mapa de localizacion'),
                  selected: state.pageIndex == 0,
                  onTap: () {
                    context.read<DriverHomeBloc>().add(ChangeDrawerPage(pageIndex: 0));
                    Navigator.pop(context);
                  },
                ),
                
                ListTile(
                  title: const Text('Solicitudes de Viaje'),
                  selected: state.pageIndex == 1,
                  onTap: () {
                    context.read<DriverHomeBloc>().add(ChangeDrawerPage(pageIndex: 1));
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: const Text('Perfil del usuario'),
                  selected: state.pageIndex == 2,
                  onTap: () {
                    context.read<DriverHomeBloc>().add(ChangeDrawerPage(pageIndex: 2));
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: const Text('Roles de usuario'),
                  selected: state.pageIndex == 3,
                  onTap: () {
                    context.read<DriverHomeBloc>().add(ChangeDrawerPage(pageIndex: 3));
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: const Text('Cerrar sesion'),
                  onTap: () {
                    context.read<DriverHomeBloc>().add(Logout());
                    context.read<BlocSocketIO>().add(DisconnectSocketIO());
                    Navigator.pushAndRemoveUntil(
                      context, 
                      MaterialPageRoute(builder: (context) => MyApp()), 
                      (route) => false
                    );
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
