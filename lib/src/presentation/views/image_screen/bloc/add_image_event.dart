part of 'add_image_bloc.dart';

abstract class AddImageEvent extends Equatable {
  const AddImageEvent();

  @override
  List<Object> get props => [];
}

class AddImageButtonClickedEvent extends AddImageEvent {}

class AfterSaveImageEvent extends AddImageEvent {}
