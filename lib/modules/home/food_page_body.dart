import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/model/product_model.dart';
import 'package:shop_app/modules/food/popular_food_deatil.dart';
import 'package:shop_app/modules/food/racomended_food_deatil.dart';
import 'package:shop_app/shared/components/const/app_constants.dart';
import 'package:shop_app/shared/components/widgets/app_column.dart';
import 'package:shop_app/shared/components/widgets/big_text.dart';
import 'package:shop_app/shared/components/widgets/routes.dart';
import 'package:shop_app/shared/components/widgets/small_text_recommended.dart';
import 'package:shop_app/shared/components/widgets/text_with_icon.dart';
import 'package:shop_app/shared/components/const/dimensions.dart';
import 'package:shop_app/shared/components/const/styles.dart';
import 'package:shop_app/shared/components/widgets/small_text.dart';
import 'package:shop_app/shared/network/remote/controllers/popular_product_controllers.dart';
import 'package:shop_app/shared/network/remote/controllers/recommended_product_controller.dart';
import 'package:shop_app/shared/routes/route_helper.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

class FoodPageBody extends StatefulWidget {
  const FoodPageBody({Key? key}) : super(key: key);

  @override
  State<FoodPageBody> createState() => _FoodPageBodyState();
}

class _FoodPageBodyState extends State<FoodPageBody> {
  PageController controller = PageController(viewportFraction: 0.90);
  var _currPageValue = 0.0;
  double _scaleFactor = 0.8;
  double _hieght = Dimensions.pageViewContainer;

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      setState(() {
        _currPageValue = controller.page!;
      });
    });
  }
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children:
      [
        //Slider section
        GetBuilder<PopularProductController>(
         builder: (popularProduct){
           return  popularProduct.isLoaded ? Container(
             height: Dimensions.pageView,
             child: PageView.builder(
                 physics:const BouncingScrollPhysics(),
                 controller: controller,
                 itemCount: popularProduct.popularProductList.isEmpty?1:popularProduct.popularProductList.length,
                 itemBuilder: (context, index) {
                   return _buildPageItem(index,popularProduct.popularProductList[index]);
                 }),
           ) : const Center(child: CircularProgressIndicator(color: AppColors.mainColor,));
         },
        ),
        //dots
        GetBuilder<PopularProductController>(
          builder: (popularProduct) {
            return  DotsIndicator(
              dotsCount: popularProduct.popularProductList.isEmpty?1:popularProduct.popularProductList.length,
              position: _currPageValue,
              decorator: DotsDecorator(
                activeColor: AppColors.mainColor,
                size: const Size.square(9.0),
                activeSize: const Size(18.0, 9.0),
                activeShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
            );
          },
        ),
        //Populer text
        SizedBox(height: Dimensions.height30,),
        Container(
          margin: EdgeInsets.only(left: Dimensions.width30),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children:
            [
              BigText(text: 'Recommended'),
              SizedBox(width: Dimensions.width10,),
              Container(
                margin: const EdgeInsets.only(bottom: 3),
                child: BigText(text: '.', color: Colors.black26,),
              ),
              SizedBox(width: Dimensions.width10,),
              Container(
                margin: const EdgeInsets.only(bottom: 2),
                child: SmallText(text: 'Food pairing',),
              )
            ],
          ),
        ),
        // list of food and images
        GetBuilder<RecommendedProductController>(builder: (recommendedProduct){
          return recommendedProduct.isLoaded? ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: recommendedProduct.recommendedProductList.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: (){
                   Get.toNamed(RouteHelper.getRecommendedFood(index,"home"));
                  },
                  child: Container(
                    margin: EdgeInsets.only(
                        left: Dimensions.width20,
                        right: Dimensions.width20,
                        bottom: Dimensions.height10),
                    child: Row(
                      children:
                      [
                        //image section
                        Container(
                          width: Dimensions.listViewImgSize,
                          height: Dimensions.listViewImgSize,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                  Dimensions.radius20
                              ),
                              color: Colors.white30,
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                    image: NetworkImage(
                                       AppConstants.BASE_URL+AppConstants.UPLOAD_URL+recommendedProduct.recommendedProductList[index].img!
                              ),
                              )
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: Dimensions.listViewTextContainer,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(Dimensions.radius20),
                                    bottomRight: Radius.circular(
                                        Dimensions.radius20)
                                ),
                                color: Colors.white
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(left: Dimensions.width10,
                                  right: Dimensions.width10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  BigText(text: recommendedProduct.recommendedProductList[index].name!),
                                  SizedBox(height: Dimensions.height10,),
                                  SmallTextRecommended(text: recommendedProduct.recommendedProductList[index].description!,),
                                  SizedBox(height: Dimensions.height10,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment
                                        .spaceBetween,
                                    children:
                                    const [
                                      TextWithIconWidget(
                                        icon: Icons.circle_sharp,
                                        text: 'Normal',
                                        iconColor: AppColors.iconColor1,
                                      ),
                                      TextWithIconWidget(
                                        icon: Icons.location_on,
                                        text: '1.7km',
                                        iconColor: AppColors.mainColor,
                                      ),
                                      TextWithIconWidget(
                                        icon: Icons.access_time_outlined,
                                        text: '32min',
                                        iconColor: AppColors.iconColor2,
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        //text container
                      ],
                    ),
                  ),
                );
              }):Center(child: const CircularProgressIndicator(color: AppColors.mainColor,));
        }),
      ],
    );
  }
  Widget _buildPageItem(int index, ProductModel popularProduct) {
    Matrix4 matrix = new Matrix4.identity();
    if (index == _currPageValue.floor()) {
      var currScale = 1 - (_currPageValue - index) * (1 - _scaleFactor);
      var currTrans = _hieght * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currPageValue.floor() + 1) {
      var currScale = _scaleFactor +
          (_currPageValue - index + 1) * (1 - _scaleFactor);
      var currTrans = _hieght * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1);
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currPageValue.floor() - 1) {
      var currScale = 1 - (_currPageValue - index) * (1 - _scaleFactor);
      var currTrans = _hieght * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else {
      var currScale = 0.8;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, _hieght * (1 - _scaleFactor) / 2, 1);
    }
    return GestureDetector(
      onTap: () {
        Get.toNamed(RouteHelper.getPopularFood(index,'home'));
        },
      child: Transform(
        transform: matrix,
        child: Stack(
          children: [
            Container(
              height: Dimensions.pageViewContainer,
              margin: EdgeInsets.only(
                  left: Dimensions.width10, right: Dimensions.width10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius30),
                  color: index.isEven ? const Color(0xFF69c5df) : const Color(
                      0xFF9294cc),
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                          AppConstants.BASE_URL+AppConstants.UPLOAD_URL+popularProduct.img!
                      ),
                  )
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: Dimensions.pageViewTextContainer,
                margin: EdgeInsets.only(left: Dimensions.width40,
                    right: Dimensions.width40,
                    bottom: Dimensions.height30),
                decoration: BoxDecoration(
                    boxShadow:
                    const [
                      BoxShadow(
                          color: Color(0xFFe8e8e8),
                          blurRadius: 5.0,
                          offset: Offset(0, 5)
                      ),
                      BoxShadow(
                          color: Colors.white,
                          blurRadius: 5.0,
                          offset: Offset(-5, 0)
                      ),
                      BoxShadow(
                          color: Colors.white,
                          blurRadius: 5.0,
                          offset: Offset(5, 0)
                      ),
                    ],
                    borderRadius: BorderRadius.circular(Dimensions.radius20),
                    color: Colors.white
                ),
                child: Container(
                  padding: EdgeInsets.only(
                      top: Dimensions.height10, left: 15, right: 15),
                  child: AppColumn(text: popularProduct.name!,starsCount: popularProduct.stars!,rate:popularProduct.stars! ,)
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}