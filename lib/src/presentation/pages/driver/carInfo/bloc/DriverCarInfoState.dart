import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:localdriver/src/domain/utils/Resource.dart';
import 'package:localdriver/src/presentation/utils/BlocFormItem.dart';

class DriverCarInfoState extends Equatable {

  final int? idDriver;
  final BlocFormItem brand;
  final BlocFormItem plate;
  final BlocFormItem color;

  final BlocFormItem maxWeight;
  final String weightUnit;
  final String truckType;
  final BlocFormItem maxVolume;
  final bool hasHelpers;
  final bool hasCrane;

  final Resource? response;
  final GlobalKey<FormState>? formKey;

  const DriverCarInfoState({
    this.idDriver,
    this.brand = const BlocFormItem(error: 'Ingresa la marca'),
    this.plate = const BlocFormItem(error: 'Ingresa la placa'),
    this.color = const BlocFormItem(error: 'Ingresa el color'),

    this.maxWeight = const BlocFormItem(error: 'Ingresa el peso máximo'),
    this.weightUnit = 'KG',
    this.truckType = 'Camioneta',
    this.maxVolume = const BlocFormItem(),
    this.hasHelpers = false,
    this.hasCrane = false,

    this.formKey,
    this.response,
  });

  DriverCarInfoState copyWith({
    int? idDriver,
    BlocFormItem? brand,
    BlocFormItem? plate,
    BlocFormItem? color,
    BlocFormItem? maxWeight,
    String? weightUnit,
    String? truckType,
    BlocFormItem? maxVolume,
    bool? hasHelpers,
    bool? hasCrane,
    GlobalKey<FormState>? formKey,
    Resource? response,
  }) {
    return DriverCarInfoState(
      idDriver: idDriver ?? this.idDriver,
      brand: brand ?? this.brand,
      plate: plate ?? this.plate,
      color: color ?? this.color,
      maxWeight: maxWeight ?? this.maxWeight,
      weightUnit: weightUnit ?? this.weightUnit,
      truckType: truckType ?? this.truckType,
      maxVolume: maxVolume ?? this.maxVolume,
      hasHelpers: hasHelpers ?? this.hasHelpers,
      hasCrane: hasCrane ?? this.hasCrane,
      formKey: formKey ?? this.formKey,
      response: response ?? this.response,
    );
  }

  @override
  List<Object?> get props => [
        idDriver,
        brand,
        plate,
        color,
        maxWeight,
        weightUnit,
        truckType,
        maxVolume,
        hasHelpers,
        hasCrane,
        response,
      ];
}