import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inwood_pizza/controller/cart_controller.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class SlidingCart extends StatefulWidget {
  final ScrollController controller;

  const SlidingCart({super.key, required this.controller});

  @override
  State<SlidingCart> createState() => _SlidingCartState();
}

class _SlidingCartState extends State<SlidingCart> {
  late Future<List<Map<String, dynamic>>> cartItemsFuture;

  double cartTotal = 0.0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Get.put(CartController());
  }

  @override
  Widget build(BuildContext context) => ListView(
    
      final cartController = Get.find<CartController>();
        controller: widget.controller,
        padding: const EdgeInsets.all(10),
        children: <Widget>[
          buildDragHandle(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total: ',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w900),
                ),
                Text(cartTotal.toStringAsFixed(2)),
              ],
            ),
          ),
          Card(
            child: Obx(
              () => ListView.builder(
                shrinkWrap: true,
                itemCount: cartController.cartItems.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(cartController.cartItems[index]['title']),
                    subtitle: Text(
                        'Quantity: ${cartController.cartItems[index]['quantity']}'),
                  );
                },
              ),
            ),
          ),
        ],
      );

  Widget buildDragHandle() => Center(
        child: Container(
          width: 30,
          height: 5,
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      );
}
