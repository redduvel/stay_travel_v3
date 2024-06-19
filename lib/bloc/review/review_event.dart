import 'package:equatable/equatable.dart';
import 'package:stay_travel_v3/models/review.dart';

abstract class ReviewEvent extends Equatable {
  const ReviewEvent();

  @override
  List<Object> get props => [];
}

class FetchHotelReviews extends ReviewEvent {
  final String hotelId;

  const FetchHotelReviews({required this.hotelId});

  @override
  List<Object> get props => [hotelId];
}

class CreateReview extends ReviewEvent {
  final String hotelId;
  final Review review;

  const CreateReview({required this.review, required this.hotelId});

  @override
  List<Object> get props => [review];
}