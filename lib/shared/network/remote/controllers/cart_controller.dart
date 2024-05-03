import 'package:flutter/material.dart';
import 'package:shop_app/model/cart_model.dart';
import 'package:shop_app/model/product_model.dart';
import 'package:shop_app/shared/components/const/styles.dart';
import 'package:shop_app/shared/network/remote/data/repository/cart_repo.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  final CartRepo cartRepo;

  CartController({required this.cartRepo});

  Map<int, CartModel> _items = {};

  Map<int, CartModel> get items => _items;

  /*
 only for storage and sharedPreferences
  */
  List<CartModel> storageItems = [];

  void addItem(ProductModel product, int quantity) {
    var totalQuantity = 0;
    if (_items.containsKey(product.id!)) {
      _items.update(product.id!, (value) {
        totalQuantity = value.quantity! + quantity;
        return CartModel(
            id: value.id,
            name: value.name,
            img: value.img,
            price: value.price,
            isExist: true,
            quantity: value.quantity! + quantity,
            time: DateTime.now().toString(),
            product: product);
      });
      if (totalQuantity <= 0) {
        _items.remove(product.id);
      }
    } else {
      if (quantity > 0) {
        _items.putIfAbsent(product.id!, () {
          return CartModel(
            id: product.id,
            name: product.name,
            img: product.img,
            price: product.price,
            isExist: true,
            quantity: quantity,
            time: DateTime.now().toString(),
            product: product,
          );
        });
      } else {
        Get.snackbar(
            'Item count', 'You should at least add an item in the cart!',

            colorText: Colors.white, backgroundColor: AppColors.iconColor2);
      }
    }
    cartRepo.addToCartList(getItems);
    update();
  }

  bool existInCart(ProductModel product) {
    if (_items.containsKey(product.id)) {
      return true;
    }
    return false;
  }

  int getQuantity(ProductModel product) {
    var quantity = 0;
    if (_items.containsKey(product.id)) {
      _items.forEach((key, value) {
        if (key == product.id) {
          quantity = value.quantity!;
        }
      });
    }
    return quantity;
  }

  int get totalItems {
    var totalQuantity = 0;
    _items.forEach((key, value) {
      totalQuantity += value.quantity!;
    });
    return totalQuantity;
  }

  List<CartModel> get getItems {
    return _items.entries.map((e) {
      return e.value;
    }).toList();
  }

  int get totalAmount {
    var total = 0;

    _items.forEach((key, value) {
      total += value.price! * value.quantity!;
    });

    return total;
  }

  List<CartModel> getCartData() {
    setCart = cartRepo.getCartList();
    return storageItems;
  }

  set setCart(List<CartModel> items) {
    storageItems = items;
    print("Length of cart Items " + storageItems.length.toString());
    for (int i = 0; i < storageItems.length; i++) {
      _items.putIfAbsent(storageItems[i].product!.id!, () => storageItems[i]);
    }
  }

  void addToHistory() {
    cartRepo.addToCartHistoryList();
    clear();
  }

  void clear() {
    _items = {};
    update();
  }

  // for histroy //

  List<CartModel> getCartHistoryList() {
    return cartRepo.getCartHistoryList();
  }

  set setItems(Map<int,CartModel>setItems){
    _items= {};
    _items =setItems;
  }

  void addToCartList(){
    cartRepo.addToCartList(getItems);
    update();
  }

  void clearCartHistory(){
    return cartRepo.clearCartHistory();
    update();
  }
}
