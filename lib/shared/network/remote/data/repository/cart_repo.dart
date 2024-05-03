import 'dart:convert';
import 'package:shop_app/shared/components/const/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_app/model/cart_model.dart';
class CartRepo{
   
  // jsonEncode from object to string
  // jsonDecode from string to object
   final SharedPreferences sharedPreferences;
   CartRepo({required this.sharedPreferences});

   List<String> cart=[];
   List<String> cartHistory=[];

   // for set to Storage
   void addToCartList(List<CartModel> cartList){
      // sharedPreferences.remove(AppConstants.CART_LIST);
      // sharedPreferences.remove(AppConstants.CART_HISTORY_LIST);
      var time= DateTime.now().toString();
      cart=[];
      /*
      convert object to string
       */
      cartList.forEach((element){
       element.time =time;
       return  cart.add(jsonEncode(element));
      });

      sharedPreferences.setStringList(AppConstants.CART_LIST, cart);
      print(sharedPreferences.getStringList(AppConstants.CART_LIST));
   }

   //for get fromStorage
   List<CartModel> getCartList() {
      List<String> carts=[];
      if(sharedPreferences.containsKey(AppConstants.CART_LIST))
      {
      carts = sharedPreferences.getStringList(AppConstants.CART_LIST)!;
      }
      List<CartModel> cartList =[];

      carts.forEach((element)=>cartList.add(CartModel.fromJson(jsonDecode(element))));
      print('inside getCartList'+cartList.toString());
      return cartList;
   }

   List<CartModel> getCartHistoryList() {
      if(sharedPreferences.containsKey(AppConstants.CART_HISTORY_LIST)) {
         cartHistory=[];
         cartHistory =sharedPreferences.getStringList(AppConstants.CART_HISTORY_LIST)!;
      }
      List<CartModel> cartListHistory=[];
      cartHistory.forEach((element)=>cartListHistory.add(CartModel.fromJson(jsonDecode(element))));
      return cartListHistory;
   }

   void addToCartHistoryList(){
      if(sharedPreferences.containsKey(AppConstants.CART_HISTORY_LIST)){
         cartHistory =sharedPreferences.getStringList(AppConstants.CART_HISTORY_LIST)!;
      }
      for(int i=0 ;i<cart.length;i++){
       cartHistory.add(cart[i]);
      }
      removeCart();
      sharedPreferences.setStringList(AppConstants.CART_HISTORY_LIST, cartHistory);
      print('The length of history list is '+getCartHistoryList().length.toString());
      for(int i=0;i<getCartHistoryList().length;i++)
      {
         print('the time of the order is '+getCartHistoryList()[i].time.toString());
      }
   }

   void removeCart(){
      cart=[];
      sharedPreferences.remove(AppConstants.CART_LIST);
   }

   void clearCartHistory(){
      removeCart();
      cartHistory=[];
      sharedPreferences.remove(AppConstants.CART_HISTORY_LIST);
   }

}
