import 'package:flutter/material.dart';
import 'package:shop_app/shared/network/remote/controllers/auth_controller.dart';
import 'package:get/get.dart';

import '../const/dimensions.dart';
import 'package:shop_app/shared/components/const/styles.dart';
class AppTextField extends StatelessWidget {
  final TextEditingController controller;
  final String text;
  final IconData icon;
  bool isPassword;
  final TextInputType type;
   AppTextField({
    Key? key,
    required this.type,
    required this.controller,
    required this.text,
    this.isPassword=false,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: Dimensions.height20,
        right: Dimensions.height20,
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimensions.radius15),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                blurRadius: 10,
                spreadRadius: 1,
                offset: const Offset(1,1),
                color: Colors.grey.withOpacity(0.2)
            )
          ]
      ),
      child: TextField(
        obscureText: isPassword?true:false,
        keyboardType: type,
        controller: controller,
        decoration:  InputDecoration(
            hintText: text,
            prefixIcon:  Icon(
              icon,
              color: AppColors.mainColor,
            ),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(Dimensions.radius15),
                borderSide: const BorderSide(
                    width: 1.0,
                    color: Colors.white
                )
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Dimensions.radius15),
              borderSide: const BorderSide(
                  width: 1.0,
                  color: Colors.white
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Dimensions.radius15),
            )
        ),
      ),
    );
  }
}
