import 'package:bloc/bloc.dart';

part 'check_box_state.dart';

class CheckBoxCubit extends Cubit<CheckBoxState> {
   late List<bool> boolList;
  CheckBoxCubit() : super(CheckBoxInitial(isCheck: []));
 
  void onChanged(bool value,int index){
    boolList[index]=value;
    print(boolList);
    emit(CheckBoxInitial(isCheck: boolList));
  }
  void listGenerate(int length){
    boolList=List.generate(length, (index) => false);
    emit(CheckBoxInitial(isCheck: boolList));
  }void onSavedCategory(){
boolList=List.generate(boolList.length, (index) => false);
   emit(CheckBoxInitial(isCheck: boolList));
  }
}

class FilePickerCubit extends Cubit<bool>{
  FilePickerCubit():super(true);
 void onPickedNonMp3(){
  emit(false);
 }
 void onPickedMp3(){
  emit(true);
 }
}
