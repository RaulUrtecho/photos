import 'dart:async';

import 'package:photos/models/photo.dart';
import 'package:photos/services/photos_service.dart';

// Reactive repository
class PhotosRepository {
  final _photosService = PhotosService();
  static const defaultLimit = 10;
  final _photoStreamController = StreamController<List<Photo>>.broadcast()..add([]);
  var _lastPhotos = <Photo>[];

  PhotosRepository() {
    photos.listen((photos) => _lastPhotos = photos);
  }

  Stream<List<Photo>> get photos => _photoStreamController.stream;

  Future<List<Photo>> fetchPhotos(int start, {int limit = defaultLimit}) async {
    try {
      final newPhotos = await _photosService.getPhotos(start, limit);
      _photoStreamController.add([..._lastPhotos, ...newPhotos]);
      return newPhotos;
    } catch (e) {
      _photoStreamController.addError(e);
      return [];
    }
  }

  void dispose() => _photoStreamController.close();
}
