import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class CartController extends GetxController {
  RxList<Map<String, dynamic>> cartItems = RxList([]);
  RxDouble cartTotal = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    loadCartItems();
  }

  Future<void> loadCartItems() async {
    final prefs = await SharedPreferences.getInstance();
    final cart = prefs.getStringList('cart') ?? [];
    cartItems.value =
        cart.map<Map<String, dynamic>>((item) => jsonDecode(item)).toList();
    calculateCartTotal();
  }

  void addItemToCart(Map<String, dynamic> item) async {
    final prefs = await SharedPreferences.getInstance();
    final cart = prefs.getStringList('cart') ?? [];
    cart.add(jsonEncode(item));
    await prefs.setStringList('cart', cart);
    loadCartItems();
  }

  void calculateCartTotal() {
    cartTotal.value = cartItems.fold(
        0.0, (sum, item) => sum + item['finalPrice'] * item['quantity']);
  }


  void increaseQuantity(int index) {
    cartItems[index]['quantity']++;
    update(); // Call update to notify the UI
  }

  void decreaseQuantity(int index) {
    if (cartItems[index]['quantity'] > 1) {
      cartItems[index]['quantity']--;
    }
    update(); // Call update to notify the UI
  }
}
