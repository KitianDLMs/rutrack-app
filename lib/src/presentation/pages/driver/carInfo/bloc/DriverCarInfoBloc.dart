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

  DriverCarInfoBloc(this.authUseCases, this.driverCarInfoUseCases)
      : super(DriverCarInfoState()) {
    on<HelpersChanged>((event, emit) {
      emit(state.copyWith(formKey: formKey));
    });

    on<ModelChanged>((event, emit) {
      emit(
        state.copyWith(
          model: BlocFormItem(
            value: event.model.value,
            error: event.model.value.isEmpty ? 'Ingresa modelo' : null,
          ),
          formKey: formKey,
        ),
      );
    });

    on<YearChanged>((event, emit) {
      emit(
        state.copyWith(
          year: BlocFormItem(
            value: event.year.value,
            error: event.year.value.isEmpty ? 'Ingresa año' : null,
          ),
          formKey: formKey,
        ),
      );
    });

    on<CraneChanged>((event, emit) {
      emit(state.copyWith(formKey: formKey));
    });

    on<MaxWeightChanged>((event, emit) {
      emit(state.copyWith(formKey: formKey));
    });

    on<WeightUnitChanged>((event, emit) {
      emit(state.copyWith(formKey: formKey));
    });

    on<TruckTypeChanged>((event, emit) {
      emit(state.copyWith(formKey: formKey));
    });

    on<DriverCarInfoInitEvent>((event, emit) async {
      emit(state.copyWith(formKey: formKey));
      AuthResponse authResponse = await authUseCases.getUserSession.run();
      print('authResponse.user.id ${authResponse.user.id}');
      Resource response = await driverCarInfoUseCases.getDriverCarInfo
          .run(authResponse.user.id!);
      if (response is Success) {
        final driverCarInfo = response.data as DriverCarInfo;
        emit(state.copyWith(
            idDriver: authResponse.user.id!,
            brand: BlocFormItem(value: driverCarInfo.brand),
            model: BlocFormItem(value: driverCarInfo.model ?? ''),
            year: BlocFormItem(value: driverCarInfo.year?.toString() ?? ''),
            plate: BlocFormItem(value: driverCarInfo.plate),
            color: BlocFormItem(value: driverCarInfo.color),
            formKey: formKey));
      }
    });
    on<BrandChanged>((event, emit) {
      emit(state.copyWith(
          brand: BlocFormItem(
              value: event.brand.value,
              error: event.brand.value.isEmpty ? 'Ingresa la marca' : null),
          formKey: formKey));
    });
    on<PlateChanged>((event, emit) {
      emit(state.copyWith(
          plate: BlocFormItem(
              value: event.plate.value,
              error: event.plate.value.isEmpty
                  ? 'Ingresa la placa del vehiculo'
                  : null),
          formKey: formKey));
    });
    on<ColorChanged>((event, emit) {
      emit(state.copyWith(
          color: BlocFormItem(
              value: event.color.value,
              error: event.color.value.isEmpty
                  ? 'Ingresa el color del vehiculo'
                  : null),
          formKey: formKey));
    });

    on<FormSubmit>((event, emit) async {
      emit(state.copyWith(response: Loading(), formKey: formKey));
      AuthResponse authResponse = await authUseCases.getUserSession.run();
      Resource response =
          await driverCarInfoUseCases.createDriverCarInfo.run(DriverCarInfo(
        idDriver: authResponse.user.id,
        brand: state.brand.value,
        model: state.model.value,
        year: int.tryParse(state.year.value),
        plate: state.plate.value,
        color: state.color.value,
      ));
      emit(state.copyWith(response: response, formKey: formKey));
    });
  }
}
