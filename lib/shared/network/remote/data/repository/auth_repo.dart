import 'package:shop_app/model/sign_in_body_model.dart';
import 'package:shop_app/shared/components/const/app_constants.dart';
import 'package:shop_app/shared/network/remote/data/api/api_client.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../model/sign_up_body_model.dart';

class AuthRepo{
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  AuthRepo({
    required this.apiClient,
    required this.sharedPreferences,
  });

  Future<Response> registration(SignUpBody signUpBody)async{
   return await apiClient.postData(
     AppConstants.REGESTRATION_URI,
     signUpBody.toJson(),
   );
  }

  Future<Response> login(String email,String password)async{
    return await apiClient.postData(
      AppConstants.LOGIN_URI,
      {
        "email":email,
        "password":password,
      }
    );
  }

  Future<String> getUserToken()async{
    return sharedPreferences.getString(AppConstants.TOKEN)??'None';
  }

  bool userLoggedIn(){
    return  sharedPreferences.containsKey(AppConstants.TOKEN);
  }

  Future<bool> saveUserToken(String token) async {
    apiClient.token =token;
    apiClient.updateHeader(token);
    return await sharedPreferences.setString(AppConstants.TOKEN, token);
  }


 bool clearSharedData(){
    sharedPreferences.remove(AppConstants.TOKEN);
    sharedPreferences.remove(AppConstants.PHONE);
    sharedPreferences.remove(AppConstants.PASSWORD);
    apiClient.token="";
    apiClient.updateHeader('');
    return true;
 }


  Future<void> saveUserNumberAndPassword(String number,String password) async{
    try{
      await sharedPreferences.setString(AppConstants.PHONE, number);
      await sharedPreferences.setString(AppConstants.PASSWORD, password);
    }catch(e){
       throw e;
    }
  }
}