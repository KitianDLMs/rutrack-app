import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:localdriver/src/domain/models/AuthResponse.dart';
import 'package:localdriver/src/domain/models/DriverCarInfo.dart';
import 'package:localdriver/src/domain/useCases/auth/AuthUseCases.dart';
import 'package:localdriver/src/domain/useCases/driver-car-info/DriverCarInfoUseCases.dart';
import 'package:localdriver/src/domain/useCases/users/UsersUseCases.dart';
import 'package:localdriver/src/domain/utils/Resource.dart';
import 'package:localdriver/src/presentation/pages/driver/carInfo/bloc/DriverCarInfoEvent.dart';
import 'package:localdriver/src/presentation/pages/driver/carInfo/bloc/DriverCarInfoState.dart';
import 'package:localdriver/src/presentation/utils/BlocFormItem.dart';

class DriverCarInfoBloc extends Bloc<DriverCarInfoEvent, DriverCarInfoState> {

  AuthUseCases authUseCases;
  DriverCarInfoUseCases driverCarInfoUseCases;
  final formKey = GlobalKey<FormState>();

  DriverCarInfoBloc(this.authUseCases, this.driverCarInfoUseCases): super(DriverCarInfoState()) {

    on<HelpersChanged>((event, emit) {
      emit(
        state.copyWith(
          hasHelpers: event.value,
          formKey: formKey
        )
      );
    });

    on<CraneChanged>((event, emit) {
      emit(
        state.copyWith(
          hasCrane: event.value,
          formKey: formKey
        )
      );
    });
    
    on<MaxWeightChanged>((event, emit) {
      emit(
        state.copyWith(
          maxWeight: BlocFormItem(value: event.maxWeight.value),
          formKey: formKey
        )
      );
    });

    on<WeightUnitChanged>((event, emit) {
      emit(
        state.copyWith(
          weightUnit: event.unit,
          formKey: formKey
        )
      );
    });

    on<TruckTypeChanged>((event, emit) {
      emit(
        state.copyWith(
          truckType: event.type,
          formKey: formKey
        )
      );
    });

    on<DriverCarInfoInitEvent>((event, emit) async {
      emit(
        state.copyWith(
          formKey: formKey
        )
      );
      AuthResponse authResponse = await authUseCases.getUserSession.run();
      print('authResponse.user.id ${authResponse.user.id}');
      Resource response = await driverCarInfoUseCases.getDriverCarInfo.run(authResponse.user.id!);
      if (response is Success) {
        final driverCarInfo = response.data as DriverCarInfo;
         emit(
          state.copyWith(
            idDriver: authResponse.user.id!,
            brand: BlocFormItem(
              value: driverCarInfo.brand
            ),
            plate: BlocFormItem(
              value: driverCarInfo.plate
            ),
            color: BlocFormItem(
              value: driverCarInfo.color
            ),
            formKey: formKey
          )
        );
      }
     
    });
    on<BrandChanged>((event, emit) {
      emit(
        state.copyWith(
          brand: BlocFormItem(
            value: event.brand.value,
            error: event.brand.value.isEmpty ? 'Ingresa la marca' : null
          ),
          formKey: formKey
        )
      );
    });
    on<PlateChanged>((event, emit) {
      emit(
        state.copyWith(
          plate: BlocFormItem(
            value: event.plate.value,
            error: event.plate.value.isEmpty ? 'Ingresa la placa del vehiculo' : null
          ),
          formKey: formKey
        )
      );
    });
    on<ColorChanged>((event, emit) {
      emit(
        state.copyWith(
          color: BlocFormItem(
            value: event.color.value,
            error: event.color.value.isEmpty ? 'Ingresa el color del vehiculo' : null
          ),
          formKey: formKey
        )
      );
    });
    
    on<FormSubmit>((event, emit) async {
      emit(
        state.copyWith(
          response: Loading(),
          formKey: formKey
        )
      );
      AuthResponse authResponse = await authUseCases.getUserSession.run();
      Resource response = await driverCarInfoUseCases.createDriverCarInfo.run(
          DriverCarInfo(
            idDriver: authResponse.user.id,
            brand: state.brand.value,
            plate: state.plate.value,
            color: state.color.value,

            maxWeight: state.maxWeight.value.isNotEmpty
                ? state.maxWeight.value
                : '0',
            weightUnit: state.weightUnit,
            truckType: state.truckType,

            maxVolume: state.maxVolume.value.isNotEmpty
                ? double.tryParse(state.maxVolume.value)
                : null,

            hasHelpers: state.hasHelpers,
            hasCrane: state.hasCrane,
          )
      );
      emit(
        state.copyWith(
          response: response,
          formKey: formKey
        )
      );
    });
  }

}