import 'package:flutter/material.dart';
import 'package:shop_app/shared/components/const/dimensions.dart';
import 'package:shop_app/shared/components/widgets/small_text.dart';


class TextWithIconWidget extends StatelessWidget {
 final IconData icon;
 final String text;
 final Color iconColor;
  const TextWithIconWidget({ Key? key,
    required this.text,
    required  this.icon,
    required this.iconColor
  }
  ) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children:
      [
        Icon(icon,color: iconColor,size: Dimensions.iconSize20,),
        const SizedBox(width: 5,),
        SmallText(text: text),
      ],
    );
  }
}



