import 'package:flutter/material.dart';
import 'package:shop_app/shared/components/const/dimensions.dart';
import 'package:shop_app/shared/components/const/styles.dart';

class AppIcon extends StatelessWidget {
 final Color backGroundColor;
 final IconData icon;
 final Color iconColor;
 final double size;
 final double iconSize;
   AppIcon({Key? key,
  required this.icon,
           this.backGroundColor= const Color(0xFFfcf4e4),
           this.iconColor =const Color(0xFF756d54),
           this.size=40,
           this.iconSize=16,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(size/2),
        color: backGroundColor,
      ),
      child: Icon(
        icon,
        color:iconColor,
        size:iconSize,
      ),
    );
  }
}

class AppIconMe extends StatelessWidget {
  final Function function;
  final double size;
  final IconData icon;
  final Color backColor;
  final Color iconColor;
  const AppIconMe({Key? key,
    required this.function,
    this.size=40,
    required this.icon,
    this.iconColor=Colors.white,
    this.backColor=AppColors.mainColor,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
      height: Dimensions.height45,
      width: Dimensions.height45,
      decoration: BoxDecoration(
        color:backColor,
        borderRadius: BorderRadius.circular(100/2)
      ),
      child: IconButton(
        onPressed:()=> function,
        icon:Icon(
          icon,
        ),
        color: iconColor,
        iconSize: Dimensions.iconSize20,

      ),
    );
  }
}

