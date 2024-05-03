import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/base/custom_loader.dart';
import 'package:shop_app/base/show_custom_snackbar.dart';
import 'package:shop_app/model/sign_up_body_model.dart';
import 'package:shop_app/shared/components/const/dimensions.dart';
import 'package:shop_app/shared/components/const/styles.dart';
import 'package:shop_app/shared/components/widgets/app_text_field.dart';
import 'package:shop_app/shared/components/widgets/big_text.dart';
import 'package:shop_app/shared/network/remote/controllers/auth_controller.dart';
import 'package:shop_app/shared/routes/route_helper.dart';
import 'package:get/get.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController =TextEditingController();
    TextEditingController passwordController =TextEditingController();
    TextEditingController nameController =TextEditingController();
    TextEditingController phoneController =TextEditingController();
    List<String> signUpImages = [
      't.png',
      'f.png',
      'g.png',
    ];
    void _registration(AuthController authController){
      String name =nameController.text.trim();
      String phone =phoneController.text.trim();
      String email =emailController.text.trim();
      String password =passwordController.text.trim();
      if(name.isEmpty){
        showCustomSnackBar("Type in your name",title: 'Name');

      }else if(phone.isEmpty){
        showCustomSnackBar("Type in your phone number",title: 'Phone number');

      } else if(email.isEmpty){
        showCustomSnackBar("Type in your email",title: 'Email address');

      }else if(password.isEmpty){
        showCustomSnackBar("Type in your password",title: 'Password');

      }else if(password.length<6){
        showCustomSnackBar("Password can not be less than six characters",title: 'Password');

      }else{

        SignUpBody signUpBody =SignUpBody(
            name: name,
            phone: phone,
            email: email,
            password: password,
        );
        authController.registration(signUpBody).then((status){
          if(status.isSuccess){
            showCustomSnackBar("All went well",title: 'Perfect',color: AppColors.mainColor);
            print('Success Registration');
            Get.offNamed(RouteHelper.initial);
          }else{
            showCustomSnackBar(status.message);
          }
        });
      }
    }
    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<AuthController>(
        builder: (_authController){
          return !_authController.isLoading?
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                SizedBox(height: Dimensions.screenHeight*0.05,),
                //app logo
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
                AppTextField(
                    type: TextInputType.emailAddress,
                    controller: emailController,
                    text: 'Email',
                    icon: Icons.email
                ),
                SizedBox(height: Dimensions.height20,),
                AppTextField(
                    isPassword: true,
                    type: TextInputType.visiblePassword,
                    controller: passwordController,
                    text: 'Password',
                    icon: Icons.password_sharp
                ),
                SizedBox(height: Dimensions.height20,),
                AppTextField(
                    type: TextInputType.name,
                    controller: nameController,
                    text: 'Name',
                    icon: Icons.person
                ),
                SizedBox(height: Dimensions.height20,),
                AppTextField(
                    type: TextInputType.phone,
                    controller: phoneController,
                    text: 'Phone',
                    icon: Icons.phone
                ),
                SizedBox(height: Dimensions.height30,),
                //sign up button
                GestureDetector(
                  onTap: (){
                    _registration(_authController);
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
                        text: 'Sign Up',
                        size: Dimensions.font20+Dimensions.font20/2,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: Dimensions.height10,),
                //tag line
                RichText(
                  text: TextSpan(
                    recognizer: TapGestureRecognizer()..onTap=()=>Get.back(),
                    text: 'Have an account already?',
                    style: TextStyle(
                        color: Colors.grey[500],
                        fontSize: Dimensions.font20
                    ),
                  ),
                ),
                SizedBox(height: Dimensions.screenHeight*0.05,),
                // signup options
                RichText(
                  text: TextSpan(
                    text: 'Sign up using one of the following methods',
                    style: TextStyle(
                        color: Colors.grey[500],
                        fontSize: Dimensions.font16
                    ),
                  ),
                ),
                Wrap(
                  children: List.generate(3, (index) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: Dimensions.radius30,
                      backgroundImage: AssetImage(
                        'assets/image/'+signUpImages[index],
                      ),
                    ),
                  ),
                  ),
                ),
              ],
            ),
          ):
          const CustomLoader();
        },
      ),
    );

  }

}
