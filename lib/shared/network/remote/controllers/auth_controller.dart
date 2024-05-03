import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/model/response_model.dart';
import 'package:shop_app/model/sign_in_body_model.dart';
import 'package:shop_app/model/sign_up_body_model.dart';
import 'package:shop_app/shared/network/remote/data/repository/auth_repo.dart';
import 'package:get/get.dart';

import '../../../components/const/app_constants.dart';

class AuthController extends GetxController implements GetxService{
  final AuthRepo authRepo;
  AuthController({
    required this.authRepo
  });

  bool _isLoading = false;
  bool get isLoading =>_isLoading;
 Future<ResponseModel> registration(SignUpBody signUpBody) async {
    _isLoading=true;
    update();
   Response response=await authRepo.registration(signUpBody);
    late ResponseModel responseModel;
   if(response.statusCode==200){
         authRepo.saveUserToken(response.body['token']);
         responseModel =ResponseModel(true, response.body['token']);
   }else{
         responseModel= ResponseModel(false, response.statusText!);
   }
   _isLoading=false;
   update();
   return responseModel;
  }

 Future<ResponseModel> login(String email,String password) async {
    _isLoading=true;
    update();
   Response response=await authRepo.login(email,password);
    late ResponseModel responseModel;
   if(response.statusCode==200){
         authRepo.saveUserToken(response.body['token']);
         print('My Token is : '+response.body['token'].toString());
         responseModel =ResponseModel(true, response.body['token']);
   }else{
         responseModel= ResponseModel(false, response.statusText!);
   }
   _isLoading=false;
   update();
   return responseModel;
  }

  bool userLoggedIn(){
    return authRepo.userLoggedIn();
  }

  bool clearData(){
   return authRepo.clearSharedData();
  }


  void saveUserNumberAndPassword(String number,String password) {
   authRepo.saveUserNumberAndPassword(number, password);
  }
}