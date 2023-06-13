part of 'add_image_bloc.dart';

abstract class AddImageState {}

class AddImageInitial extends AddImageState {}

class AfterImageState extends AddImageState {
  final File image;
  AfterImageState({required this.image});
}

class AfterImageSavedState extends AddImageState {}
