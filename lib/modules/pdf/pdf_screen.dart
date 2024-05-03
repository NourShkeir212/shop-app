import 'dart:ui';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/model/cart_model.dart';
import 'package:shop_app'
    '/modules/pdf/pdf_api.dart';
import 'package:shop_app'
    '/shared/components/const/dimensions.dart';
import 'package:shop_app'
    '/shared/components/widgets/big_text.dart';
import 'package:shop_app'
    '/shared/network/remote/controllers/cart_controller.dart';
import 'package:shop_app'
    '/shared/routes/route_helper.dart';
import 'package:get/get.'
    'dart';
import 'package:open_file/open_file.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';

import '../../shared/network/remote/controllers/user_controller.dart';
class PdfScreen extends StatelessWidget {
   PdfScreen({Key? key}) : super(key: key);
   var signatureKey =GlobalKey<SfSignaturePadState>();
  @override
  Widget build(BuildContext context) {
    var user= Get.find<UserController>().getUserInfo();
    Map<int,CartModel> item =Get.find<CartController>().items;
    List<CartModel> orders =Get.find<CartController>().getItems;
    Future onSubmit()async{
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context)=>const Center(child: CircularProgressIndicator()));

      final image =await signatureKey.currentState?.toImage();
      final imageSignature= await image!.toByteData(format: ImageByteFormat.png);
      final file =await PdfApi.generatePdf(
          user: user,
          orders: orders,
          order: item,
          imageSignature: imageSignature!,
      );


      Navigator.pop(context);
      //await OpenFile.open(file.path);
      AwesomeDialog(
          context: context,
          headerAnimationLoop: true,
          dialogType: DialogType.SUCCES,
          animType: AnimType.BOTTOMSLIDE,
          title: 'Success',
          desc: 'Checkout success',
          btnCancelOnPress: ()
          {
            Get.toNamed(RouteHelper.getInitial());
          })
          .show();
     // Get.toNamed(RouteHelper.getInitial());
    }
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BigText(text: 'Please Write your Signature',size: Dimensions.font26),
            SizedBox(height: Dimensions.height20,),
            SfSignaturePad(
              key: signatureKey,
              backgroundColor: Colors.yellow.withOpacity(0.2),
            ),
            Center(
              child: TextButton(
                child: Text('Generate Pdf'),
                onPressed: (){
                onSubmit();
                Get.find<CartController>().addToHistory();
                },
              ),
            ),
          ],
        ),
      ),
    );

  }


}

