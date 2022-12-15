import 'package:flutter/material.dart';
import 'package:seribujasa/view/payments/instamojo_payment_page.dart';

class InstamojoService {
  payByInstamojo(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) => InstamojoPaymentPage(),
      ),
    );
  }
}
