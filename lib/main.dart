import 'package:avildo_test/Screens/product_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

import 'payment_integration/myhome.dart';

void main() async {
  //Initialize Flutter Binding
  WidgetsFlutterBinding.ensureInitialized();

  Stripe.publishableKey =
  "pk_test_51Oh93xL4ndR3Ps8dqipT1aNcjhKenp4obYKE6bgqM6LIj9jTrU4FGOjV7NVtwdzpDLMtPoSWmd2crSs6sIXVtV3P004gFzFuiw";

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      //initial route
      home: HomeScreen(),
      // home: ProductView(),
    );
  }
}