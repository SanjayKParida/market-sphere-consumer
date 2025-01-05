import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:market_sphere/provider/cart_provider.dart';

import '../../widgets/checkout_screen_widgets/your_item_widget.dart';

class CheckoutScreen extends ConsumerStatefulWidget {
  const CheckoutScreen({super.key});

  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends ConsumerState<CheckoutScreen> {
  String selectedPaymentMethod = 'stripe';

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final cartData = ref.read(cartProvider);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          "Checkout",
          style: GoogleFonts.quicksand(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Delivery Address Card
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(13),
                  leading: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFBF7F5),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child:
                        const Icon(Icons.location_on, color: Color(0xFF3854EE)),
                  ),
                  title: Text(
                    "Delivery Address",
                    style: GoogleFonts.quicksand(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  subtitle: Text(
                    "Add your delivery address",
                    style: GoogleFonts.lato(
                      color: Colors.grey,
                      fontSize: 14,
                    ),
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                ),
              ),

              const SizedBox(height: 24),

              // Your Items Section
              Text(
                "Your Items",
                style: GoogleFonts.quicksand(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: cartData.length,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final cartItem = cartData.values.toList()[index];
                  return YourItemWidget(cartItem: cartItem);
                },
              ),

              const SizedBox(height: 24),

              // Payment Methods Section
              Text(
                "Payment Method",
                style: GoogleFonts.quicksand(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    RadioListTile<String>(
                      title: Row(
                        children: [
                          Image.network(
                            'https://cdn-icons-png.flaticon.com/512/5968/5968312.png',
                            width: 24,
                            height: 24,
                          ),
                          const SizedBox(width: 12),
                          Text(
                            "Stripe",
                            style: GoogleFonts.quicksand(
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      value: 'stripe',
                      groupValue: selectedPaymentMethod,
                      onChanged: (value) =>
                          setState(() => selectedPaymentMethod = value!),
                    ),
                    Divider(
                      height: 1,
                      color: Colors.grey.shade200,
                    ),
                    RadioListTile<String>(
                      title: Row(
                        children: [
                          Image.network(
                            'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e1/UPI-Logo-vector.svg/1200px-UPI-Logo-vector.svg.png',
                            width: 24,
                            height: 24,
                          ),
                          const SizedBox(width: 12),
                          Text(
                            "UPI",
                            style: GoogleFonts.quicksand(
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      value: 'upi',
                      groupValue: selectedPaymentMethod,
                      onChanged: (value) =>
                          setState(() => selectedPaymentMethod = value!),
                    ),
                    Divider(
                      height: 1,
                      color: Colors.grey.shade200,
                    ),
                    RadioListTile<String>(
                      title: Row(
                        children: [
                          const Icon(Icons.payments_outlined,
                              color: Color(0xFF3854EE)),
                          const SizedBox(width: 12),
                          Text(
                            "Cash on Delivery",
                            style: GoogleFonts.quicksand(
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      value: 'cashOnDelivery',
                      groupValue: selectedPaymentMethod,
                      onChanged: (value) =>
                          setState(() => selectedPaymentMethod = value!),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 100), // Space for bottom sheet
            ],
          ),
        ),
      ),
      bottomSheet: Container(
          width: screenWidth,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          decoration: BoxDecoration(
            color: Colors.transparent,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 10,
                offset: const Offset(0, -4),
              ),
            ],
          ),
          child: SafeArea(
              child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {},
              child: Container(
                width: double.infinity,
                height: 56,
                decoration: BoxDecoration(
                    color: const Color(0xFF3854EE),
                    borderRadius: BorderRadius.circular(12)),
                child: Center(
                  child: Text(
                    selectedPaymentMethod == 'stripe' ||
                            selectedPaymentMethod == 'upi'
                        ? "Pay Now"
                        : "Place Order",
                    style: GoogleFonts.quicksand(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
          ))),
    );
  }
}
