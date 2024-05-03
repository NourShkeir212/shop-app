import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/model/response_model.dart';
import 'package:shop_app/model/sign_in_body_model.dart';
import 'package:shop_app/model/sign_up_body_model.dart';
import 'package:shop_app/model/user_model.dart';
import 'package:shop_app/shared/network/remote/data/repository/auth_repo.dart';
import 'package:shop_app/shared/network/remote/data/repository/user_repo.dart';
import 'package:get/get.dart';

import '../../../components/const/app_constants.dart';

class UserController extends GetxController implements GetxService{
  final UserRepo userRepo;
  UserController({
    required this.userRepo
  });

  bool _isLoading = false;
  UserModel? _userModel;
  bool get isLoading =>_isLoading;
  UserModel? get userModel=> _userModel;


  Future<ResponseModel> getUserInfo() async {



    Response response=await userRepo.getUserInfo();
    late ResponseModel responseModel;
    if(response.statusCode==200){
      _userModel=UserModel.fromJson(response.body);
      _isLoading=true;
      update();
      responseModel =ResponseModel(true,'successfuly');
    }else{
      responseModel= ResponseModel(false, response.statusText!);
    }

    update();
    return responseModel;
  }
}