import 'package:stay_travel_v3/models/review.dart';
import 'package:stay_travel_v3/services/api_service.dart';
import 'package:stay_travel_v3/utils/logger.dart';

class ReviewService {
  Future<bool> createReview(Review review, String hotelId) async {
    try {
      final response = await ApiService.instance.dio.post(
        '/reviews/reviews/$hotelId',
        data: review.toJson(),
        options: ApiService.instance.getHeaders(),
      );
      if (response.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      Logger.log('$e', level: LogLevel.error);
      throw Exception('Ошибка создания отзыва');
    }
  }

  Future<List<Review>> fetchHotelReviews(String hotelId) async {
    try {
      final response =
          await ApiService.instance.dio.get('/reviews/$hotelId');
      return List<Review>.from(
          response.data.map((review) => Review.fromJson(review)));
    } catch (e) {
      Logger.log('$e', level: LogLevel.error);
      throw Exception('Ошибка получения отзывов');
    }
  }
}
