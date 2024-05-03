import 'package:shop_app/shared/components/const/app_constants.dart';
import 'package:shop_app/shared/network/remote/data/api/api_client.dart';
import 'package:get/get.dart';
class UserRepo{
  final ApiClient apiClient;
  UserRepo({required this.apiClient});

  Future<Response>getUserInfo()async{
  return await  apiClient.getData(
      AppConstants.USER_INFO_URI,
  );
  }
}