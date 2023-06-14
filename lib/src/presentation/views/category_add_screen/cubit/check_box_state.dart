part of 'check_box_cubit.dart';

abstract class CheckBoxState {
  const CheckBoxState();

  
}

class CheckBoxInitial extends CheckBoxState {
  final List<bool> isCheck;

  CheckBoxInitial({required this.isCheck});
}

