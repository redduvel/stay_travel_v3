import 'package:equatable/equatable.dart';
import 'package:stay_travel_v3/models/review.dart';

abstract class ReviewState extends Equatable {
  const ReviewState();

  @override
  List<Object> get props => [];
}

class ReviewInitial extends ReviewState {}

class ReviewsLoading extends ReviewState {}

class ReviewsLoaded extends ReviewState {
  final List<Review> reviews;

  const ReviewsLoaded({required this.reviews});

  @override
  List<Object> get props => [reviews];
}

class ReviewsError extends ReviewState {
  final String message;

  const ReviewsError({required this.message});

  @override
  List<Object> get props => [message];
}


class ReviewCreated extends ReviewState {
  final bool result;

  const ReviewCreated({required this.result});

  @override
  List<Object> get props => [result];
}




