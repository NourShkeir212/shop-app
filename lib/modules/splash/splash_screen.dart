import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shop_app/modules/home/home_page.dart';
import 'package:shop_app/shared/components/const/dimensions.dart';
import 'package:shop_app/shared/network/remote/controllers/auth_controller.dart';
import 'package:shop_app/shared/network/remote/controllers/popular_product_controllers.dart';
import 'package:shop_app/shared/network/remote/controllers/recommended_product_controller.dart';
import 'package:shop_app/shared/routes/route_helper.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

String page =RouteHelper.signInScreen;
class _SplashScreenState extends State<SplashScreen> {

 late Animation<double> animation;
 late AnimationController controller;

 _loadResource()async{
  await Get.find<PopularProductController>().getPopularProductList();
  await Get.find<RecommendedProductController>().getRecommendedProductList();
 }

 String whatPage(){
   if(Get.find<AuthController>().userLoggedIn()){
     return RouteHelper.getInitial();
   }else{
     return RouteHelper.getSignInScreen();
   }
 }
 @override
  void initState(){
    super.initState();
    _loadResource();
    Timer(
      const Duration(seconds: 3),
        ()=>Get.offNamed(whatPage())
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
              child: Image.asset(
                  'assets/image/logo part 1.png',
                  width: Dimensions.splashImg,
              )
          ),
          Center(
              child: Image.asset(
                  'assets/image/logo part 2.png',
                  width: Dimensions.splashImg
              )
          ),
        ],
      ),
    );
  }
}
