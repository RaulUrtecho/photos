import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:photos/models/photo.dart';

class PhotosService {
  final _baseUrl = 'http://jsonplaceholder.typicode.com';

  Future<List<Photo>> getPhotos(int start, int limit) async {
    try {
      // Uncomment the line below to simulate an api error
      // throw Exception('Socket exception example');
      final res = await http.get(Uri.parse('$_baseUrl/photos?_start=$start&_limit=$limit'));
      if (res.statusCode == 200) {
        return List.from(json.decode(res.body)).map((json) => Photo.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load photos');
      }
    } catch (e) {
      rethrow;
    }
  }
}
