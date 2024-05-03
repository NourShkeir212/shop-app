import 'package:flutter/material.dart';
import 'package:shop_app/shared/network/remote/controllers/cart_controller.dart';
import 'package:shop_app/shared/network/remote/controllers/popular_product_controllers.dart';
import 'package:shop_app/shared/network/remote/controllers/recommended_product_controller.dart';
import 'package:shop_app/shared/routes/route_helper.dart';
import 'package:get/get.dart';
import 'package:shop_app/shared/network/remote/helper/dependencies.dart' as dep;
void main()async
{
  WidgetsFlutterBinding.ensureInitialized();
  await dep.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Get.find<CartController>().getCartData();
    return GetBuilder<PopularProductController>(
      builder: (_) {
       return GetBuilder<RecommendedProductController>(
          builder: (_){
            return GetMaterialApp(
              initialRoute: RouteHelper.getSplashScreen(),
              getPages: RouteHelper.routes,
              debugShowCheckedModeBanner: false,
              // home: SignInScreen(),
              );
          },
        );
      }
    );
  }
}