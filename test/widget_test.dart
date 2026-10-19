import 'package:flutter_test/flutter_test.dart';
import 'package:nugasspot_malang/models/cafe.dart';
import 'package:nugasspot_malang/main.dart';

void main() {
  test('Cafe model serialization test', () {
    final jsonSample = {
      'id': 'c99',
      'name': 'Test Cafe',
      'tagline': 'Uji Coba',
      'category': 'Focus & Quiet',
      'categories': ['Focus & Quiet'],
      'address': 'Jl. Veteran',
      'subdistrict': 'Lowokwaru',
      'rating': 4.9,
      'reviewCount': 100,
      'openHours': '24 Jam',
      'isOpen24Hours': true,
      'priceRange': 'Rp 10.000',
      'priceLevel': '\$',
      'wifiSpeed': '50 Mbps',
      'noiseLevel': 'Tenang',
      'imageUrl': 'https://example.com/image.jpg',
      'facilities': ['Wi-Fi'],
      'recommendedMenu': ['Latte'],
      'description': 'Deskripsi uji coba',
      'mapsUrl': 'https://maps.google.com',
      'isFavorite': false,
    };

    final cafe = Cafe.fromJson(jsonSample);
    expect(cafe.id, 'c99');
    expect(cafe.name, 'Test Cafe');
    expect(cafe.isOpen24Hours, true);
    expect(cafe.rating, 4.9);

    final mapped = cafe.toJson();
    expect(mapped['name'], 'Test Cafe');
  });

  testWidgets('NugasSpotApp boots smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const NugasSpotApp());
    expect(find.byType(NugasSpotApp), findsOneWidget);
  });
}
