import 'package:flutter/material.dart';
import 'package:payment_gateway/payment_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var obj = PaymentController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Stripe Payment Getway'),
      ),
      body: Scaffold(
        body: Center(
          child: ElevatedButton(
            onPressed: () => obj.makePayment(amount: '5', currency: 'USD'),
            child: Text('Make Payment'),
          ),
        ),
      ),
    );
  }
}
