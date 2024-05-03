import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/base/custom_loader.dart';
import 'package:shop_app/model/sign_in_body_model.dart';
import 'package:shop_app/modules/auth/sign_up/sign_up_screen.dart';
import 'package:shop_app/shared/components/const/dimensions.dart';
import 'package:shop_app/shared/components/const/styles.dart';
import 'package:shop_app/shared/components/widgets/app_text_field.dart';
import 'package:shop_app/shared/components/widgets/big_text.dart';
import 'package:shop_app/shared/components/widgets/small_text.dart';
import 'package:shop_app/shared/routes/route_helper.dart';
import 'package:get/get.dart';

import '../../../base/show_custom_snackbar.dart';
import '../../../shared/network/remote/controllers/auth_controller.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController =TextEditingController();
    TextEditingController passwordController =TextEditingController();

    void _login(AuthController authController){
      String email =emailController.text.trim();
      String password =passwordController.text.trim();
      if(email.isEmpty&&password.isEmpty)
      {
        showCustomSnackBar("Type in your email & password",title: 'email address && Password');
      }
      else if(email.isEmpty){
        showCustomSnackBar("Type in your email",title: 'email address');

      }else if(password.isEmpty){
        showCustomSnackBar("Type in your password",title: 'Password');

      }else if(password.length<6){
        showCustomSnackBar("Password can not be less than six characters",title: 'Password');

      }else{
        authController.login(email,password).then((status){
          if(status.isSuccess){
            showCustomSnackBar("All went well",title: 'Perfect',color: AppColors.mainColor);
            Get.toNamed(RouteHelper.getInitial());
          }else{
            showCustomSnackBar(status.message);
          }
        });
      }
    }
    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<AuthController>(
        builder: (authController){
          return !authController.isLoading?SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                SizedBox(height: Dimensions.screenHeight*0.05,),
                //logo
                SizedBox(
                  height: Dimensions.screenHeight*0.25,
                  child: const Center(
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 80,
                      backgroundImage: AssetImage(
                          'assets/image/logo part 1.png'
                      ),
                    ),
                  ),
                ),
                //hello
                Container(
                  width: double.maxFinite,
                  margin: EdgeInsets.only(left: Dimensions.width20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:  [
                      Text(
                        'Hello',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: Dimensions.font20*3+Dimensions.font20/2,
                        ),
                      ),
                      Text(
                        'Sign into your account',
                        style: TextStyle(
                            fontSize: Dimensions.font20,
                            color: Colors.grey[500]
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: Dimensions.height20,),
                //email
                AppTextField(
                    type: TextInputType.emailAddress,
                    controller: emailController,
                    text: 'email',
                    icon: Icons.email
                ),
                SizedBox(height: Dimensions.height20,),
                //password
                AppTextField(
                    isPassword: true,
                    type: TextInputType.visiblePassword,
                    controller: passwordController,
                    text: 'Password',
                    icon: Icons.password_sharp
                ),
                SizedBox(height: Dimensions.height10,),
                //tag line
                Row(
                  children: [
                    Expanded(child: Container()),
                    RichText(
                      text: TextSpan(
                        text: 'Sign into your account',
                        style: TextStyle(
                            color: Colors.grey[500],
                            fontSize: Dimensions.font20
                        ),
                      ),
                    ),
                    SizedBox(width: Dimensions.height20+Dimensions.height5,)
                  ],
                ),
                SizedBox(height: Dimensions.screenHeight*0.05,),
                //sign in button
                GestureDetector(
                  onTap: (){
                    _login(authController);
                  },
                  child: Container(
                    width: Dimensions.screenWidth/2,
                    height: Dimensions.screenHeight/13,
                    decoration: BoxDecoration(
                      color: AppColors.mainColor,
                      borderRadius: BorderRadius.circular(Dimensions.radius30),
                    ),
                    child: Center(
                      child: BigText(
                        text: 'Sign in',
                        size: Dimensions.font20+Dimensions.font20/2,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: Dimensions.screenHeight*0.05,),
                // signup options
                RichText(
                  text: TextSpan(
                      text: 'Don\' have an account?',
                      style: TextStyle(
                          color: Colors.grey[500],
                          fontSize: Dimensions.font20
                      ),
                      children:[
                        TextSpan(
                          recognizer: TapGestureRecognizer()..onTap=()=>Get.to(()=>const SignUpScreen(),transition: Transition.fade),
                          text: ' Create',
                          style: TextStyle(
                              color:Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: Dimensions.font20
                          ),
                        ),
                      ]
                  ),
                ),
                SizedBox(height: Dimensions.height20,),
                GestureDetector(
                  onTap: (){
                    Get.offNamed(RouteHelper.getInitial());
                  },
                    child: SmallText(
                      text: 'Continue with out signIn',
                      size: 16,
                      color: Colors.black,
                    ),
                ),
              ],
            ),
          ):const CustomLoader();
        },
      ),
    );
  }
}
