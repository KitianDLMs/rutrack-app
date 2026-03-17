import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:localdriver/src/domain/models/DriverTripRequest.dart';
import 'package:localdriver/src/domain/utils/Resource.dart';
import 'package:localdriver/src/presentation/pages/client/driverOffers/ClientDriverOffersItem.dart';
import 'package:localdriver/src/presentation/pages/client/driverOffers/bloc/ClientDriverOffersBloc.dart';
import 'package:localdriver/src/presentation/pages/client/driverOffers/bloc/ClientDriverOffersEvent.dart';
import 'package:localdriver/src/presentation/pages/client/driverOffers/bloc/ClientDriverOffersState.dart';
import 'package:lottie/lottie.dart';

class ClientDriverOffersPage extends StatefulWidget {
  final int idClientRequest;

  const ClientDriverOffersPage({
    super.key,
    required this.idClientRequest
  });

  @override
  State<ClientDriverOffersPage> createState() => _ClientDriverOffersPageState();
}

class _ClientDriverOffersPageState extends State<ClientDriverOffersPage> {
  int? idClientRequest;

  @override
  void initState() {
    super.initState();
    idClientRequest = widget.idClientRequest;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ClientDriverOffersBloc>().add(
        ListenNewDriverOfferSocketIO(idClientRequest: idClientRequest!),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<ClientDriverOffersBloc, ClientDriverOffersState>(
        listener: (context, state) {

          print('responsestate $state');
          final response = state.responseDriverOffers;
          final responseAssignDriver = state.responseAssignDriver;
          print('responseAssignDriver $responseAssignDriver');
          if (response is ErrorData) {
            Fluttertoast.showToast(
                msg: response.message, toastLength: Toast.LENGTH_LONG);
          }
          if (responseAssignDriver is Success) {
            Navigator.pushNamed(context, 'client/map/trip',
                arguments: idClientRequest);
          }
        },
        child: BlocBuilder<ClientDriverOffersBloc, ClientDriverOffersState>(
            builder: (context, state) {
          final response = state.responseDriverOffers;

          if (response is Loading) {
            print('driverTripRequest $response');
            return Center(child: CircularProgressIndicator());
          } else if (response is Success<List<DriverTripRequest>>) {
              final driverTripRequestList = response.data;
              print('driverTripRequestList $driverTripRequestList');
            List<DriverTripRequest> driverTripRequest =
                response.data as List<DriverTripRequest>;
            print('driverTripRequest2 $driverTripRequest');
            if (driverTripRequest.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Esperando conductores..."),
                    SizedBox(height: 20),
                    CircularProgressIndicator(color: Colors.grey),
                  ],
                ),
              );
            }

            return ListView.builder(
              itemCount: driverTripRequest.length,
              itemBuilder: (context, index) {
                return ClientDriverOffersItem(driverTripRequest[index]);
              },
            );
          }
          return Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Esperando conductores...',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                CircularProgressIndicator()
                // Lottie.asset(
                //   'assets/lottie/waiting_car.json',
                //   width: 400,
                //   height: 230,
                //   // fit: BoxFit.fill,
                // )
              ],
            ),
          );
        }),
      ),
    );
  }
}
