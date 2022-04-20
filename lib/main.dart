import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:payment_gateway/home_screen.dart';

void main() {
  Stripe.publishableKey =
      'pk_test_51KqDTuBtp1eoRtcdPBK3FGkyyHweQFDy5SbossWw7xgD2PS3arOPPeZoqffUmUasTDyLvnWlD2n3m8wqCpyG2CiF00SdvqW3D9';
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue
      ),
      home: HomeScreen(),
    );
  }
}
