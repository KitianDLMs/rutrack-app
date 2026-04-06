import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:localdriver/src/domain/models/ClientRequestResponse.dart';
import 'package:localdriver/src/domain/models/DriverTripRequest.dart';
import 'package:localdriver/src/presentation/pages/driver/clientRequests/bloc/DriverClientRequestsBloc.dart';
import 'package:localdriver/src/presentation/pages/driver/clientRequests/bloc/DriverClientRequestsEvent.dart';
import 'package:localdriver/src/presentation/pages/driver/clientRequests/bloc/DriverClientRequestsState.dart';
import 'package:localdriver/src/presentation/utils/BlocFormItem.dart';
import 'package:localdriver/src/presentation/utils/GalleryOrPhotoDialog.dart';
import 'package:localdriver/src/presentation/widgets/DefaultTextField.dart';

class DriverClientRequestsItem extends StatelessWidget {
  DriverClientRequestsState state;
  ClientRequestResponse? clientRequest;

  DriverClientRequestsItem(this.state, this.clientRequest);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FareOfferedDialog(context, () {
          if (clientRequest != null &&
              state.idDriver != null &&
              context
                  .read<DriverClientRequestsBloc>()
                  .state
                  .fareOffered
                  .value
                  .isNotEmpty) {
            context
                .read<DriverClientRequestsBloc>()
                .add(CreateDriverTripRequest(
                    driverTripRequest: DriverTripRequest(
                  idDriver: state.idDriver!,
                  idClientRequest: clientRequest!.id!,
                  fareOffered: double.parse(context
                      .read<DriverClientRequestsBloc>()
                      .state
                      .fareOffered
                      .value),
                  time: clientRequest!.googleDistanceMatrix!.duration.value
                          .toDouble() /
                      60,
                  distance: clientRequest!.googleDistanceMatrix!.distance.value
                          .toDouble() /
                      1000,
                )));
          } else {
            Fluttertoast.showToast(
                msg: 'No se puede enviar la oferta',
                toastLength: Toast.LENGTH_LONG);
          }
        });
      },
      child: Column(
        children: [
          Text(
            'SOLICITUDES DE VIAJE',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.grey[700],
              letterSpacing: 1,
            ),
          ),
          Card(
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            child: Container(
                constraints: BoxConstraints(
                  maxHeight: 350,
                ),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          trailing: _imageUser(),
                          title: Text(
                            '\$${clientRequest?.fareOffered}',
                            style: TextStyle(
                              color: Colors.blueAccent,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          subtitle: Text(
                            '${clientRequest?.client!.name ?? ''}',
                            style: TextStyle(fontSize: 13),
                          ),
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            _infoItem(
                              "Desde",
                              clientRequest?.pickupDescription ?? '',
                              Icons.location_on,
                            ),
                            _infoItem(
                              "Hasta",
                              clientRequest?.destinationDescription ?? '',
                              Icons.flag,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            _infoItem(
                              "Tiempo",
                              clientRequest
                                      ?.googleDistanceMatrix?.duration.text ??
                                  '',
                              Icons.access_time,
                            ),
                            _infoItem(
                              "Distancia",
                              clientRequest
                                      ?.googleDistanceMatrix?.distance.text ??
                                  '',
                              Icons.route,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            _infoItem(
                              "Carga",
                              "${clientRequest?.requiredWeight ?? '-'} ${clientRequest?.weightUnit ?? ''}",
                              Icons.scale,
                            ),
                            _infoItem(
                              "Camión",
                              clientRequest?.truckType ?? '-',
                              Icons.local_shipping,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            _infoItem(
                              "Ayudantes",
                              clientRequest?.requireHelpers == true
                                  ? 'Sí'
                                  : 'No',
                              Icons.people,
                            ),
                            _infoItem(
                              "Grúa",
                              clientRequest?.requireCrane == true ? 'Sí' : 'No',
                              Icons.construction,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                )),
          ),
        ],
      ),
    );
  }

  Widget _itemCompact(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 130,
          child: Text(
            label,
            style: TextStyle(
              color: Colors.grey[700],
              fontWeight: FontWeight.bold,
              fontSize: 13,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(fontSize: 13),
          ),
        ),
      ],
    );
  }

  Widget _infoItem(String title, String value, IconData icon) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.all(5),
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 3,
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, size: 16, color: Colors.blueAccent),
            SizedBox(height: 3),
            Text(title, style: TextStyle(fontSize: 12, color: Colors.grey)),
            SizedBox(height: 3),
            Text(value,
                maxLines: 2, style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  Widget _textMinutes() {
    return Row(
      children: [
        Container(
          width: 140,
          child: Text(
            'Tiempo de llegada: ',
            style: TextStyle(
                color: const Color.fromARGB(255, 112, 106, 106),
                fontWeight: FontWeight.bold),
          ),
        ),
        Flexible(
            child: Text(
                clientRequest?.googleDistanceMatrix?.duration?.text ?? '')),
      ],
    );
  }

  Widget _textDistance() {
    return Row(
      children: [
        Container(
          width: 140,
          child: Text(
            'Recorrido: ',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        Flexible(
            child: Text(
                clientRequest?.googleDistanceMatrix?.distance!.text ?? '')),
      ],
    );
  }

  Widget _textPickup() {
    return Row(
      children: [
        Container(
          width: 90,
          child: Text(
            'Recoger en: ',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        Flexible(child: Text(clientRequest?.pickupDescription ?? '')),
      ],
    );
  }

  Widget _textDestination() {
    return Row(
      children: [
        Container(
          width: 90,
          child: Text(
            'Llevar a: ',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        Flexible(child: Text(clientRequest?.destinationDescription ?? '')),
      ],
    );
  }

  Widget _imageUser() {
    final imageUrl = clientRequest?.client?.image;

    return Container(
      width: 60,
      child: AspectRatio(
        aspectRatio: 1,
        child: ClipOval(
          child: imageUrl != null && imageUrl.isNotEmpty
              ? FadeInImage.assetNetwork(
                  placeholder: 'assets/img/user_image.png',
                  image: imageUrl,
                  fit: BoxFit.cover,
                  fadeInDuration: Duration(seconds: 1),
                )
              : Image.asset(
                  'assets/img/user_image.png',
                  fit: BoxFit.cover,
                ),
        ),
      ),
    );
  }

  FareOfferedDialog(BuildContext context, Function() submit) {
    return showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              title: Text(
                'Ingresa tu tarifa',
                style: TextStyle(fontSize: 17),
              ),
              contentPadding: EdgeInsets.only(bottom: 15),
              content: DefaultTextField(
                  text: 'Valor',
                  icon: Icons.attach_money,
                  keyboardType: TextInputType.phone,
                  onChanged: (text) {
                    print('Tarifa del viaje: ${text}');
                    context.read<DriverClientRequestsBloc>().add(
                        FareOfferedChange(
                            fareOffered: BlocFormItem(value: text)));
                  }),
              actions: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      submit();
                    },
                    child: Text(
                      'Enviar tarifa',
                      style: TextStyle(color: Colors.black),
                    )),
              ],
            ));
  }
}
