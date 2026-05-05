import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localdriver/src/presentation/pages/driver/carInfo/bloc/DriverCarInfoBloc.dart';
import 'package:localdriver/src/presentation/pages/driver/carInfo/bloc/DriverCarInfoEvent.dart';
import 'package:localdriver/src/presentation/pages/driver/carInfo/bloc/DriverCarInfoState.dart';
import 'package:localdriver/src/presentation/utils/BlocFormItem.dart';
import 'package:localdriver/src/presentation/widgets/DefaultIconBack.dart';
import 'package:localdriver/src/presentation/widgets/DefaultTextField.dart';

class DriverCarInfoContent extends StatelessWidget {
  DriverCarInfoState state;

  DriverCarInfoContent(this.state);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: state.formKey,
      child: Stack(
        children: [
          Column(
            children: [
              _headerProfile(context),
              Spacer(),
              _actionProfile(context, 'ACTUALIZAR DATOS', Icons.check),
              SizedBox(
                height: 35,
              )
            ],
          ),
          _cardUserInfo(context)
        ],
      ),
    );
  }

  Widget _cardUserInfo(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 35, right: 35, top: 100),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.65,
      child: Card(
        color: Colors.white,
        surfaceTintColor: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 40),
              DefaultTextField(
                text: 'Marca del vehículo',
                icon: Icons.directions_car,
                margin: EdgeInsets.only(left: 30, right: 30, top: 15),
                backgroundColor: Colors.grey[200]!,
                initialValue: state.brand.value,
                onChanged: (text) {
                  context
                      .read<DriverCarInfoBloc>()
                      .add(BrandChanged(brand: BlocFormItem(value: text)));
                },
                validator: (value) => state.brand.error,
              ),
              DefaultTextField(
                text: 'Modelo',
                icon: Icons.badge,
                margin: EdgeInsets.only(left: 30, right: 30, top: 15),
                backgroundColor: Colors.grey[200]!,
                initialValue: state.model.value,
                onChanged: (text) {
                  context
                      .read<DriverCarInfoBloc>()
                      .add(ModelChanged(model: BlocFormItem(value: text)));
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Ingresa modelo';
                  }
                  return null;
                },
              ),
              DefaultTextField(
                text: 'Año',
                icon: Icons.calendar_today,
                margin: EdgeInsets.only(left: 30, right: 30, top: 15),
                backgroundColor: Colors.grey[200]!,
                keyboardType: TextInputType.number,
                initialValue: state.year.value,
                onChanged: (text) {
                  context
                      .read<DriverCarInfoBloc>()
                      .add(YearChanged(year: BlocFormItem(value: text)));
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Ingresa año';
                  }
                  return null;
                },
              ),
              DefaultTextField(
                text: 'Patente',
                icon: Icons.confirmation_number,
                margin: EdgeInsets.only(left: 30, right: 30, top: 15),
                backgroundColor: Colors.grey[200]!,
                initialValue: state.plate.value,
                onChanged: (text) {
                  context
                      .read<DriverCarInfoBloc>()
                      .add(PlateChanged(plate: BlocFormItem(value: text)));
                },
                validator: (value) => state.plate.error,
              ),
              DefaultTextField(
                text: 'Color',
                icon: Icons.palette,
                margin: EdgeInsets.only(left: 30, right: 30, top: 15),
                backgroundColor: Colors.grey[200]!,
                initialValue: state.color.value,
                onChanged: (text) {
                  context
                      .read<DriverCarInfoBloc>()
                      .add(ColorChanged(color: BlocFormItem(value: text)));
                },
                validator: (value) => state.color.error,
              ),
              Container(
                margin: EdgeInsets.only(left: 30, right: 30, top: 15),
                child: DropdownButtonFormField<String>(
                  value: state.vehicleType,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.local_taxi),
                    filled: true,
                    fillColor: Colors.grey[200],
                    labelText: 'Tipo de vehículo',
                  ),
                  items: ['UberX', 'UberXL', 'Moto', 'Premium']
                      .map((type) => DropdownMenuItem(
                            value: type,
                            child: Text(type),
                          ))
                      .toList(),
                  onChanged: (value) {
                    context
                        .read<DriverCarInfoBloc>()
                        .add(VehicleTypeChanged(type: value!));
                  },
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _actionProfile(BuildContext context, String option, IconData icon) {
    return GestureDetector(
      onTap: () {
        if (state.formKey!.currentState != null) {
          if (state.formKey!.currentState!.validate()) {
            context.read<DriverCarInfoBloc>().add(FormSubmit());
          }
        } else {
          context.read<DriverCarInfoBloc>().add(FormSubmit());
        }
      },
      child: Container(
        margin: EdgeInsets.only(left: 20, right: 20, top: 15),
        child: ListTile(
          title: Text(
            option,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          leading: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      Color.fromARGB(255, 19, 58, 213),
                      Color.fromARGB(255, 65, 173, 255),
                    ]),
                borderRadius: BorderRadius.all(Radius.circular(50))),
            child: Icon(
              icon,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget _headerProfile(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      padding: EdgeInsets.only(top: 30),
      height: MediaQuery.of(context).size.height * 0.3,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Color.fromARGB(255, 19, 58, 213),
              Color.fromARGB(255, 65, 173, 255),
            ]),
      ),
      child: Text(
        'DATOS DEL VEHICULO',
        style: TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 19),
      ),
    );
  }
}
