import 'package:flutter/material.dart';
import 'package:shop_app/shared/components/const/dimensions.dart';
import 'package:shop_app/shared/components/const/styles.dart';
import 'package:shop_app/shared/components/widgets/small_text.dart';
import 'package:shop_app/shared/components/widgets/text_with_icon.dart';

import 'big_text.dart';
class AppColumn extends StatelessWidget {
  final String text;
  final int rate;
  final int starsCount;
  const AppColumn({Key? key,
    required this.text,
    required this.rate,
    required this.starsCount,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:
      [
        BigText(text: text,size: Dimensions.font26,),
        SizedBox(height: Dimensions.height10,),
        Row(
          children:
          [
            Wrap(
              children: List.generate(starsCount,
                    (index) =>
                    Icon(
                      Icons.star_sharp,
                      size: Dimensions.height15,
                      color: AppColors.mainColor,
                    ),
              ),
            ),
            const SizedBox(width: 10,),
            SmallText(text: '${rate}'),
            const SizedBox(width: 10,),
            SmallText(text: '1200'),
            const SizedBox(width: 10,),
            SmallText(text: 'comments'),
          ],
        ),
        SizedBox(height: Dimensions.height20,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children:
          const [
            TextWithIconWidget(
              icon: Icons.circle_sharp,
              text: 'Normal',
              iconColor: AppColors.iconColor1,
            ),
            TextWithIconWidget(
              icon: Icons.location_on,
              text: '1.7km',
              iconColor: AppColors.mainColor,
            ),
            TextWithIconWidget(
              icon: Icons.access_time_outlined,
              text: '32min',
              iconColor: AppColors.iconColor2,
            ),
          ],
        )
      ],
    );
  }
}
