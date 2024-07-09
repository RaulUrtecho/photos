import 'package:flutter/material.dart';
import 'package:photos/models/photo.dart';
import 'package:photos/repositories/photos_repository.dart';
import 'package:photos/ui/view_model/photos_view_model.dart';

class PhotosScreen extends StatefulWidget {
  const PhotosScreen({super.key});

  @override
  State<PhotosScreen> createState() => _PhotosScreenState();
}

class _PhotosScreenState extends State<PhotosScreen> {
  final _viewModel = PhotosViewModel(PhotosRepository());
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _viewModel.loadPhotos();
    // Fetch data when scrolled to bottom
    _scrollController.addListener(() {
      if ((_scrollController.position.maxScrollExtent == _scrollController.offset) && _viewModel.hasMore) {
        _viewModel.loadPhotos();
      }
    });
  }

  @override
  void dispose() {
    _viewModel.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Photos App with MVVM')),
      backgroundColor: Colors.white.withOpacity(.9),
      body: StreamBuilder<List<Photo>>(
        stream: _viewModel.photos,
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting && !_viewModel.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const Center(child: Text('Failed to load photos'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No photos available'));
          } else {
            final photos = snapshot.data!;
            return ListView.separated(
              padding: const EdgeInsets.all(16),
              controller: _scrollController,
              itemCount: photos.length + (_viewModel.isLoading ? 1 : 0),
              separatorBuilder: (_, __) => const SizedBox(height: 16),
              itemBuilder: (_, index) {
                if (index < photos.length) {
                  final photo = photos[index];
                  return Card(
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(8),
                      leading: SizedBox(
                        width: 80,
                        height: 80,
                        child: Image.network(
                          photo.url,
                          loadingBuilder: (_, child, loadingProgress) {
                            return loadingProgress == null ? child : const Center(child: CircularProgressIndicator());
                          },
                          errorBuilder: (_, __, ___) => const Center(child: Text('Error loading')),
                        ),
                      ),
                      title: Text('${index + 1} ${photo.title}'),
                    ),
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            );
          }
        },
      ),
    );
  }
}
