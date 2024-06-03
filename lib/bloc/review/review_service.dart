import 'package:stay_travel_v3/models/review.dart';
import 'package:stay_travel_v3/services/api_service.dart';
import 'package:stay_travel_v3/utils/logger.dart';

class ReviewService {
  Future<bool> createReview(Review review, String hotelId) async {
    try {
      await ApiService.instance.dio.post(
        '/reviews/hotel/$hotelId',
        data: review.toJson(),
        options: ApiService.instance.getHeaders(),
      );
      return true;
    } catch (e) {
      Logger.log('$e', level: LogLevel.error);
      return false;
    }
  }

  Future<List<Review>> fetchHotelReviews(String hotelId) async {
    try {
      final response =
          await ApiService.instance.dio.get('/reviews/hotel/$hotelId');
      return List<Review>.from(
          response.data.map((review) => Review.fromJson(review)));
    } catch (e) {
      Logger.log('$e', level: LogLevel.error);
      return [];
    }
  }
}
