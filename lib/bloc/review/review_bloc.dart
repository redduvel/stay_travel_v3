import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stay_travel_v3/bloc/review/review_event.dart';
import 'package:stay_travel_v3/bloc/review/review_service.dart';
import 'package:stay_travel_v3/bloc/review/review_state.dart';
import 'package:stay_travel_v3/utils/logger.dart';

class ReviewBloc extends Bloc<ReviewEvent, ReviewState> {
    final ReviewService reviewService;

  ReviewBloc(this.reviewService) : super(ReviewInitial()) {
    on<CreateReview>(_onCreateReview);
    on<FetchHotelReviews>(_onFetchHotelReviews);
  }


  Future<void> _onCreateReview(CreateReview event, Emitter<ReviewState> emit) async {
    try {
      emit(ReviewsLoading());

      final result = await reviewService.createReview(event.review, event.hotelId);
      if (result) {
        emit(ReviewCreated(result: result));
      } else {
        emit(const ReviewsError(message: 'Ошибка создания отзыва.'));
      }
    } catch (e) {
      Logger.log(e.toString(), level: LogLevel.error);
      emit(ReviewsError(message: e.toString()));
    }
  }

  Future<void> _onFetchHotelReviews(FetchHotelReviews event, Emitter<ReviewState> emit) async {
    try {
      emit(ReviewsLoading());

      final result = await reviewService.fetchHotelReviews(event.hotelId);
      
      emit(ReviewsLoaded(reviews: result));
    } catch (e) {
      Logger.log(e.toString(), level: LogLevel.error);
      emit(ReviewsError(message: e.toString()));
    }
  }
}