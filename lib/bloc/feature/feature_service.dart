import 'package:stay_travel_v3/models/feature.dart';
import 'package:stay_travel_v3/services/api_service.dart';
import 'package:stay_travel_v3/utils/logger.dart';

class FeatureService {
  Future<List<Feature>> fetchFeatures() async {
    try {
      final response = await ApiService.instance.dio.get('/features/');

      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        return data.map((json) => Feature.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load features');
      }
    } catch (e) {
      Logger.log('$e', level: LogLevel.error);
      return [];
    }
  }
}
