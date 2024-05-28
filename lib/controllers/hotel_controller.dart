import 'package:flutter/material.dart';
import 'package:stay_travel_v3/models/feature.dart';
import 'package:stay_travel_v3/services/api_service.dart';
import 'package:stay_travel_v3/models/hotel.dart';
import 'package:stay_travel_v3/utils/logger.dart';

class HotelController with ChangeNotifier {
  List<Hotel> _hotels = [];
  bool _isLoading = false;
  bool _hasMore = true;
  int _skip = 1;
  final int _limit = 10; // Fixed limit value

  List<Hotel> get hotels => _hotels;
  bool get isLoading => _isLoading;
  bool get hasMore => _hasMore;

  Hotel fakeHotel = Hotel(
    id: "id", 
    name: "Hotel name name", 
    description: "Hotel description Hotel description Hotel description Hotel description ", 
    address: "Hotel address", 
    averageRating: null, 
    images: [], 
    reviews: [], 
    createdAt: DateTime.now(), 
    features: [
      Feature(id: "id", name: "name", icon: "wi-fi"),
      Feature(id: "id", name: "name", icon: "wi-fi"),
      Feature(id: "id", name: "name", icon: "wi-fi"),
      Feature(id: "id", name: "name", icon: "wi-fi")
    ]
  );

  Future<void> fetchHotels({bool reset = false}) async {
    if (_isLoading) return;

    if (reset) {
      _skip = 1;
      _hotels = [];
      _hasMore = true;
    }

    _isLoading = true;
    notifyListeners();

    try {
      final fetchedHotels = await ApiService.instance.fetchHotels(skip: _skip, limit: _limit);
      if (fetchedHotels.length < _limit) {
        _hasMore = false;
      }
      _hotels.addAll(fetchedHotels);
      _skip += 1;
    } catch (e) {
      Logger.log(e.toString(), level: LogLevel.error);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> retryFetch() async {
    await fetchHotels(reset: true);
  }
}
