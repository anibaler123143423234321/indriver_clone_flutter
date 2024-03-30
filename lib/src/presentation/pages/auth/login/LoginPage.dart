import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:indriver_clone_flutter/src/domain/models/AuthResponse.dart';
import 'package:indriver_clone_flutter/src/domain/utils/Resource.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/auth/login/LoginContent.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/auth/login/bloc/LoginBloc.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/auth/login/bloc/LoginEvent.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/auth/login/bloc/LoginState.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //backgroundColor: Color.fromARGB(255, 24, 181, 254),
    body: BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        final response = state.response;
        if(response is ErrorData){
          Fluttertoast.showToast(msg: '${response.message}', toastLength: Toast.LENGTH_SHORT);
          print('Error Data: ${response.message}');
        }
        else if(response is Success){
          Fluttertoast.showToast(msg: '${response.data}', toastLength: Toast.LENGTH_SHORT);
          print('Data: ${response.data}');
          final authResponse = response.data as AuthResponse;
          context.read<LoginBloc>().add(SaveUserSession(authResponse: response.data));
          Navigator.pushNamedAndRemoveUntil(context, 'client/home', (route) => false);
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          final response = state.response;
          if (response is Loading){
            return Stack  (
              children: [
                LoginContent(state),
                Center(
                  child: CircularProgressIndicator(),
                ),
              ],
            );
          }
          return LoginContent(state);
        },
      ),
    ));
  }
}
