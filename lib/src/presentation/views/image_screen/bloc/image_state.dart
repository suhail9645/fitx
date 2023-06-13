part of 'image_bloc.dart';

@immutable
abstract class ImageState {}

class ImageInitial extends ImageState {}

class ImageInitialState extends ImageState {
  final List<ImageModel> images;

  ImageInitialState({required this.images});
}

class SaveImageSuccessState extends ImageState {}

class SaveImageErrorState extends ImageState {}

class ImageLoadingState extends ImageState {}

class DeleteImageSuccess extends ImageState {}
