import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/client/mapSeeker/bloc/ClientMapSeekerBloc.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/client/mapSeeker/bloc/ClientMapSeekerEvent.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/client/mapSeeker/bloc/ClientMapSeekerState.dart';
import 'package:indriver_clone_flutter/src/presentation/widgets/DefaultButton.dart';
import 'package:indriver_clone_flutter/src/presentation/widgets/GooglePlacesAutoComplete.dart';

class ClientMapSeekerPage extends StatefulWidget {
  const ClientMapSeekerPage({Key? key}) : super(key: key);

  @override
  State<ClientMapSeekerPage> createState() => _ClientMapSeekerPageState();
}

class _ClientMapSeekerPageState extends State<ClientMapSeekerPage> {
  TextEditingController pickUpController = TextEditingController();
  TextEditingController destinationController = TextEditingController();

  // Define controller como una variable de instancia
  TextEditingController controller = TextEditingController();

  static const CameraPosition _kGooglePex = CameraPosition(
    target: LatLng(0, 0),
    zoom: 15,
  );

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      context.read<ClientMapSeekerBloc>().add(ClientMapSeekerInitEvent());
      context.read<ClientMapSeekerBloc>().add(FindPosition());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ClientMapSeekerBloc, ClientMapSeekerState>(
        builder: (context, state) {
          return Stack(
            children: [
              GoogleMap(
                mapType: MapType.normal,
                initialCameraPosition: state.cameraPosition,
                markers: Set<Marker>.of(state.markers.values),
                onCameraMove: (CameraPosition cameraPosition){
                  context.read<ClientMapSeekerBloc>().add(OnCameraMove(cameraPosition: cameraPosition));
                },
                onCameraIdle: () async{
                  context.read<ClientMapSeekerBloc>().add(OnCameraIdle());
                  pickUpController.text = state.placemarkData?.address ?? '';
                  if(state.placemarkData !=null){
                  context.read<ClientMapSeekerBloc>().add(OnAutoCompletedPickUpSelected(
                  lat: state.placemarkData!.lat, 
                  lng: state.placemarkData!.lng, 
                  pickUpDescription: state.placemarkData!.address
                  ));
                  }
                },
                onMapCreated: (GoogleMapController controller) {
                  controller.setMapStyle(
                      '[{"elementType":"geometry","stylers":[{"color":"#212121"}]},{"elementType":"labels.icon","stylers":[{"visibility":"off"}]},{"elementType":"labels.text.fill","stylers":[{"color":"#757575"}]},{"elementType":"labels.text.stroke","stylers":[{"color":"#212121"}]},{"featureType":"administrative","elementType":"geometry","stylers":[{"color":"#757575"}]},{"featureType":"administrative.country","elementType":"labels.text.fill","stylers":[{"color":"#9e9e9e"}]},{"featureType":"administrative.land_parcel","stylers":[{"visibility":"off"}]},{"featureType":"administrative.locality","elementType":"labels.text.fill","stylers":[{"color":"#bdbdbd"}]},{"featureType":"poi","elementType":"labels.text.fill","stylers":[{"color":"#757575"}]},{"featureType":"poi.park","elementType":"geometry","stylers":[{"color":"#181818"}]},{"featureType":"poi.park","elementType":"labels.text.fill","stylers":[{"color":"#616161"}]},{"featureType":"poi.park","elementType":"labels.text.stroke","stylers":[{"color":"#1b1b1b"}]},{"featureType":"road","elementType":"geometry.fill","stylers":[{"color":"#2c2c2c"}]},{"featureType":"road","elementType":"labels.text.fill","stylers":[{"color":"#8a8a8a"}]},{"featureType":"road.arterial","elementType":"geometry","stylers":[{"color":"#373737"}]},{"featureType":"road.highway","elementType":"geometry","stylers":[{"color":"#3c3c3c"}]},{"featureType":"road.highway.controlled_access","elementType":"geometry","stylers":[{"color":"#4e4e4e"}]},{"featureType":"road.local","elementType":"labels.text.fill","stylers":[{"color":"#616161"}]},{"featureType":"transit","elementType":"labels.text.fill","stylers":[{"color":"#757575"}]},{"featureType":"water","elementType":"geometry","stylers":[{"color":"#000000"}]},{"featureType":"water","elementType":"labels.text.fill","stylers":[{"color":"#3d3d3d"}]}]');
                  if(!state.controller!.isCompleted){
                  state.controller?.complete(controller);
                  }
                },
              ),
              Container(
                height: 120,
                margin: EdgeInsets.only(left: 30, right: 30, top: 30),
                child:  _googlePlacesAutocomplete()
              ),
              _iconMyLocation(),
              Container(
                alignment: Alignment.bottomCenter,
                child: DefaultButton(
                  text: 'REVISAR VIAJE', 
                  margin: EdgeInsets.only(left: 50, right: 50, bottom: 50),
                  onPressed: (){
                Navigator.pushNamed(
                  context, 'client/map/booking/',
                  arguments: {
                    'pickUpLatLng': state.pickUpLatLng,
                    'destinationLatLng': state.destinationLatLng,
                    'pickUpDescription': state.pickUpDescription,
                    'destinationDescription': state.destinationDescription,
                  }
                );
              })
              )
            ],
          );
        },
      ),
    );
  }

  Widget _googlePlacesAutocomplete() {
    return Card(
      surfaceTintColor: Colors.white,
      child: Column(
        children: [
          GooglePlacesAutoComplete(
            pickUpController, 
            'Recoger en', 
            (Prediction prediction) {
              if (prediction != null) {
                context.read<ClientMapSeekerBloc>().add(ChangeMapCameraPosition(
                  lat: double.parse(prediction.lat!), 
                  lng: double.parse(prediction.lng!),
                ));
                context.read<ClientMapSeekerBloc>().add(OnAutoCompletedPickUpSelected(
                  lat: double.parse(prediction.lat!), 
                  lng: double.parse(prediction.lng!),
                  pickUpDescription: prediction.description ?? ''
                ));
              }
            }
          ),
          Divider(
            color: Colors.grey[200],
          ),
          GooglePlacesAutoComplete(
            destinationController, 
            'Dejar en', 
            (Prediction prediction) {
              context.read<ClientMapSeekerBloc>().add(OnAutoCompletedDestinationSelected(
                lat: double.parse(prediction.lat!), 
                lng: double.parse(prediction.lng!),
                destinationDescription: prediction.description ?? ''
              ));
            }
          )
        ],
      ),
    );
  }

   Widget _iconMyLocation() {
    return Container(
      margin: EdgeInsets.only(bottom: 25),
      alignment: Alignment.center,
      child: Image.asset(
        'assets/img/location_blue.png',
        width: 50,
        height: 50,
      ),
    );
  }

}
