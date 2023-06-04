part of 'image_bloc.dart';

@immutable
abstract class ImageEvent {}

class AddImageButtonClickedEvent extends ImageEvent{}

class SaveImageButtonClickedEvent extends ImageEvent{}

class ImageDeleteEvent extends ImageEvent{}
