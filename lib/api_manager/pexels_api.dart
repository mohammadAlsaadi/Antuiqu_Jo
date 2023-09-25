// ignore_for_file: avoid_print

import 'package:dio/dio.dart';

class PexelsRepository {
  final Dio _dio = Dio();

  Future<List<String>> searchPhotos({
    required String carSearchQuery,
    required String carColor,
  }) async {
    String searchQuery = carSearchQuery;
    String color = carColor;
    String orientation = 'landscape';
    String size = 'small';
    String apiUrl =
        'https://api.pexels.com/v1/search?query=$searchQuery&color=$color&size=$size&orientation=$orientation';

    try {
      final response = await _dio.get(
        apiUrl,
        options: Options(headers: {
          'Authorization':
              '1mu6FAoFt43hcHf1d3FqPKcXfZFDKjy33o3jvUA18mpBHeBhqQMZDTqF',
        }),
      );

      if (response.statusCode == 200) {
        final data = response.data;
        List<String> fetchedImageUrls = [];
        for (var photo in data['photos']) {
          String imageUrl = photo['src']['original'];
          fetchedImageUrls.add(imageUrl);
        }
        return fetchedImageUrls; // Return the fetched image URLs
      } else {
        print('API Error: ${response.statusCode}');
        throw 'API Error: ${response.statusCode}';
      }
    } catch (e) {
      print('Error: $e');
      throw 'Error: $e';
    }
  }
}
