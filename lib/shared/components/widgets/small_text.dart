import 'package:flutter/material.dart';

import '../const/dimensions.dart';

class SmallText extends StatelessWidget {
  final Color? color;
  final String text;
  double size;
  double height;
  final bool isOverFlow;
  SmallText({
    Key? key,
    this.color =const Color(0xFFccc7c5),
    this.size=12,
    this.height=1.2,
    this.isOverFlow =false,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
        text,
       // maxLines: 2,
        style: TextStyle(
           //overflow:isOverFlow ?TextOverflow.ellipsis,
            height: height,
            color: color,
            fontSize: size==0?Dimensions.font12 :size,
            fontFamily: 'Roboto'
        )
    );
  }
}