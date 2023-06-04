part of 'image_bloc.dart';

@immutable
abstract class ImageState {}

class ImageInitial extends ImageState {}

class AddImageState extends ImageState{
  final File image;

  AddImageState(this.image);

}

class SaveImageSuccessState extends ImageState{}

class SaveImageErrorState extends ImageState{}
