import 'package:flutter/material.dart';
import 'package:shop_app/shared/components/const/app_constants.dart';
import 'package:shop_app/shared/components/const/dimensions.dart';
import 'package:shop_app/shared/components/const/styles.dart';
import 'package:shop_app/shared/components/widgets/app_column.dart';
import 'package:shop_app/shared/components/widgets/app_icon.dart';
import 'package:shop_app/shared/components/widgets/big_text.dart';
import 'package:shop_app/shared/components/widgets/expandebale_text.dart';
import 'package:shop_app/shared/components/widgets/small_text.dart';
import 'package:shop_app/shared/network/remote/controllers/cart_controller.dart';
import 'package:shop_app/shared/network/remote/controllers/popular_product_controllers.dart';
import 'package:shop_app/shared/routes/route_helper.dart';
import 'package:get/get.dart';

class PopularFoodDetail extends StatelessWidget {
 final int pageId;
 final String page;
 const  PopularFoodDetail({Key? key,required this.pageId,required this.page}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   var product= Get.find<PopularProductController>().popularProductList[pageId];
   Get.find<PopularProductController>().initProduct(product,Get.find<CartController>());
   print(product.name);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children:
        [
          //backGroundImage
          Positioned(
            left: 0,
            right: 0,
            child: Container(
              width: double.maxFinite,
              height: Dimensions.popularFoodImgSize,
              decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image:NetworkImage(AppConstants.BASE_URL+AppConstants.UPLOAD_URL+product.img!
                    ),
                ),
              ),
            ),
          ),
          //iconWidget
          Positioned(
              top: Dimensions.height45,
              left: Dimensions.width20,
              right: Dimensions.width20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                      onTap: ()
                      {
                        if(page=="cartPage"){
                          Get.toNamed(RouteHelper.getCartScreen());
                        }else{
                          Get.toNamed(RouteHelper.getInitial());
                        }
                      },
                      child: AppIcon(icon: Icons.arrow_back_ios)),
                 GetBuilder<PopularProductController>(builder: (controller){
                   return GestureDetector(
                     onTap: (){
                       if(controller.totalItems>=1)
                       Get.toNamed(RouteHelper.getCartScreen());
                     },
                     child: Stack(
                       children: [
                         AppIcon(
                             icon: Icons.shopping_cart_outlined,
                         ),
                         Get.find<PopularProductController>().totalItems>=1?
                         Positioned(
                           top: 0,right: 0,
                           child: CircleAvatar(
                             backgroundColor: AppColors.mainColor,
                             radius: 10,
                             child: SmallText(text: Get.find<PopularProductController>().totalItems.toString(),color: Colors.white,),
                           ),
                         ):AppIcon(icon: Icons.shopping_cart_outlined),
                       ],
                     ),
                   );
                 }),
                ],
              )
          ),
          //Introduction of food
          Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              top: Dimensions.popularFoodImgSize-20,
              child: Container(
                padding: EdgeInsets.only(
                    left: Dimensions.width20,
                    right: Dimensions.width20,
                    top: Dimensions.width20,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight:Radius.circular(Dimensions.radius20),
                      topLeft:Radius.circular(Dimensions.radius20),
                  ),
                  color: Colors.white
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppColumn(text: product.name!,starsCount: 5,rate: 5,),
                    SizedBox(height: Dimensions.height20,),
                    BigText(text: 'Introduce'),
                    SizedBox(height: Dimensions.height20,),
                    Expanded(
                        child: SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        child: ExpandableTextWidget(text: product.description!,)))
                  ],
                ),
              ),
          ),
        ],
      ),
      bottomNavigationBar: GetBuilder<PopularProductController>(
        builder: (popularProduct){
          return Container(
            height: Dimensions.bottomHieghtBar,
            padding: EdgeInsets.only(
                top: Dimensions.height20,
                bottom: Dimensions.height20,
                right: Dimensions.width20,
                left: Dimensions.width20
            ),
            decoration: BoxDecoration(
              color: AppColors.buttonBackgroundColor,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(Dimensions.radius20*2,),
                  topLeft: Radius.circular(Dimensions.radius20*2,)
              ),

            ),
            child: Row(
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
                  child: Row(
                    children: [
                      GestureDetector(
                          onTap: (){
                            popularProduct.setQuantity(false);
                          },
                          child: const Icon(Icons.remove,color: AppColors.signColor,)),
                      SizedBox(width: Dimensions.width10/2,),
                      BigText(text: popularProduct.inCartItems.toString()),
                      SizedBox(width: Dimensions.width10/2,),
                      GestureDetector(
                          onTap: (){
                           popularProduct.setQuantity(true);
                          },
                          child: const Icon(Icons.add,color: AppColors.signColor,))
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    popularProduct.addItem(product);
                  },
                  child: Container(
                    padding: EdgeInsets.only(
                        top: Dimensions.height20,
                        bottom: Dimensions.height20,
                        right: Dimensions.width20,
                        left: Dimensions.width20
                    ),
                    child: BigText(text:"\$${product.price!} | Add to cart",color: Colors.white,),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Dimensions.radius20),
                        color: AppColors.mainColor
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

