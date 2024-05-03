import 'package:flutter/material.dart';
import 'package:shop_app/base/custom_loader.dart';
import 'package:shop_app/shared/components/const/dimensions.dart';
import 'package:shop_app/shared/components/const/styles.dart';
import 'package:shop_app/shared/components/widgets/account_widget.dart';
import 'package:shop_app/shared/components/widgets/app_icon.dart';
import 'package:shop_app/shared/components/widgets/big_text.dart';
import 'package:shop_app/shared/network/remote/controllers/auth_controller.dart';
import 'package:shop_app/shared/network/remote/controllers/cart_controller.dart';
import 'package:shop_app/shared/network/remote/controllers/user_controller.dart';
import 'package:shop_app/shared/routes/route_helper.dart';
import 'package:get/get.dart';

import '../../base/show_custom_snackbar.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool _userLoggedIn=Get.find<AuthController>().userLoggedIn();
    if(_userLoggedIn){
      Get.find<UserController>().getUserInfo();
      print('User has Logged In');
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        centerTitle: true,
        title: BigText(
          text: 'Profile',
          size: Dimensions.font12*2,
          color: Colors.white,
        ),
      ),
      body: GetBuilder<UserController>(
        builder: (userController){
          return _userLoggedIn?
          (userController.isLoading)?
          Container(
            width: double.maxFinite,
            margin: EdgeInsets.only(top: Dimensions.height20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //ProfileIcon
                AppIcon(
                  icon: Icons.person,
                  backGroundColor: AppColors.mainColor,
                  iconColor: Colors.white,
                  iconSize: Dimensions.height30+Dimensions.height45,
                  size: Dimensions.height15*10,
                ),
                SizedBox(height: Dimensions.height30,),
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        //Name
                        AccountWidget(
                          bigText: BigText(
                            text: userController.userModel!.name,
                          ),
                          appIcon: AppIcon(
                            icon: Icons.person,
                            backGroundColor: AppColors.mainColor,
                            iconColor: Colors.white,
                            iconSize: Dimensions.height10*5/2,
                            size: Dimensions.height10*5,
                          ),
                        ),
                        SizedBox(height: Dimensions.height20,),
                        //Phone
                        AccountWidget(
                          bigText: BigText(
                            text: userController.userModel!.phone,
                          ),
                          appIcon: AppIcon(
                            icon: Icons.phone,
                            backGroundColor: AppColors.yellowColor,
                            iconColor: Colors.white,
                            iconSize: Dimensions.height10*5/2,
                            size: Dimensions.height10*5,
                          ),
                        ),
                        SizedBox(height: Dimensions.height20,),
                        //email
                        AccountWidget(
                          bigText: BigText(
                            text: userController.userModel!.email,
                          ),
                          appIcon: AppIcon(
                            icon: Icons.email,
                            backGroundColor: AppColors.yellowColor,
                            iconColor: Colors.white,
                            iconSize: Dimensions.height10*5/2,
                            size: Dimensions.height10*5,
                          ),
                        ),
                        SizedBox(height: Dimensions.height20,),
                        //address
                        AccountWidget(
                          bigText: BigText(
                            text: "Fill in your address",
                          ),
                          appIcon: AppIcon(
                            icon: Icons.location_on,
                            backGroundColor: AppColors.yellowColor,
                            iconColor: Colors.white,
                            iconSize: Dimensions.height10*5/2,
                            size: Dimensions.height10*5,
                          ),
                        ),
                        SizedBox(height: Dimensions.height20,),
                        //message
                        AccountWidget(
                          bigText: BigText(
                            text: "Messages",
                          ),
                          appIcon: AppIcon(
                            icon: Icons.message_outlined,
                            backGroundColor: Colors.redAccent,
                            iconColor: Colors.white,
                            iconSize: Dimensions.height10*5/2,
                            size: Dimensions.height10*5,
                          ),
                        ),
                        SizedBox(height: Dimensions.height20,),
                        //message
                        GestureDetector(
                          onTap: (){
                            if(Get.find<AuthController>().userLoggedIn()){
                              Get.find<AuthController>().clearData();
                              Get.find<CartController>().clear();
                              Get.find<CartController>().clearCartHistory();
                              Get.offNamed(RouteHelper.getSignInScreen());
                            }else{
                              showCustomSnackBar('You already logged out',title: 'Error');
                            }
                          },
                          child: AccountWidget(
                            bigText: BigText(
                              text: "Logout",
                            ),
                            appIcon: AppIcon(
                              icon: Icons.logout,
                              backGroundColor: Colors.redAccent,
                              iconColor: Colors.white,
                              iconSize: Dimensions.height10*5/2,
                              size: Dimensions.height10*5,
                            ),
                          ),
                        ),
                        SizedBox(height: Dimensions.height20,),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ):
          const CustomLoader():
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: double.maxFinite,
                  height: Dimensions.height20*9,
                  margin: EdgeInsets.only(
                    left: Dimensions.width20,
                    right: Dimensions.width20
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radius20),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(
                        'assets/image/signintocontinue.png'
                      )
                    )
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    Get.toNamed(RouteHelper.getSignInScreen());
                  },
                  child: Container(
                    width: double.maxFinite,
                    height: Dimensions.height20*5,
                    margin: EdgeInsets.only(
                        left: Dimensions.width20,
                        right: Dimensions.width20
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.mainColor,
                        borderRadius: BorderRadius.circular(Dimensions.radius20),
                    ),
                    child: Center(
                        child: BigText(
                          text: 'Sign in',
                          color: Colors.white,
                          size: Dimensions.font26,
                        )
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
