import 'package:flutter/material.dart';
import 'package:seribujasa/view/payments/razorpay_payment_page.dart';

class RazorpayService {
  payByRazorpay(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) => const RazorpayPaymentPage(),
      ),
    );
  }
}
