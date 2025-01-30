import 'package:flutter/material.dart';
import 'package:inwood_pizza/pages/login.dart';
import 'package:inwood_pizza/pages/menu.dart';
import 'package:inwood_pizza/theme/colors.dart';
import 'package:inwood_pizza/widgets/cart.dart';

import 'package:inwood_pizza/widgets/footer.dart';
import 'package:inwood_pizza/widgets/menu_headline.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';



class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();

  validateUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    
    print(token);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    validateUser();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final pannelHeightClosed = MediaQuery.sizeOf(context).height * 0.08;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 60,
        title: const Text(
          "Inwood Pizza",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        leading: const Image(
            image: NetworkImage(
                'https://www.inwoodpizzallc.com/static/media/inwood_logo_transparent.8eb920679caa644d5f51.png')),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const LoginPage(),
                  ),
                );
              },
              icon: const Icon(
                Icons.login,
                color: MyColors.white,
              )),
        ],
        backgroundColor: MyColors.primaryOrange,
      ),
      body: SlidingUpPanel(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
        minHeight: pannelHeightClosed,
        parallaxEnabled: true,
        parallaxOffset: 0.5,
        body: CustomScrollView(
          controller: _scrollController,
          slivers: [
            SliverToBoxAdapter(
              child: Stack(
                alignment: Alignment.bottomLeft,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height - 100,
                    width: double.maxFinite,
                    child: const Image(
                      image: AssetImage('assets/images/hero-background.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height - 100,
                    width: double.maxFinite,
                    color: const Color.fromRGBO(0, 0, 0, 0.5),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 40),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: MediaQuery.sizeOf(context).width * 0.8,
                          child: const Text(
                            'Inwood Pizza , where every slice is a slice of heaven.',
                            style: TextStyle(
                                color: MyColors.white,
                                fontSize: 30,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(height: 40),
                        SizedBox(
                          width: MediaQuery.sizeOf(context).width * 0.5,
                          height: 50,
                          child: ElevatedButton(
                              onPressed: () {
                                _scrollController.animateTo(
                                  MediaQuery.of(context).size.height - 100,
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.easeIn,
                                );
                              },
                              child: const Text('Order Now')),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            const MenuHeadline(title: '18" Large Pizza'),
            const MainMenu(
              filter: 'Pizza large 18inch',
            ),
            const MenuHeadline(title: 'Pizza by Slice'),
            const MainMenu(
              filter: 'Pizza by Slice',
            ),
            const MenuHeadline(title: 'Inwood Favorites'),
            const MainMenu(
              filter: 'Inwood Favorites',
            ),
            const MenuHeadline(title: 'Calzones'),
            const MainMenu(
              filter: 'Calzones',
            ),
            const MenuHeadline(title: 'Family Special'),
            const MainMenu(
              filter: 'Family Special',
            ),
            const MenuHeadline(title: 'Everyday Special'),
            const MainMenu(
              filter: 'Everyday Special',
            ),
            const MenuHeadline(title: 'Ice Cream'),
            const MainMenu(
              filter: 'Ice Cream',
            ),
            const MenuHeadline(title: 'Milk Shake'),
            const MainMenu(
              filter: 'Milk Shake',
            ),
            const MenuHeadline(title: 'Drinks'),
            const MainMenu(
              filter: 'Drinks',
            ),
            const SliverToBoxAdapter(child: Footer()),
          ],
        ),
        panelBuilder: (controller) => SlidingCart(
          controller: controller,
        ),
      ),
    );
  }
}
