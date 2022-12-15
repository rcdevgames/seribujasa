import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seribujasa/service/booking_services/place_order_service.dart';
import 'package:seribujasa/service/pay_services/cashfree_service.dart';
import 'package:seribujasa/service/pay_services/flutterwave_service.dart';
import 'package:seribujasa/service/pay_services/instamojo_service.dart';
import 'package:seribujasa/service/pay_services/mercado_pago_service.dart';
import 'package:seribujasa/service/pay_services/paypal_service.dart';

import 'package:seribujasa/service/pay_services/razorpay_service.dart';
import 'package:seribujasa/view/utils/others_helper.dart';

randomOrderId() {
  var rng = Random();
  return rng.nextInt(100).toString();
}

payAction(String method, BuildContext context, imagePath) {
  switch (method) {
    case 'paypal':
      makePaymentToGetOrderId(context, () {
        PaypalService().payByPaypal(context);
      });
      break;
    case 'cashfree':
      makePaymentToGetOrderId(context, () {
        CashfreeService().getTokenAndPay(context);
      });
      break;
    case 'flutterwave':
      makePaymentToGetOrderId(context, () {
        FlutterwaveService().payByFlutterwave(context);
      });
      break;
    case 'instamojo':
      makePaymentToGetOrderId(context, () {
        InstamojoService().payByInstamojo(context);
      });
      break;
    case 'mercado':
      makePaymentToGetOrderId(context, () {
        MercadoPagoService().mercadoPay(context);
      });
      break;
    case 'midtrans':
      // CashfreeService().getTokenAndPay();
      break;
    case 'mollie':
      // CashfreeService().getTokenAndPay();
      break;
    case 'payfast':
      // MercadoPagoService().mercadoPay();
      break;
    case 'paystack':
      // PaystackService().payByPaystack(context);
      break;
    case 'paytm':
      // MercadoPagoService().mercadoPay();
      break;
    case 'razorpay':
      makePaymentToGetOrderId(context, () {
        // RazorpayService().payByRazorpay(context);
      });
      break;
    case 'stripe':
      makePaymentToGetOrderId(context, () {
        // StripeService().makePayment(context);
      });
      break;
    case 'manual_payment':
      if (imagePath == null) {
        OthersHelper().showToast('You must upload the cheque image', Colors.black);
      } else {
        Provider.of<PlaceOrderService>(context, listen: false).placeOrder(context, imagePath.path, isManualOrCod: true);
      }
      // StripeService().makePayment(context);
      break;
    case 'cash_on_delivery':
      Provider.of<PlaceOrderService>(context, listen: false).placeOrder(context, null, isManualOrCod: true);
      break;
    default:
      {
        debugPrint('not method found');
      }
  }
}

List paymentList = [
  PayMethods('paypal', 'assets/icons/payment/paypal.png'),
  PayMethods('cashfree', 'assets/icons/payment/cashfree.png'),
  PayMethods('flutterwave', 'assets/icons/payment/flutterwave.png'),
  PayMethods('instamojo', 'assets/icons/payment/instamojo.png'),
  PayMethods('mercado', 'assets/icons/payment/mercado.png'),
  // PayMethods('midtrans', 'assets/icons/payment/midtrans.png'),
  // PayMethods('mollie', 'assets/icons/payment/mollie.png'),
  // PayMethods('payfast', 'assets/icons/payment/payfast.png'),
  // PayMethods('paystack', 'assets/icons/payment/paystack.png'),
  // PayMethods('paytm', 'assets/icons/payment/paytm.png'),
  PayMethods('razorpay', 'assets/icons/payment/razorpay.png'),
  PayMethods('stripe', 'assets/icons/payment/stripe.png'),
  PayMethods('manual_payment', 'assets/icons/payment/bank_transfer.png'),
  PayMethods('cash_on_delivery', 'assets/icons/payment/cash_on_delivery.png'),
];

class PayMethods {
  final methodName;
  final image;

  PayMethods(this.methodName, this.image);
}

makePaymentToGetOrderId(BuildContext context, VoidCallback function) async {
  var res = await Provider.of<PlaceOrderService>(context, listen: false).placeOrder(context, null);

  if (res == true) {
    function();
  } else {
    print('order place unsuccessfull, visit payment_constants.dart file');
  }
}
