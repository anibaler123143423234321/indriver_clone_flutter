import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/client/home/bloc/ClientHomeBloc.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/client/home/bloc/ClientHomeEvent.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/client/home/bloc/ClientHomeState.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/client/mapSeeker/ClientMapSeekerPage.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/profile/info/ProfileInfoPage.dart';

class ClientHomePage extends StatefulWidget {
  const ClientHomePage({Key? key}) : super(key: key);

  @override
  State<ClientHomePage> createState() => _ClientHomePageState();
}

class _ClientHomePageState extends State<ClientHomePage> {
  List<Widget> pageList = <Widget>[
    ClientMapSeekerPage(), // Agrega el widget de mapa como primera opción
    ProfileInfoPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Menu de opciones'),
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
                      ],
                    ),
                  ),
                  child: Text(
                    'Menu del Cliente',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                ListTile(
                  title: Text('Mapa del Buscador'), // Cambia el nombre para el nuevo widget
                  selected: state.pageIndex == 0,
                  onTap: () {
                    context.read<ClientHomeBloc>().add(ChangeDrawerPage(pageIndex: 0));
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: Text('Perfil de Usuario'),
                  selected: state.pageIndex == 1,
                  onTap: () {
                    context.read<ClientHomeBloc>().add(ChangeDrawerPage(pageIndex: 1));
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: Text('Cerrar Sesión'),
                  onTap: () {
                    context.read<ClientHomeBloc>().add(Logout());
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      'login',
                      (route) => false,
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
