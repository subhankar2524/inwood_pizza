import 'package:flutter/material.dart';
import 'package:inwood_pizza/theme/colors.dart';

class Footer extends StatefulWidget {
  const Footer({super.key});

  @override
  State<Footer> createState() => _FooterState();
}

class _FooterState extends State<Footer> {
  bool _showMore = false;

  void showPopUp() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Terms and Conditions'),
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
          content: const SingleChildScrollView(
            child: Text(textAlign: TextAlign.justify, """
Terms and Conditions for Inwood Pizza LLC
    1. Introduction

    Welcome to Inwood Pizza LLC ("Website"). These terms and conditions ("Terms") govern 
    your use of our Website and the services provided by Inwood Pizza LLC ("we," "us," "our"). 
    By accessing or using our Website, you agree to comply with and be bound by these Terms. 
    If you do not agree with these Terms, please do not use our Website.


    2. Use of the Website

    You must be at least 18 years old to use this Website. By using this Website, you warrant 
    that you have the right, authority, and capacity to enter into these Terms and abide by all of 
    the terms and conditions set forth herein.


    3. Ordering and Payment

    Order Placement: Orders can be placed through our Website or via phone. You are 
    responsible for ensuring the accuracy of your order.
    Pricing: All prices listed on our Website are in USD and are subject to change without 
    notice. Prices include applicable taxes unless stated otherwise.
    Payment: Payment must be made at the time of ordering using the provided payment 
    methods. We accept Apple Pay, Google Pay, Visa, MasterCard, PayPal, and other major 
    credit and debit cards.
    Confirmation: Upon receiving your order, we will send a confirmation email. If you do not 
    receive a confirmation, please contact us immediately.


    4. Delivery and Pickup

    Delivery Area: We deliver within a specific area, as listed on our Website. Orders outside 
    this area may not be accepted.
    Delivery Time: Estimated delivery times are provided at the time of order. While we strive to 
    meet these times, we are not liable for any delays.
    Pickup: You may choose to pick up your order at our designated location. Please bring a 
    copy of your order confirmation.


    5. Cancellation and Refunds

    Cancellation Policy: Orders can be canceled within 30 minutes of placing the order for a 
    full refund. After this period, cancellations may not be possible.
    Refunds: Refunds will be processed for canceled orders, incorrect orders, or if the product 
    delivered is not as described. Refunds will be issued to the original payment method within 
    5 business days.


    6. Allergens and Dietary Requirements

    Allergen Information: We provide information about allergens present in our products on 
    our Website. It is your responsibility to review this information if you have any food 
    allergies.
    Dietary Requirements: While we strive to accommodate dietary preferences, we cannot 
    guarantee that our products are free from cross-contamination.


    7. Intellectual Property

    Ownership: All content on our Website, including text, graphics, logos, images, and 
    software, is the property of Inwood Pizza LLC or its licensors.
    License: We grant you a limited, non-exclusive, non-transferable license to access and use 
    the Website for personal and non-commercial purposes.


    8. Limitation of Liability

    Disclaimer: The Website and services are provided "as is" without any warranties of any 
    kind, either express or implied.
    Limitation: To the maximum extent permitted by law, Inwood Pizza LLC shall not be liable 
    for any indirect, incidental, or consequential damages arising from the use of our Website 
    or services.


    9. Privacy Policy

    Data Collection: We collect personal information in accordance with our Privacy Policy. By 
    using our Website, you consent to such data collection and usage.
    Cookies: Our Website uses cookies to enhance user experience. By using our Website, you 
    agree to our use of cookies.


    10. Governing Law

    These Terms shall be governed by and construed in accordance with the laws of the State 
    of New York, without regard to its conflict of law principles.


    11. Changes to Terms

    We reserve the right to modify these Terms at any time. Any changes will be effective 
    immediately upon posting on our Website. Your continued use of the Website constitutes 
    acceptance of the modified Terms.


    12. Contact Us

    If you have any questions about these Terms, please contact us at:
    Inwood Pizza LLC
    179 Sherman Ave.
    New York, NY 10034
    646-372-2047
    May 22, 2024
    By using our Website, you acknowledge that you have read, understood, and agree to be 
    bound by these Terms and Conditions.
    Inwood Pizza LLC
    179 Sherman Ave.
    New York, NY 10034
    646-372-2047
    May 22, 2024"""),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'About Us',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 16),
          _showMore
              ? GestureDetector(
                  onTap: () {
                    setState(() {
                      _showMore = false;
                    });
                  },
                  child: const Text(
                    'Inwood Pizza, located on Sherman Avenue since 2020, is where pizza craftsmanship meets creativity. Our dedicated pizza artisans blend time-honored traditions with unique twists to create classic New York-style pies. From hand-kneading the dough to simmering our signature tomato sauce, each slice tells its own flavorful story. Whether you\'re satisfying late-night cravings or sharing cozy moments, Inwood Pizza is more than a place to eat; it\'s a community cornerstone. Our regulars aren\'t just patrons; they\'re family, celebrating birthdays, graduations, proposals, and more with us. Hungry for a slice? Order online, and our speedy delivery team will bring the warmth of our brick oven straight to your door. Whether it\'s game night or a family dinner, we\'ve got you covered. Follow the tantalizing aroma of oregano, the buzz of happy chatter, and the irresistible allure of melted cheese. At Inwood Pizza, we\'re not just a pizzeria; we\'re a slice of life.',
                    style: TextStyle(color: MyColors.white),
                    textAlign: TextAlign.justify,
                  ),
                )
              : GestureDetector(
                  onTap: () {
                    setState(() {
                      _showMore = true;
                    });
                  },
                  child: const Text(
                    'Inwood Pizza, located on Sherman Avenue since 2020, is where pizza craftsmanship meets creativity. Our dedicated pizza artisans blend time-honored traditions with unique twists to create classic New York-style pies. From hand-kneading the dough to simmering our signature tomato sauce, each slice tells its own flavorful story. Whether you\'re satisfying late-night cravings or sharing cozy moments, Inwood Pizza is more than a place to eat; it\'s a community cornerstone. Our regulars aren\'t just patrons; they\'re family, celebrating birthdays, graduations, proposals, and more with us. Hungry for a slice? Order online, and our speedy delivery team will bring the warmth of our brick oven straight to your door. Whether it\'s game night or a family dinner, we\'ve got you covered. Follow the tantalizing aroma of oregano, the buzz of happy chatter, and the irresistible allure of melted cheese. At Inwood Pizza, we\'re not just a pizzeria; we\'re a slice of life.',
                    maxLines: 5,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.justify,
                    style: TextStyle(color: MyColors.white),
                  ),
                ),
          const SizedBox(height: 32),
          const Text(
            'Social Links',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  textStyle: const TextStyle(fontSize: 16),
                ),
                child: const Text('Facebook'),
              ),
              const SizedBox(width: 16),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  textStyle: const TextStyle(fontSize: 16),
                ),
                child: const Text('Instagram'),
              ),
            ],
          ),
          const SizedBox(height: 32),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Important Links',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 16),
                    GestureDetector(
                      onTap: showPopUp,
                      child: const Text(
                        'Terms & Conditions',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'About Licences',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Privacy Policy',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 32),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Quick Contact',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Phone:',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      '+1 (646) 642-9432',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Email:',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'info@inwiodpizzallc.com',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 180)
        ],
      ),
    );
  }
}
