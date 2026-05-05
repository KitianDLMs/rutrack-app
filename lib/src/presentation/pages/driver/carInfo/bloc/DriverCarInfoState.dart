import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:localdriver/src/domain/utils/Resource.dart';
import 'package:localdriver/src/presentation/utils/BlocFormItem.dart';

class DriverCarInfoState extends Equatable {

  final int? idDriver;

  final BlocFormItem brand;
  final BlocFormItem model;
  final BlocFormItem year;

  final BlocFormItem plate;
  final BlocFormItem color;

  final String vehicleType;

  final Resource? response;
  final GlobalKey<FormState>? formKey;

  const DriverCarInfoState({
    this.idDriver,
    this.brand = const BlocFormItem(value: '', error: null),
    this.model = const BlocFormItem(value: '', error: null),
    this.year = const BlocFormItem(value: '', error: null),
    this.plate = const BlocFormItem(value: '', error: null),
    this.color = const BlocFormItem(value: '', error: null),
    this.vehicleType = 'UberX',
    this.formKey,
    this.response,
  });

  DriverCarInfoState copyWith({
    int? idDriver,
    BlocFormItem? brand,
    BlocFormItem? model,
    BlocFormItem? year,
    BlocFormItem? plate,
    BlocFormItem? color,
    String? vehicleType,
    GlobalKey<FormState>? formKey,
    Resource? response,
  }) {
    return DriverCarInfoState(
      idDriver: idDriver ?? this.idDriver,
      brand: brand ?? this.brand,
      model: model ?? this.model,
      year: year ?? this.year,
      plate: plate ?? this.plate,
      color: color ?? this.color,
      vehicleType: vehicleType ?? this.vehicleType,
      formKey: formKey ?? this.formKey,
      response: response ?? this.response,
    );
  }

  @override
  List<Object?> get props => [
        idDriver,
        brand,
        model,
        year,
        plate,
        color,
        vehicleType,
        response,
      ];
}