import 'dart:convert';

import 'package:cashfree_pg/cashfree_pg.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:seribujasa/view/utils/others_helper.dart';

import '../booking_services/place_order_service.dart';

class CashfreeService {
  var header = {
    //if header type is application/json then the data should be in jsonEncode method
    // "Accept": "application/json",
    'x-client-id': '94527832f47d6e74fa6ca5e3c72549',
    'x-client-secret': 'ec6a3222018c676e95436b2e26e89c1ec6be2830',
    "Content-Type": "application/json"
  };

  getTokenAndPay(BuildContext context) async {
    String orderId = Provider.of<PlaceOrderService>(context, listen: false).orderId;
    String orderCurrency = "INR";
    var data = jsonEncode({'orderId': orderId, 'orderAmount': '6000', 'orderCurrency': orderCurrency});

    var response = await http.post(
      Uri.parse(
          'https://test.cashfree.com/api/v2/cftoken/order'), // change url to https://api.cashfree.com/api/v2/cftoken/order when in production
      body: data,
      headers: header,
    );
    print(response.body);

    if (jsonDecode(response.body)['status'] == "OK") {
      cashFreePay(jsonDecode(response.body)['cftoken'], orderId, orderCurrency, context);
    } else {
      OthersHelper().showToast('Something went wrong', Colors.black);
    }
    // if()
  }

  cashFreePay(token, orderId, orderCurrency, BuildContext context) {
    //Replace with actual values
    //has to be unique every time
    String stage = "TEST"; // PROD when in production mode// TEST when in test
    String orderAmount = "6000";
    String tokenData = token; //generate token data from server
    String customerName = "saleheen";
    String orderNote = "test note";

    String appId = "94527832f47d6e74fa6ca5e3c72549";
    String customerPhone = "01781873788";
    String customerEmail = "smsaleheen2@gmail.com";
    String notifyUrl = "";

    Map<String, dynamic> inputParams = {
      "orderId": orderId,
      "orderAmount": orderAmount,
      "customerName": customerName,
      "orderNote": orderNote,
      "orderCurrency": orderCurrency,
      "appId": appId,
      "customerPhone": customerPhone,
      "customerEmail": customerEmail,
      "stage": stage,
      "tokenData": tokenData,
      "notifyUrl": notifyUrl
    };

    // CashfreePGSDK.doPayment(inputParams)
    //     .then((value) => value?.forEach((key, value) {
    //           print("$key : $value");
    //           print('it worked');
    //           //Do something with the result
    //         }));
    CashfreePGSDK.doPayment(
      inputParams,
    ).then((value) {
      print('cashfree payment result $value');
      if (value != null) {
        if (value['txStatus'] == "SUCCESS") {
          print('Cashfree Payment successfull. Do something here');
          Provider.of<PlaceOrderService>(context, listen: false).makePaymentSuccess(context);
        }
      }
    });
  }
}
