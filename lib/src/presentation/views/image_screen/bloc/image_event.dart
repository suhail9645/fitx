part of 'image_bloc.dart';

@immutable
abstract class ImageEvent {}

class ImageInitialEvent extends ImageEvent {}

class SaveImageButtonClickedEvent extends ImageEvent {
  final File image;
  SaveImageButtonClickedEvent({required this.image});
}

class ImageDeleteEvent extends ImageEvent {
  final int id;

  ImageDeleteEvent({required this.id});
}
