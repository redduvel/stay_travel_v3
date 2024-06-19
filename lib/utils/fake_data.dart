import 'package:stay_travel_v3/models/feature.dart';
import 'package:stay_travel_v3/models/hotel.dart';

class FakeData {
  static  Hotel fakeHotel = Hotel(
    id: "id",
    name: "Sunset Paradise Resort",
    description: "A luxurious resort offering stunning ocean views, world-class amenities, and unparalleled service.",
    address: "123 Beachfront Ave, Malibu, CA 90265",
    averageRating: 4.8,
    images: [],
    createdAt: DateTime.now(),
    features: [
      Feature(
        id: "1",
        name: "Free Wi-Fi",
        icon: "wifi",
      ),
      Feature(
        id: "2",
        name: "Swimming Pool",
        icon: "pool",
      ),
      Feature(
        id: "3",
        name: "Spa",
        icon: "spa",
      ),
    ],
    totalClients: 5
  );

  static String fakeImage = 'https://rbkt.org/b/8f/1f/31/8f1f31e39041fbdb340b75d435263661.jpg';
}