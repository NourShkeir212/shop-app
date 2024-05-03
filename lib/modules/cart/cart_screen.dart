import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/base/no_data_page.dart';
import 'package:shop_app/shared/components/const/app_constants.dart';
import 'package:shop_app/shared/components/const/dimensions.dart';
import 'package:shop_app/shared/components/const/styles.dart';
import 'package:shop_app/shared/components/widgets/app_icon.dart';
import 'package:shop_app/shared/components/widgets/big_text.dart';
import 'package:shop_app/shared/components/widgets/small_text.dart';
import 'package:shop_app/shared/network/remote/controllers/auth_controller.dart';
import 'package:shop_app/shared/network/remote/controllers/cart_controller.dart';
import 'package:shop_app/shared/network/remote/controllers/location_controller.dart';
import 'package:shop_app/shared/network/remote/controllers/popular_product_controllers.dart';
import 'package:shop_app/shared/network/remote/controllers/recommended_product_controller.dart';
import 'package:shop_app/shared/routes/route_helper.dart';
import 'package:get/get.dart';

import '../../base/custom_dialog.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children:[
      //header
      Positioned(
        top: Dimensions.height20*3,
        left: Dimensions.width20,
        right: Dimensions.width20,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: ()
                {},
                child: AppIcon(
                  icon:Icons.arrow_back_ios,
                  iconColor: Colors.white,
                  backGroundColor: AppColors.mainColor,
                  iconSize: Dimensions.iconSize24,
                ),
              ),
              SizedBox(width: Dimensions.width20*5,),
              GestureDetector(
                onTap: (){
                  Get.toNamed(RouteHelper.initial);
                },
                child: AppIcon(
                  icon:Icons.home_outlined,
                  iconColor: Colors.white,
                  backGroundColor: AppColors.mainColor,
                  iconSize: Dimensions.iconSize24,
                ),
              ),
              AppIcon(
                icon:Icons.shopping_cart_outlined,
                iconColor: Colors.white,
                backGroundColor: AppColors.mainColor,
                iconSize: Dimensions.iconSize24,
              ),
            ],
          ),
      ),
      //body
      GetBuilder<CartController>(builder: (_cartController){
        return _cartController.getItems.isNotEmpty?Positioned(
          top: Dimensions.height20*5,
          left: Dimensions.width20,
          right: Dimensions.width20,
          bottom: 0,
          child: Container(
            margin: EdgeInsets.only(top: Dimensions.height15),
            //  color: Colors.red,
            child: MediaQuery.removePadding(
                context: context,
                removeTop: true,
                child: GetBuilder<CartController>(
                  builder: (cartController){
                    var _cartList =cartController.getItems;
                    return ListView.builder(
                      itemCount: _cartList.length,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context,index)
                      {
                        return Container(
                          margin: EdgeInsets.only(
                              left: Dimensions.width20,
                              right: Dimensions.width20,
                              bottom: Dimensions.height10
                          ),
                          child: Row(
                            children: [
                              //image
                              GestureDetector(
                                onTap: (){
                                  var popularIndex =Get.find<PopularProductController>()
                                      .popularProductList
                                      .indexOf(_cartList[index].product!);
                                  if(popularIndex>=0){
                                    Get.toNamed(RouteHelper.getPopularFood(popularIndex,'cartPage'),
                                    );
                                  }else{
                                    var recommendedIndex =Get.find<RecommendedProductController>()
                                        .recommendedProductList
                                        .indexOf(_cartList[index].product!);
                                    if(recommendedIndex<0){
                                      Get.snackbar(
                                          'History Product', 'Product review is not available for history product',
                                          colorText: Colors.white, backgroundColor: AppColors.iconColor2);
                                    }else{
                                      Get.toNamed(RouteHelper.getRecommendedFood(recommendedIndex,'cartPage'),
                                      );
                                    }
                                  }
                                },
                                child: Container(
                                  width: Dimensions.height20*5,
                                  height: Dimensions.height20*5,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        Dimensions.radius20
                                    ),
                                    color: Colors.white30,
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(
                                        AppConstants.BASE_URL+AppConstants.UPLOAD_URL+_cartList[index].img!,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: Dimensions.width15,
                              ),
                              // data
                              Expanded(
                                child: SizedBox(
                                  height: Dimensions.height20*5,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      //title
                                      BigText(
                                        text: _cartList[index].name!,
                                        color: Colors.black54,
                                      ),
                                      SmallText(text: 'Spicy'),
                                      // price and increase and decrease
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          BigText(text: "\$ ${cartController.getItems[index].price!}",color: Colors.redAccent,size: Dimensions.font20,),
                                          Row(
                                            children: [
                                              GestureDetector(
                                                onTap: (){
                                                  cartController.addItem(_cartList[index].product!, -1);
                                                  if (kDebugMode) {
                                                    print('being tapped');
                                                  }
                                                },
                                                child: const Icon(Icons.remove,color: AppColors.signColor,),
                                              ),
                                              SizedBox(width: Dimensions.width10/2,),
                                              BigText(text: "${_cartList[index].quantity}"),
                                              SizedBox(width: Dimensions.width10/2,),
                                              GestureDetector(
                                                onTap: (){
                                                  cartController.addItem(_cartList[index].product!, 1);
                                                  if (kDebugMode) {
                                                    print('being tapped');
                                                  }
                                                },
                                                child: const Icon(Icons.add,color: AppColors.signColor,),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        );
                      },
                    );
                  },
                )
            ),
          ),
        ):
        const NoDataPage(text: 'Your cart is empty!');
      })
    ],
      ),
      //bottom bar
      bottomNavigationBar:  GetBuilder<CartController>(
        builder: (controller){
          return Container(
            height: Dimensions.bottomHieghtBar,
            padding: EdgeInsets.only(
                top: Dimensions.height20,
                bottom: Dimensions.height20,
                right: Dimensions.width20,
                left: Dimensions.width20
            ),
            decoration: BoxDecoration(
              color:controller.getItems.isNotEmpty? AppColors.buttonBackgroundColor:Colors.transparent,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(Dimensions.radius20*2,),
                  topLeft: Radius.circular(Dimensions.radius20*2,)
              ),
            ),
            child: controller.getItems.isNotEmpty?Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children:
              [
                Container(
                    padding: EdgeInsets.only(
                        top: Dimensions.height20,
                        bottom: Dimensions.height20,
                        left: Dimensions.width20,
                        right: Dimensions.width20
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radius20),
                      color: Colors.white,
                    ),
                    child: BigText(text: '\$ ${controller.totalAmount}',color: Colors.black,size: Dimensions.font20,)
                ),
                GestureDetector(
                  onTap: (){
                    if(Get.find<AuthController>().userLoggedIn()){

                       // Get.toNamed(RouteHelper.getAddressScreen());
                        Get.toNamed(RouteHelper.getPdfScreen());

                    }
                    else{
                      AwesomeDialog(
                          context: context,
                          headerAnimationLoop: true,
                          dialogType: DialogType.INFO,
                          animType: AnimType.BOTTOMSLIDE,
                          title: 'Information',
                          btnOkText: 'Sign In',
                          btnOk:  MaterialButton(
                            color: AppColors.mainColor,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(Dimensions.radius20)
                            ),
                            onPressed: (){
                              Get.toNamed(RouteHelper.getSignInScreen());
                            },
                            child: Text('Sign in',style: TextStyle(color: Colors.white,fontSize: 17),),
                          ),
                          btnOkOnPress: (){
                            Get.toNamed(RouteHelper.getSignInScreen());
                          },
                          desc: 'Please sign in first to checkout',
                          btnCancelOnPress: () {})
                          .show();
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.only(
                        top: Dimensions.height20,
                        bottom: Dimensions.height20,
                        right: Dimensions.width20,
                        left: Dimensions.width20
                    ),
                    child: BigText(text:"Check out",color: Colors.white,),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Dimensions.radius20),
                        color: AppColors.mainColor
                    ),
                  ),
                ),
              ],
            ):Container(),
          );
        },
      ),
    );
  }
}
