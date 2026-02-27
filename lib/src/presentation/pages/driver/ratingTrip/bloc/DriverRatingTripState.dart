import 'package:equatable/equatable.dart';
import 'package:localdriver/src/domain/utils/Resource.dart';

class DriverRatingTripState extends Equatable {

  final double rating;
  final Resource? response;

  DriverRatingTripState({
    this.rating = 0,
    this.response
  });

  DriverRatingTripState copyWith({
    double? rating,
    Resource? response
  }) {
    return DriverRatingTripState(
      rating: rating ?? this.rating,
      response: response
    );
  }

  @override
  List<Object?> get props => [rating, response];

}