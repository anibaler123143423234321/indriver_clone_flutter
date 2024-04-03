import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:indriver_clone_flutter/src/domain/models/DriverTripRequest.dart';
import 'package:indriver_clone_flutter/src/domain/utils/Resource.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/client/driverOffers/ClientDriverOffersItem.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/client/driverOffers/bloc/ClientDriverOffersBloc.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/client/driverOffers/bloc/ClientDriverOffersEvent.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/client/driverOffers/bloc/ClientDriverOffersState.dart';

class ClientDriverOffersPage extends StatefulWidget {
  const ClientDriverOffersPage({Key? key}) : super(key: key);

  @override
  State<ClientDriverOffersPage> createState() => _ClientDriverOffersPageState();
}

class _ClientDriverOffersPageState extends State<ClientDriverOffersPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      context.read<ClientDriverOffersBloc>().add(GetDriverOffers(idClientRequest: 7));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Driver Offers'),
      ),
      body: BlocConsumer<ClientDriverOffersBloc, ClientDriverOffersState>(
        listener: (context, state) {
          final response = state.responseDriverOffers;
          if (response is ErrorData) {
            Fluttertoast.showToast(msg: response.message, toastLength: Toast.LENGTH_LONG);
          }
        },
        builder: (context, state) {
          final response = state.responseDriverOffers;

          if (response is Loading) {
            return Center(child: CircularProgressIndicator());
          } 
          else if (response is Success) {
            List<DriverTripRequest> driverTripRequest = response.data as List<DriverTripRequest>;
            return ListView.builder(
                itemCount: driverTripRequest.length,
                itemBuilder: (context, index) {
                  return ClientDriverOffersItem(driverTripRequest[index]);
                });
          }
          return Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Esperando conductores...',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                  ),
                )
              ],
            ),
          );
        }
      ),
    );
  }
}
