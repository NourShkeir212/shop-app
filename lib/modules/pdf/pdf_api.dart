import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shop_app/model/response_model.dart';
import 'package:shop_app/shared/network/remote/controllers/auth_controller.dart';
import 'package:shop_app/shared/network/remote/controllers/cart_controller.dart';
import 'package:shop_app/shared/network/remote/controllers/user_controller.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

import '../../model/cart_model.dart';

class PdfApi{


  static Future<File> generatePdf({
    required Future<ResponseModel> user,
    required List<CartModel> orders,
    required Map<int,CartModel> order,
    required ByteData imageSignature,
  })async{
    final document =PdfDocument();
    final page =document.pages.add();
    drawHeader(page);
    drawSignature(order,page,imageSignature);
    drawGrid(orders,page);
    return saveFile(document);
  }


  static void drawHeader(
      PdfPage page,
      ) {
    var userInfo =Get.find<UserController>().userModel;
    PdfBrush solidBrush = PdfSolidBrush(PdfColor(126, 151, 173));
    Rect bounds = Rect.fromLTWH(0, 50, page.graphics.clientSize.width, 30);

//Draws a rectangle to place the heading in that region
    page.graphics.drawRectangle(brush: solidBrush, bounds: bounds);

//Creates a font for adding the heading in the page
    PdfFont subHeadingFont = PdfStandardFont(PdfFontFamily.timesRoman, 14);

//Creates a text element to add the invoice number
    PdfTextElement element =
    PdfTextElement(text: 'MealLikeMom ', font: subHeadingFont);
    element.brush = PdfBrushes.white;

//Draws the heading on the page
    PdfLayoutResult result = element.draw(
        page: page, bounds: Rect.fromLTWH(10, bounds.top + 8, 0, 0))!;

//Use 'intl' package for date format.
    String currentDate = 'DATE ' + DateFormat.yMMMd().format(DateTime.now());

//Measures the width of the text to place it in the correct location
    Size textSize = subHeadingFont.measureString(currentDate);
    Offset textPosition = Offset(
        page.graphics.clientSize.width - textSize.width - 10, result.bounds.top);

//Draws the date by using drawString method
    page.graphics.drawString(currentDate, subHeadingFont,
        brush: element.brush,
        bounds: Offset(page.graphics.clientSize.width - textSize.width - 10,
            result.bounds.top) &
        Size(textSize.width + 2, 20));

//Creates text elements to add the address and draw it to the page
    element = PdfTextElement(
        text: 'Order From',
        font: PdfStandardFont(PdfFontFamily.timesRoman, 10,
            style: PdfFontStyle.bold));
    element.brush = PdfSolidBrush(PdfColor(126, 155, 203));
    result = element.draw(
        page: page, bounds: Rect.fromLTWH(10, result.bounds.bottom + 25, 0, 0))!;

    PdfFont timesRoman = PdfStandardFont(PdfFontFamily.timesRoman, 10);

    element = PdfTextElement(text: userInfo!.name, font: PdfStandardFont(PdfFontFamily.helvetica,10,style: PdfFontStyle.bold));
    element.brush = PdfBrushes.black;
    result = element.draw(
        page: page, bounds: Rect.fromLTWH(10, result.bounds.bottom + 10, 0, 0))!;



//Draws a line at the bottom of the address
    page.graphics.drawLine(
        PdfPen(PdfColor(126, 151, 173), width: 0.7),
        Offset(0, result.bounds.bottom + 3),
        Offset(page.graphics.clientSize.width, result.bounds.bottom + 3));
  }



  static void drawGrid(
      List<CartModel> orders,
      PdfPage page
      ){
    final grid =PdfGrid();
    grid.columns.add(count: 5);

    final headerRow =grid.headers.add(1)[0];
    final rowsStyle =grid.rows;
    headerRow.style.backgroundBrush =PdfSolidBrush(PdfColor(68,114,196));
    headerRow.style.textBrush=PdfBrushes.white;
    headerRow.cells[0].value='id';
    headerRow.cells[1].value='ProductName';
    headerRow.cells[2].value='Price';
    headerRow.cells[3].value='Quantity';
    headerRow.style.font=PdfStandardFont(PdfFontFamily.helvetica,10,style:PdfFontStyle.bold );

    orders.map((e){
      final row =grid.rows.add();
      row.cells[0].value=e.id.toString();
      row.cells[1].value=e.name;
      row.cells[2].value=e.price.toString()+"\$";
      row.cells[3].value=e.quantity.toString();
    }).toList();

    grid.applyBuiltInStyle(
      PdfGridBuiltInStyle.listTable1LightAccent5
    );

    for(int i=0 ; i<headerRow.cells.count;i++){
      headerRow.cells[i].style.cellPadding=
          PdfPaddings(bottom: 5,left: 10,right:5 ,top: 5);
    }

    for(int i=0 ;i<grid.rows.count;i++){
      final row =grid.rows[i];
      final rowStyle =PdfStringFormat();
      rowStyle.alignment =PdfTextAlignment.center;
      for(int j=0; j<row.cells.count;j++){
        final cell=row.cells[j];
        cell.style.font=PdfStandardFont(PdfFontFamily.helvetica,10);
        cell.style.cellPadding=
            PdfPaddings(bottom: 5,left: 10,right:5 ,top: 5);
        cell.stringFormat.alignment =PdfTextAlignment.left;


      }
    }
    grid.draw(
        page: page,
        bounds: const Rect.fromLTWH(0, 200,0, 0)
    );
  }

  static void drawSignature(
      Map<int,CartModel> order,
      PdfPage page,
      ByteData imageSignature,
){
  var order =Get.find<CartController>().getItems;


  final ageSize =page.getClientSize();
  final PdfBitmap image =PdfBitmap(imageSignature.buffer.asUint8List());

  final signatureText= 'Total:   ${Get
      .find<CartController>()
      .totalAmount.toString()}';

  page.graphics.drawString(
    signatureText,
    PdfStandardFont(PdfFontFamily.helvetica, 17),
    format: PdfStringFormat(alignment: PdfTextAlignment.left),
    bounds: Rect.fromLTWH(pageSize.width -240, pageSize.height -200, 0, 0)
  );

  page.graphics.drawImage(
    image,
    Rect.fromLTWH(pageSize.width-120, pageSize.height-200,100,40)
  );

}


  static Future<File> saveFile(PdfDocument document)async{
    final path =await getApplicationDocumentsDirectory();
    final fileName= path.path+'/Invoice${DateTime.now().toIso8601String()}.pdf';
    final file =File(fileName);

    file.writeAsBytes(document.saveSync());
    document.dispose();

    return file;
  }

}