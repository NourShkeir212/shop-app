import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shop_app/base/no_data_page.dart';
import 'package:shop_app/shared/components/const/app_constants.dart';
import 'package:shop_app/shared/components/const/dimensions.dart';
import 'package:shop_app/shared/components/const/styles.dart';
import 'package:shop_app/shared/components/widgets/app_icon.dart';
import 'package:shop_app/shared/components/widgets/big_text.dart';
import 'package:shop_app/shared/components/widgets/small_text.dart';
import 'package:shop_app/shared/network/remote/controllers/cart_controller.dart';
import 'package:shop_app/shared/routes/route_helper.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../model/cart_model.dart';

class CartHistoryScreen extends StatelessWidget {
  const CartHistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var getCartHistoryList =
        Get.find<CartController>().getCartHistoryList().reversed.toList();

    Map<String, int> cartItemsPerOrder = {};

    for (int i = 0; i < getCartHistoryList.length; i++) {
      if (cartItemsPerOrder.containsKey(getCartHistoryList[i].time)) {
        cartItemsPerOrder.update(
            getCartHistoryList[i].time!, (value) => ++value);
      } else {
        cartItemsPerOrder.putIfAbsent(getCartHistoryList[i].time!, () => 1);
      }
    }

    List<int> cartItemPerOrderToList() {
      return cartItemsPerOrder.entries.map((e) => e.value).toList();
    }

    List<String> cartOrderTimeToList() {
      return cartItemsPerOrder.entries.map((e) => e.key).toList();
    }

    List<int> itemPerOrder = cartItemPerOrderToList();

    var listCounter = 0;
  Widget timeWidget(int index){
    var outputDate =DateTime.now().toString();
    if(index<getCartHistoryList.length){
      DateTime parseDate = DateFormat('yyyy-MM-dd HH:mm:ss').parse(getCartHistoryList[listCounter].time!);
      var inputDate =DateTime.parse(parseDate.toString());
      var outputFormat= DateFormat("MM/dd/yyyy hh:mm a");
      outputDate=outputFormat.format(inputDate);
    }
     return BigText(text: outputDate);
   }
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: Dimensions.height10 * 10,
            color: AppColors.mainColor,
            width: double.maxFinite,
            padding: EdgeInsets.only(top: Dimensions.height45),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                BigText(
                  text: 'Your Cart History',
                  color: Colors.white,
                ),
                AppIcon(
                  icon: Icons.shopping_cart_outlined,
                  iconColor: AppColors.mainColor,
                ),
              ],
            ),
          ),
          GetBuilder<CartController>(builder: (_cartController){
            return _cartController.getCartHistoryList().isNotEmpty?
            Expanded(
              child: Container(
                margin: EdgeInsets.only(
                    top: Dimensions.height20,
                    left: Dimensions.width20,
                    right: Dimensions.width20),
                child: MediaQuery.removePadding(
                  removeTop: true,
                  context: context,
                  child: ListView(
                    physics: const BouncingScrollPhysics(),
                    children: [
                      for (int i = 0; i < cartItemsPerOrder.length; i++)
                        Container(
                          height: Dimensions.height20 * 7,
                          margin:
                          EdgeInsets.only(bottom: Dimensions.height10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              timeWidget(listCounter),
                              SizedBox(
                                height: Dimensions.height10,
                              ),
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Wrap(
                                    direction: Axis.horizontal,
                                    children: List.generate(itemPerOrder[i],
                                            (index) {
                                          if (listCounter <
                                              getCartHistoryList.length) {
                                            listCounter++;
                                          }
                                          return index <= 2
                                              ? Container(
                                            height:
                                            Dimensions.height20 * 4,
                                            width:
                                            Dimensions.height20 * 4,
                                            margin: EdgeInsets.only(
                                                right:
                                                Dimensions.width10 /
                                                    2),
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius
                                                    .circular(Dimensions
                                                    .radius15 /
                                                    2),
                                                image: DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image: NetworkImage(AppConstants
                                                        .BASE_URL +
                                                        AppConstants
                                                            .UPLOAD_URL +
                                                        getCartHistoryList[
                                                        listCounter -
                                                            1]
                                                            .img!))),
                                          )
                                              : Container();
                                        }),
                                  ),
                                  Container(
                                    height: Dimensions.height20 * 4,
                                    child: Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.end,
                                      children: [
                                        SmallText(
                                          text: 'Total',
                                          color: AppColors.titleColor,
                                        ),
                                        BigText(
                                          text: itemPerOrder[i].toString() +
                                              " Items",
                                          color: AppColors.titleColor,
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            var orderTime =
                                            cartOrderTimeToList();
                                            Map<int, CartModel> moreOrder =
                                            {};
                                            for (int j = 0; j < getCartHistoryList.length; j++) {
                                              if (getCartHistoryList[j].time == orderTime[i]) {
                                                moreOrder.putIfAbsent(getCartHistoryList[j].id!, () =>
                                                    CartModel.fromJson(
                                                      jsonDecode(jsonEncode(getCartHistoryList[j])
                                                      ),
                                                    ),
                                                );
                                              }
                                            }
                                            Get.find<CartController>().setItems = moreOrder;
                                            Get.find<CartController>().addToCartList();
                                            Get.toNamed(RouteHelper.getCartScreen());
                                          },
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal:
                                                Dimensions.width10,
                                                vertical:
                                                Dimensions.height10 /
                                                    2),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                              BorderRadius.circular(
                                                  Dimensions.radius15 /
                                                      3),
                                              border: Border.all(
                                                width: 1,
                                                color: AppColors.mainColor,
                                              ),
                                            ),
                                            child: SmallText(
                                              text: "one more",
                                              color: AppColors.mainColor,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                    ],
                  ),
                ),
              ),
            ):
            SizedBox(
              height: MediaQuery.of(context).size.height/1.5,
              child: const Center(
                child: NoDataPage(
                  text: "You didn't buy anything so far !",
                  imgPath: 'assets/image/empty_box.png',
                ),
              ),
            );
          })
        ],
      ),
    );
  }
}
