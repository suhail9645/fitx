import 'dart:convert';

import 'package:either_dart/either.dart';
import 'package:fitx/src/data/repositories/remote/trainer_operation_imp.dart';
import 'package:fitx/src/domain/model/error/error.dart';
import 'package:fitx/src/domain/model/trainer_list/result.dart';
import 'package:fitx/src/domain/model/trainer_list/trainer_list.dart';
import 'package:http/http.dart';

class TrainerRepo{
  Future<Either<ErrorModel,List<Result>>>getAllTrainers()async{
   try{
  final responseOrError=await TrainerOperationImp().fetchAllTrainers();
  if(responseOrError.isRight){
    Response response=responseOrError.right;
    List<Result>allApplication=[];
    while(true){
      Map<String,dynamic>data=jsonDecode(response.body);
      TrainerList trainerList=TrainerList.fromJson(data);
      for (Result element in trainerList.results??[]) {
        allApplication.add(element);
      }
      if(trainerList.next!=null){
        final responOrError=await TrainerOperationImp().trainersFetchHelper(trainerList.next);
        if(responOrError.isRight){
          response=responOrError.right;
        }
      }else{
         return Right(allApplication);
      }
    }
   
  }
  else{
      return Left(responseOrError.left);
    }
   }catch(e){
    return Left(ErrorModel(e.toString()));
   }
  }
}