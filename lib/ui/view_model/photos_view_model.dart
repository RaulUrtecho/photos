import 'dart:async';

import 'package:photos/models/photo.dart';
import 'package:photos/repositories/photos_repository.dart';

class PhotosViewModel {
  final PhotosRepository _photosRepository;
  var _start = 0;
  var hasMore = true;
  var isLoading = false;

  PhotosViewModel(this._photosRepository);

  Stream<List<Photo>> get photos => _photosRepository.photos;

  Future<void> loadPhotos() async {
    if (isLoading) return;
    isLoading = true;
    try {
      final photos = await _photosRepository.fetchPhotos(_start);
      _start += PhotosRepository.defaultLimit;
      if (photos.length < PhotosRepository.defaultLimit) {
        hasMore = false;
      }
    } catch (e) {
      // We could hadle a specific error message here for the UI
      isLoading = false;
      return;
    }
    isLoading = false;
  }

  void dispose() => _photosRepository.dispose();
}
