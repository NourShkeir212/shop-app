import 'package:flutter/material.dart';
import 'package:shop_app/modules/home/food_page_body.dart';
import 'package:shop_app/shared/components/widgets/big_text.dart';
import 'package:shop_app/shared/components/widgets/small_text.dart';
import 'package:shop_app/shared/components/const/dimensions.dart';
import 'package:shop_app/shared/components/const/styles.dart';


class LayoutScreen extends StatelessWidget {
  const LayoutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            margin:  EdgeInsets.only(top: Dimensions.height45,bottom: Dimensions.height15),
            padding:  EdgeInsets.only(left: Dimensions.width20,right: Dimensions.width20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children:
              [
                Column(
                  children:
                  [
                    BigText(text: 'Syria',color: AppColors.mainColor),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:
                      [
                         SmallText(text: 'Damascus',color: Colors.black54,),
                         Icon(Icons.arrow_drop_down_rounded,size: Dimensions.iconSize24,)
                      ],
                    )
                  ],
                ),
                Center(
                  child: Container(
                    width: Dimensions.height45,
                    height: Dimensions.height45,
                    child: const Icon(
                      Icons.search,color: Colors.white,
                    ),
                    decoration: BoxDecoration(
                     color: AppColors.mainColor,
                     borderRadius: BorderRadius.circular(Dimensions.radius15),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Expanded(
            child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: FoodPageBody(),),
          )
        ],
      )
    );
  }
}