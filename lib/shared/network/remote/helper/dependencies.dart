
import 'package:shop_app/shared/components/const/app_constants.dart';
import 'package:shop_app/shared/network/remote/controllers/auth_controller.dart';
import 'package:shop_app/shared/network/remote/controllers/cart_controller.dart';
import 'package:shop_app/shared/network/remote/controllers/location_controller.dart';
import 'package:shop_app/shared/network/remote/controllers/popular_product_controllers.dart';
import 'package:shop_app/shared/network/remote/controllers/recommended_product_controller.dart';
import 'package:shop_app/shared/network/remote/data/api/api_client.dart';
import 'package:shop_app/shared/network/remote/data/repository/auth_repo.dart';
import 'package:shop_app/shared/network/remote/data/repository/cart_repo.dart';
import 'package:shop_app/shared/network/remote/data/repository/location_repo.dart';
import 'package:shop_app/shared/network/remote/data/repository/popular_product_repo.dart';
import 'package:shop_app/shared/network/remote/data/repository/recommended_repo.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controllers/user_controller.dart';
import '../data/repository/user_repo.dart';

Future<void> init()async
{
final sharedPreferences =await SharedPreferences.getInstance();


 Get.lazyPut(() => sharedPreferences);
//api client
 Get.lazyPut(()=>ApiClient(appBaseUrl: AppConstants.BASE_URL,sharedPreferences:Get.find()));
 Get.lazyPut(()=>AuthRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
 Get.lazyPut(()=>UserRepo(apiClient: Get.find()));
 //repos
 Get.lazyPut(()=>PopularProductRepo(apiClient: Get.find()));
 Get.lazyPut(()=>RecommendedProductRepo(apiClient: Get.find()));
 Get.lazyPut(()=>CartRepo(sharedPreferences:Get.find()));
 //Get.lazyPut(()=>LocationRepo(apiClient: Get.find(), sharedPreferences: Get.find()));

 //controllers
 Get.lazyPut(()=>PopularProductController(popularProductRepo: Get.find()));
 Get.lazyPut(()=>RecommendedProductController(recommendedProductRepo: Get.find()));
 Get.lazyPut(()=>CartController(cartRepo: Get.find()));
 Get.lazyPut(()=>AuthController(authRepo: Get.find()));
 Get.lazyPut(()=>UserController(userRepo: Get.find()));
// Get.lazyPut(()=>LocationController(locationRepo: Get.find()));
}