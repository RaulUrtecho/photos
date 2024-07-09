// test/unit/photo_viewmodel_test.dart

import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:photos/models/photo.dart';
import 'package:photos/repositories/photos_repository.dart';
import 'package:photos/ui/view_model/photos_view_model.dart';
import 'photo_view_model_test.mocks.dart';

@GenerateNiceMocks([MockSpec<PhotosRepository>()])
void main() {
  late MockPhotosRepository mockPhotosRepository;
  late PhotosViewModel viewModel;

  setUp(() {
    mockPhotosRepository = MockPhotosRepository();
    viewModel = PhotosViewModel(mockPhotosRepository);
  });

  tearDown(() => viewModel.dispose());

  test('Initial state is correct', () async {
    // Arrange
    when(mockPhotosRepository.photos).thenAnswer((_) => Stream.fromIterable([]));
    // Act
    final length = await viewModel.photos.length;
    // Assert
    expect(length, 0);
    expect(viewModel.hasMore, true);
    expect(viewModel.isLoading, false);
  });

  test('loadPhotos updates state correctly', () async {
    // Arrange
    const mockPhotos = [
      Photo(id: 1, title: 'Photo 1', url: 'https://picsum.photos/id/1/200/300'),
      Photo(id: 2, title: 'Photo 2', url: 'https://picsum.photos/id/2/200/300'),
    ];
    when(mockPhotosRepository.fetchPhotos(any)).thenAnswer((_) async => mockPhotos);
    when(mockPhotosRepository.photos).thenAnswer((_) => Stream.fromIterable([mockPhotos]));
    // Act
    await viewModel.loadPhotos();
    final length = await viewModel.photos.length;
    // Assert
    expect(length, 1);
    expect(viewModel.hasMore, false);
    expect(viewModel.isLoading, false);
  });

  test('Error handling in loadPhotos', () async {
    // Arrange
    when(mockPhotosRepository.fetchPhotos(0)).thenThrow(Exception('Failed to fetch'));
    when(mockPhotosRepository.photos).thenAnswer((_) => Stream.fromIterable([]));
    // Act
    await viewModel.loadPhotos();
    final length = await viewModel.photos.length;
    // Assert
    expect(length, 0);
    expect(viewModel.isLoading, false);
  });
}
