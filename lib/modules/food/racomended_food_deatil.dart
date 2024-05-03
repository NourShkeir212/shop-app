import 'package:flutter/material.dart';
import 'package:shop_app/shared/components/const/app_constants.dart';
import 'package:shop_app/shared/components/const/dimensions.dart';
import 'package:shop_app/shared/components/const/styles.dart';
import 'package:shop_app/shared/components/widgets/app_icon.dart';
import 'package:shop_app/shared/components/widgets/big_text.dart';
import 'package:shop_app/shared/components/widgets/expandebale_text.dart';
import 'package:shop_app/shared/components/widgets/small_text.dart';
import 'package:shop_app/shared/network/remote/controllers/cart_controller.dart';
import 'package:shop_app/shared/network/remote/controllers/popular_product_controllers.dart';
import 'package:shop_app/shared/network/remote/controllers/recommended_product_controller.dart';
import 'package:shop_app/shared/routes/route_helper.dart';
import 'package:get/get.dart';

class RecommendedFoodDetail extends StatelessWidget {
  final  int pageId;
  final  String page;
 const  RecommendedFoodDetail({Key? key,required this.pageId,required this.page}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var product =Get.find<RecommendedProductController>().recommendedProductList[pageId];
    Get.find<PopularProductController>().initProduct(product,Get.find<CartController>());
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          //image and name
          SliverAppBar(
            automaticallyImplyLeading: false,
            toolbarHeight: 70,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children:
              [
               GestureDetector(onTap: ()
               {
                 if(page=="cartPage"){
                   Get.toNamed(RouteHelper.getCartScreen());
                 }else{
                   Get.toNamed(RouteHelper.getInitial());
                 }
                 },
                 child: AppIcon(icon: Icons.clear)),
                 GetBuilder<PopularProductController>(builder: (controller){
                  return GestureDetector(
                    onTap: (){
                      if(controller.totalItems>=1)
                      Get.toNamed(RouteHelper.getCartScreen());
                    },
                    child: Stack(
                      children: [
                        AppIcon(icon: Icons.shopping_cart_outlined),
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
            ),
            bottom: PreferredSize(
                preferredSize: const Size.fromHeight(20),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(Dimensions.radius20),
                        topLeft: Radius.circular(Dimensions.radius20),
                      )
                  ),
                  child: Center(child: BigText(size: Dimensions.font26, text: product.name!)),
                  width: double.maxFinite,
                  padding: EdgeInsets.only(top: Dimensions.height10 / 2,
                      bottom: Dimensions.height10),
                )
            ),
            pinned: true,
            backgroundColor: AppColors.yellowColor,
            expandedHeight: 300,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                AppConstants.BASE_URL+AppConstants.UPLOAD_URL+product.img!,
                fit: BoxFit.cover,
                width: double.maxFinite,
              )
            ),
          ),
          // description
          SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(
                        left: Dimensions.width20, right: Dimensions.width20),
                    child: ExpandableTextWidget(
                    text: product.description!,
                  ),
                  )
                ],
              )
          ),
        ],
      ),
      bottomNavigationBar: GetBuilder<PopularProductController>(
        builder: (controller){
          return Column(
            mainAxisSize: MainAxisSize.min,
            children:
            [
              Container(
                padding: EdgeInsets.only(
                  left: Dimensions.width20 * 2.5,
                  right: Dimensions.width20 * 2.5,
                  top: Dimensions.height10,
                  bottom: Dimensions.height10,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // -
                    GestureDetector(
                      onTap: (){
                        controller.setQuantity(false);
                      },
                      child: AppIcon(
                        iconSize: Dimensions.iconSize24,
                        iconColor: Colors.white,
                        icon: Icons.remove,
                        backGroundColor: AppColors.mainColor,
                      ),
                    ),
                    // price
                    BigText(
                      text: "\$ ${product.price}  X  ${controller.inCartItems.toString()} ",
                      color: AppColors.mainBlackColor,
                      size: Dimensions.font26,
                    ),
                    // +
                    GestureDetector(
                      onTap: (){
                        controller.setQuantity(true);
                      },
                      child: AppIcon(
                        iconSize: Dimensions.iconSize24,
                        iconColor: Colors.white,
                        icon: Icons.add,
                        backGroundColor: AppColors.mainColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container (
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
                      topRight: Radius.circular(Dimensions.radius20 * 2,),
                      topLeft: Radius.circular(Dimensions.radius20 * 2,)
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children:
                  [
                    //favorite
                    Container(
                        padding: EdgeInsets.only(
                            top: Dimensions.height20,
                            bottom: Dimensions.height20,
                            left: Dimensions.width30,
                            right: Dimensions.width30
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(Dimensions.radius20),
                          color: Colors.white,
                        ),
                        child:const Icon(
                          Icons.favorite, color: AppColors.mainColor,
                        )
                    ),
                    //add to cart
                    GestureDetector(
                      onTap: (){
                          controller.addItem(product);
                        },
                      child:  Container(
                        padding: EdgeInsets.only(
                            top: Dimensions.height20,
                            bottom: Dimensions.height20,
                            right: Dimensions.width20,
                            left: Dimensions.width20
                        ),
                        child: BigText(
                          text: "\$ ${product.price!} | Add to cart", color: Colors.white,),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              Dimensions.radius20,
                            ),
                            color: AppColors.mainColor
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}