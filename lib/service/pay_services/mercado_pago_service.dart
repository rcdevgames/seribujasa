import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mercado_pago_mobile_checkout/mercado_pago_mobile_checkout.dart';
import 'package:provider/provider.dart';
import 'package:seribujasa/service/booking_services/place_order_service.dart';

class MercadoPagoService {
  mercadoPay(BuildContext context) async {
    var result = await getToken();

    if (result == true) {
      print('mercado token is $token');
      await MercadoPagoMobileCheckout.startCheckout(
        publicKey,
        token ?? '',
      );
      Provider.of<PlaceOrderService>(context, listen: false).makePaymentSuccess(context);
    } else {
      //token getting failed
    }
  }

  String? token;
  String publicKey = "TEST-0a3cc78a-57bf-4556-9dbe-2afa06347769";
  String accessToken = "TEST-4644184554273630-070813-7d817e2ca1576e75884001d0755f8a7a-786499991";

  Future<bool> getToken() async {
    var header = {
      //if header type is application/json then the data should be in jsonEncode method
      "Accept": "application/json",
      "Content-Type": "application/json"
    };

    var data = jsonEncode({
      "items": [
        {
          "title": "Dummy Item",
          "description": "Multicolor Item",
          "quantity": 1,
          "currency_id": "ARS",
          "unit_price": 10.0
        }
      ],
      "payer": {"email": "payer@email.com"}
    });

    var response = await http.post(
        Uri.parse('https://api.mercadopago.com/checkout/preferences?access_token=$accessToken'),
        headers: header,
        body: data);

    if (response.statusCode == 201) {
      token = jsonDecode(response.body)['id'];

      print(response.body);
      return true;
    } else {
      print('token get failed');
      return false;
    }
  }
}
