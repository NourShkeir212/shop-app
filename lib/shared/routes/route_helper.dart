import 'package:shop_app/modules/address/add_address_screen.dart';
import 'package:shop_app/modules/auth/sign_up/sign_up_screen.dart';
import 'package:shop_app/modules/cart/cart_screen.dart';
import 'package:shop_app/modules/food/popular_food_deatil.dart';
import 'package:shop_app/modules/food/racomended_food_deatil.dart';
import 'package:shop_app/modules/home/home_page.dart';
import 'package:shop_app/modules/pdf/pdf_screen.dart';
import 'package:shop_app/modules/splash/splash_screen.dart';
import 'package:get/get.dart';

import '../../modules/auth/sign_in/sign_in_screen.dart';

class RouteHelper{
  static const String splashScreen='/splash-screen';
  static const String initial ='/';
  static const String popularFood="/popular-food";
  static const String recommendedFood="/recommended-food";
  static const String cartScreen="/cart-screen";
  static const String signInScreen="/sign-in";
  static const String signUpScreen="/signUp-screen";
  static const String pdfScreen="/pdf-screen";

  static const String addAddressScreen="/add-address";

  static String getInitial()=>'$initial';
  static String getPdfScreen()=>'$pdfScreen';
  static String getSplashScreen()=>'$splashScreen';
  static String getPopularFood(int pageId,String page)=>'$popularFood?pageId=$pageId&page=$page';
  static String getRecommendedFood(int pageId,String page)=>'$recommendedFood?pageId=$pageId&page=$page';
  static String getCartScreen()=>'$cartScreen';
  static String getSignInScreen()=>'$signInScreen';
  static String getAddressScreen()=>'$addAddressScreen';

  static  List<GetPage> routes=[
    GetPage(
        name: splashScreen,
        page: (){
          return const SplashScreen();
        },
        transition: Transition.fadeIn
    ),
    GetPage(
      name: initial,
      page: ()=>HomeScreen(),
    ),
    GetPage(
      name: popularFood,
      page: (){
        var pageId =Get.parameters['pageId'];
        var page =Get.parameters['page'];
       return PopularFoodDetail(pageId: int.parse(pageId!),page:page!);
        },
      transition: Transition.fadeIn
    ),
    GetPage(
        name: recommendedFood,
        page: (){
          var pageId =Get.parameters['pageId'];
          var page =Get.parameters['page'];
          return RecommendedFoodDetail(pageId: int.parse(pageId!),page: page!,);
        },
      transition: Transition.fadeIn
    ),
    GetPage(
        name: cartScreen,
        page: (){
          return const CartScreen();
        },
        transition: Transition.fadeIn
    ),
    GetPage(
        name: signInScreen,
        page: (){
          return const SignInScreen();
        },
        transition: Transition.fadeIn
    ),
    // GetPage(
    //     name: addAddressScreen,
    //     page: (){
    //       return const AddAddressScreen();
    //     },
    //     transition: Transition.fadeIn
    // ),
    GetPage(
        name: pdfScreen,
        page: (){
          return  PdfScreen();
        },
        transition: Transition.fadeIn
    ),

  ];

}