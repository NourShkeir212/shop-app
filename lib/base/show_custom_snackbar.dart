import 'package:flutter/material.dart';
import 'package:shop_app/shared/components/widgets/big_text.dart';
import 'package:get/get.dart';
void showCustomSnackBar(
    String message,
    {
      Color color=Colors.redAccent,
      bool isError=true,
      String title='Error'
    }){
      Get.snackbar(
        title,
        message,
        titleText: BigText(
          text: title,
          color: Colors.white,
        ),
        messageText: Text(
          message,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        backgroundColor: color,
      );
}