// ignore_for_file: avoid_print

import 'package:dio/dio.dart';

class CarAPI {
  final String apiKey =
      '01ZYe2V35f8AeXLuqfaY6lsBWwizI6EONg5bJszNiYtlqbWFb6r81d65';
  final Dio dio = Dio();

  Future<List<String>> fetchCarImages(String type, String color) async {
    final String baseUrl =
        'https://api.pexels.com/v1/search?query=$type&color=$color&size=small&orientation=landscape';

    try {
      final Response response = await dio.get(baseUrl);

      if (response.statusCode == 200) {
        final data = response.data;
        final List<String> fetchedImageUrls = [];
        for (var photo in data['photos']) {
          String imageUrl = photo['src']['original'];
          fetchedImageUrls.add(imageUrl);
        }

        return fetchedImageUrls;
      } else {
        print('Request failed with status: ${response.statusCode}');
        return [];
      }
    } catch (error) {
      print('Error: $error');
      return [];
    }
  }
}
