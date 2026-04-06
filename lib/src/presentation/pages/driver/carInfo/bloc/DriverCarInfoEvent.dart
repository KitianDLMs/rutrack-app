import 'package:localdriver/src/domain/models/user.dart';
import 'package:localdriver/src/presentation/utils/BlocFormItem.dart';

abstract class DriverCarInfoEvent {}

class DriverCarInfoInitEvent extends DriverCarInfoEvent {}

class BrandChanged extends DriverCarInfoEvent {
  final BlocFormItem brand;
  BrandChanged({ required this.brand });
}

class PlateChanged extends DriverCarInfoEvent {
  final BlocFormItem plate;
  PlateChanged({ required this.plate });
}

class ColorChanged extends DriverCarInfoEvent {
  final BlocFormItem color;
  ColorChanged({ required this.color });
}

class MaxWeightChanged extends DriverCarInfoEvent {
  final BlocFormItem maxWeight;
  MaxWeightChanged({ required this.maxWeight });
}

class WeightUnitChanged extends DriverCarInfoEvent {
  final String unit;
  WeightUnitChanged({ required this.unit });
}

class TruckTypeChanged extends DriverCarInfoEvent {
  final String type;
  TruckTypeChanged({ required this.type });
}

class HelpersChanged extends DriverCarInfoEvent {
  final bool value;
  HelpersChanged({ required this.value });
}

class CraneChanged extends DriverCarInfoEvent {
  final bool value;
  CraneChanged({ required this.value });
}

class FormSubmit extends DriverCarInfoEvent {}