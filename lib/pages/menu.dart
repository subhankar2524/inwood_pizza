import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:inwood_pizza/controller/cart_controller.dart';
import 'package:inwood_pizza/theme/colors.dart';
import 'dart:convert';

import 'package:inwood_pizza/utils.dart';

class MainMenu extends StatefulWidget {
  final String filter;
  const MainMenu({super.key, required this.filter});

  @override
  State<MainMenu> createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  List<dynamic> foodItems = [];

  @override
  void initState() {
    super.initState();
    fetchMenu();
  }

  Future<void> fetchMenu() async {
    final response = await http
        .get(Uri.parse('${Constants.baseUrl}/api/product/getAllFood/All'));
    try {
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          foodItems = data['data']['food'].where((item) {
            return item['catagory'] == widget.filter;
          }).toList();
        });
      } else {
        print('error fetching data');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  void _showPopup(BuildContext context, dynamic item) {
    double quantity = 1; // Initial quantity
    double price = (item['prices'][0] as num).toDouble();
    String selectedPrice = 'price0';

    double selectedOptionsInit = 0;

    final cartController = Get.put(CartController());

    Map<String, bool> selectedOptions = {};
    item['extraOptions'].forEach((option) {
      selectedOptions[option['text']] = false;
    });

    Map<String, bool> selectedPrices = {};
    for (int i = 0; i < item['prices'].length; i++) {
      selectedPrices['price$i'] = false;
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            double finalPrice = (price + selectedOptionsInit) * quantity;
            return AlertDialog(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    fit: FlexFit.tight,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Text(item['title']),
                    ),
                  ),
                  IconButton(
                    alignment: Alignment.centerRight,
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(
                      Icons.close,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
              contentPadding: const EdgeInsets.all(0),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    item['img'] != ''
                        ? Image.network(
                            item['img'],
                            width: double.maxFinite,
                            fit: BoxFit.cover,
                          )
                        : const Image(
                            image: AssetImage('assets/images/no_image.jpg'),
                            width: double.maxFinite,
                            fit: BoxFit.cover,
                          ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('${item['desc']}'),
                    ),
                    ...item['prices'].map<Widget>((priceOption) {
                      return RadioListTile<String>(
                        title: Text('\$${priceOption.toStringAsFixed(2)}'),
                        value: 'price${item['prices'].indexOf(priceOption)}',
                        groupValue: selectedPrice,
                        onChanged: (String? value) {
                          setState(() {
                            selectedPrice = value!;
                            price = (item['prices']
                                    [int.parse(value.substring(5))] as num)
                                .toDouble();
                          });

                          print(selectedPrices);
                        },
                      );
                    }).toList(),
                    ...item['extraOptions'].map<Widget>((option) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 2.0, horizontal: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(option['text']),
                            const Spacer(),
                            Text(
                                '\$${(option['price'] as num).toDouble().toStringAsFixed(2)}'),
                            Checkbox(
                              value: selectedOptions[option['text']],
                              onChanged: (bool? value) {
                                setState(() {
                                  selectedOptions[option['text']] = value!;
                                  if (value) {
                                    selectedOptionsInit +=
                                        (option['price'] as num).toDouble();
                                  } else {
                                    selectedOptionsInit -=
                                        (option['price'] as num).toDouble();
                                  }
                                });
                              },
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ],
                ),
              ),
              actions: <Widget>[
                Container(
                  width: double.maxFinite,
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Text(
                    'Price: \$${finalPrice.toStringAsFixed(2)}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.remove),
                            onPressed: () {
                              if (quantity > 1) {
                                setState(() {
                                  quantity--;
                                });
                              }
                            },
                          ),
                          Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              decoration: const BoxDecoration(
                                  border: Border.symmetric(
                                      vertical: BorderSide(
                                          color: Colors.black, width: 1.5))),
                              child: Text('$quantity')),
                          IconButton(
                            icon: const Icon(Icons.add),
                            onPressed: () {
                              setState(() {
                                quantity++;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: MyColors.white,
                        backgroundColor: MyColors.fadeBlack,
                      ),
                      child: const Text('Add to cart'),
                      onPressed: () async {
                        Map<String, dynamic> cartItem = {
                          'pricePerUnit': finalPrice,
                          'title': item['title'],
                          'finalPrice': finalPrice,
                          'quantity': quantity,
                          'selectedPrices': selectedPrices,
                          'selectedOptions': selectedOptions,
                        };

                        cartController.addItemToCart(cartItem);
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SliverGrid(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // Two items per row
        childAspectRatio: 0.7, // Adjust the ratio according to your item size
        crossAxisSpacing: 0, // Spacing between items in the same row
        mainAxisSpacing: 4.0, // Spacing between items in the same column
      ),
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          final item = foodItems[index];
          return Card(
            color: Colors.white,
            margin: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AspectRatio(
                  aspectRatio:
                      1.7, // Adjust the ratio based on your image aspect ratio
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                    child: item['img'] != ''
                        ? Image.network(
                            item['img'],
                            width: double.maxFinite,
                            fit: BoxFit.cover,
                          )
                        : const Image(
                            image: AssetImage('assets/images/no_image.jpg'),
                            width: double.maxFinite,
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item['title'],
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Price: \$${item['prices'][0]}',
                        style: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () => _showPopup(context, item),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: MyColors.fadeBlack,
                        backgroundColor: MyColors.yellow,
                      ),
                      child: const Text("Add to cart"),
                    ),
                  ),
                )
              ],
            ),
          );
        },
        childCount: foodItems.length,
      ),
    );
  }
}
