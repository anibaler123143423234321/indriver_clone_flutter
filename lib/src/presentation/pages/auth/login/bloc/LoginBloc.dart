import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/auth/login/bloc/LoginEvent.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/auth/login/bloc/LoginState.dart';
import 'package:indriver_clone_flutter/src/presentation/utils/BlocFormItem.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {

final formKey = GlobalKey<FormState>();

LoginBloc(): super(LoginState()) {
  on<LoginInitEvent>((event, emit)  {
    emit(state.copyWith(formKey: formKey));
  });  


  on<EmailChanged>((event, emit)  {
    emit(
      state.copyWith(
        email: BlocFormItem(
          value: event.email.value,
          error: event.email.value.isEmpty ? 'Ingresa el email' : null
        ),
        formKey: formKey
      )
    );
  });

  on<PasswordChanged>((event, emit)  {
    emit(
      state.copyWith(
        password: BlocFormItem(
          value: event.password.value,
          error: 
          event.password.value.isEmpty 
          ? 'Ingresa el password' 
          : event.password.value.length < 6
          ? 'Minimo 6 caracteres'
          : null
        ),
        formKey: formKey
      )
    );
  }); 

  on<FormSubmit>((event, emit)  {
    print('Email: ${state.email.value}');
    print('Password: ${state.password.value}');
  });   

}
}