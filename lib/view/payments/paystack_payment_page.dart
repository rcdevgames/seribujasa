// import 'dart:async';
// import 'dart:io';

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_paystack/flutter_paystack.dart';
// import 'package:http/http.dart' as http;

// class PaystackPaymentPage extends StatefulWidget {
//   const PaystackPaymentPage({Key? key}) : super(key: key);

//   @override
//   _PaystackPaymentPageState createState() => _PaystackPaymentPageState();
// }

// class _PaystackPaymentPageState extends State<PaystackPaymentPage> {
//   final _scaffoldKey = GlobalKey<ScaffoldState>();
//   final _formKey = GlobalKey<FormState>();

//   final _horizontalSizeBox = const SizedBox(width: 10.0);
//   final plugin = PaystackPlugin();

//   int _radioValue = 1;
//   CheckoutMethod _method = CheckoutMethod.selectable;
//   bool _inProgress = false;
//   String? _cardNumber;
//   String? _cvv;
//   int? _expiryMonth;
//   int? _expiryYear;

//   String backendUrl = 'https://api.paystack.co';
// // Set this to a public key that matches the secret key you supplied while creating the heroku instance
//   String paystackPublicKey = 'pk_test_a7e58f850adce9a73750e61668d4f492f67abcd9';

//   @override
//   void initState() {
//     plugin.initialize(
//       publicKey: paystackPublicKey,
//     );
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       key: _scaffoldKey,
//       appBar: AppBar(title: const Text('Paystack')),
//       body: Container(
//         padding: const EdgeInsets.all(20.0),
//         child: Form(
//           key: _formKey,
//           child: SingleChildScrollView(
//             child: ListBody(
//               children: <Widget>[
//                 // Row(
//                 //   crossAxisAlignment: CrossAxisAlignment.center,
//                 //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 //   children: <Widget>[
//                 //     const Expanded(
//                 //       child: Text('Initalize transaction from:'),
//                 //     ),
//                 //     Expanded(
//                 //       child: Column(
//                 //           mainAxisSize: MainAxisSize.min,
//                 //           children: <Widget>[
//                 //             RadioListTile<int>(
//                 //               value: 0,
//                 //               groupValue: _radioValue,
//                 //               onChanged: _handleRadioValueChanged,
//                 //               title: const Text('Local'),
//                 //             ),
//                 //             RadioListTile<int>(
//                 //               value: 1,
//                 //               groupValue: _radioValue,
//                 //               onChanged: _handleRadioValueChanged,
//                 //               title: const Text('Server'),
//                 //             ),
//                 //           ]),
//                 //     )
//                 //   ],
//                 // ),
//                 Theme(
//                   data: Theme.of(context).copyWith(
//                     accentColor: green,
//                     primaryColorLight: Colors.white,
//                     primaryColorDark: navyBlue,
//                     textTheme: Theme.of(context).textTheme.copyWith(
//                           bodyText2: const TextStyle(
//                             color: lightBlue,
//                           ),
//                         ),
//                   ),
//                   child: Builder(
//                     builder: (context) {
//                       return _inProgress
//                           ? Container(
//                               alignment: Alignment.center,
//                               height: 50.0,
//                               child: Platform.isIOS
//                                   ? const CupertinoActivityIndicator()
//                                   : const CircularProgressIndicator(),
//                             )
//                           : Column(
//                               mainAxisSize: MainAxisSize.min,
//                               children: <Widget>[
//                                 const SizedBox(
//                                   height: 40.0,
//                                 ),
//                                 Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   crossAxisAlignment: CrossAxisAlignment.center,
//                                   children: <Widget>[
//                                     Flexible(
//                                       flex: 3,
//                                       child: DropdownButtonHideUnderline(
//                                         child: InputDecorator(
//                                           decoration: const InputDecoration(
//                                             border: OutlineInputBorder(),
//                                             isDense: true,
//                                             hintText: 'Checkout method',
//                                           ),
//                                           child: DropdownButton<CheckoutMethod>(
//                                             value: _method,
//                                             isDense: true,
//                                             onChanged: (CheckoutMethod? value) {
//                                               if (value != null) {
//                                                 setState(() => _method = value);
//                                               }
//                                             },
//                                             items: banks.map((String value) {
//                                               return DropdownMenuItem<
//                                                   CheckoutMethod>(
//                                                 value:
//                                                     _parseStringToMethod(value),
//                                                 child: Text(value),
//                                               );
//                                             }).toList(),
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                     _horizontalSizeBox,
//                                     Flexible(
//                                       flex: 2,
//                                       child: Container(
//                                         width: double.infinity,
//                                         child: _getPlatformButton(
//                                           'Checkout',
//                                           () => _handleCheckout(context),
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 )
//                               ],
//                             );
//                     },
//                   ),
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   void _handleRadioValueChanged(int? value) {
//     if (value != null) setState(() => _radioValue = value);
//   }

//   _handleCheckout(BuildContext context) async {
//     if (_method != CheckoutMethod.card && _isLocal) {
//       _showMessage('Please select a method');
//       return;
//     }
//     setState(() => _inProgress = true);
//     _formKey.currentState?.save();
//     Charge charge = Charge()
//       ..amount = 10000 // In base currency
//       ..email = 'customer@email.com'
//       ..card = _getCardFromUI();

//     if (!_isLocal) {
//       var accessCode = await _fetchAccessCodeFrmServer(_getReference());
//       charge.accessCode = accessCode;
//     } else {
//       charge.reference = _getReference();
//     }

//     try {
//       CheckoutResponse response = await plugin.checkout(
//         context,
//         method: _method,
//         charge: charge,
//         fullscreen: false,
//         logo: const MyLogo(),
//       );
//       print('Response = $response');
//       setState(() => _inProgress = false);
//       _updateStatus(response.reference, '$response');
//     } catch (e) {
//       setState(() => _inProgress = false);
//       _showMessage("Check console for error");
//       rethrow;
//     }
//   }

//   _startAfreshCharge() async {
//     _formKey.currentState?.save();

//     Charge charge = Charge();
//     charge.card = _getCardFromUI();

//     setState(() => _inProgress = true);

//     if (_isLocal) {
//       // Set transaction params directly in app (note that these params
//       // are only used if an access_code is not set. In debug mode,
//       // setting them after setting an access code would throw an exception

//       charge
//         ..amount = 10000 // In base currency
//         ..email = 'customer@email.com'
//         ..reference = _getReference()
//         ..putCustomField('Charged From', 'Flutter SDK');
//       _chargeCard(charge);
//     } else {
//       // Perform transaction/initialize on Paystack server to get an access code
//       // documentation: https://developers.paystack.co/reference#initialize-a-transaction
//       charge.accessCode = await _fetchAccessCodeFrmServer(_getReference());
//       _chargeCard(charge);
//     }
//   }

//   _chargeCard(Charge charge) async {
//     final response = await plugin.chargeCard(context, charge: charge);

//     final reference = response.reference;

//     // Checking if the transaction is successful
//     if (response.status) {
//       _verifyOnServer(reference);
//       return;
//     }

//     print('response status is ${response.status}');

//     // The transaction failed. Checking if we should verify the transaction
//     if (response.verify) {
//       _verifyOnServer(reference);
//     } else {
//       setState(() => _inProgress = false);
//       _updateStatus(reference, response.message);
//     }
//   }

//   String _getReference() {
//     String platform;
//     if (Platform.isIOS) {
//       platform = 'iOS';
//     } else {
//       platform = 'Android';
//     }

//     return 'ChargedFrom${platform}_${DateTime.now().millisecondsSinceEpoch}';
//   }

//   PaymentCard _getCardFromUI() {
//     // Using just the must-required parameters.
//     return PaymentCard(
//       number: _cardNumber,
//       cvc: _cvv,
//       expiryMonth: _expiryMonth,
//       expiryYear: _expiryYear,
//     );

//     // Using Cascade notation (similar to Java's builder pattern)
// //    return PaymentCard(
// //        number: cardNumber,
// //        cvc: cvv,
// //        expiryMonth: expiryMonth,
// //        expiryYear: expiryYear)
// //      ..name = 'Segun Chukwuma Adamu'
// //      ..country = 'Nigeria'
// //      ..addressLine1 = 'Ikeja, Lagos'
// //      ..addressPostalCode = '100001';

//     // Using optional parameters
// //    return PaymentCard(
// //        number: cardNumber,
// //        cvc: cvv,
// //        expiryMonth: expiryMonth,
// //        expiryYear: expiryYear,
// //        name: 'Ismail Adebola Emeka',
// //        addressCountry: 'Nigeria',
// //        addressLine1: '90, Nnebisi Road, Asaba, Deleta State');
//   }

//   Widget _getPlatformButton(String string, Function() function) {
//     // is still in progress
//     Widget widget;
//     if (Platform.isIOS) {
//       widget = CupertinoButton(
//         onPressed: function,
//         padding: const EdgeInsets.symmetric(horizontal: 15.0),
//         color: CupertinoColors.activeBlue,
//         child: Text(
//           string,
//           maxLines: 1,
//           overflow: TextOverflow.ellipsis,
//         ),
//       );
//     } else {
//       widget = ElevatedButton(
//         onPressed: function,
//         child: Text(
//           string.toUpperCase(),
//           style: const TextStyle(fontSize: 17.0),
//         ),
//       );
//     }
//     return widget;
//   }

//   Future<String?> _fetchAccessCodeFrmServer(String reference) async {
//     String url = '$backendUrl/new-access-code';
//     String? accessCode;
//     try {
//       print("Access code url = $url");
//       http.Response response = await http.get(Uri.parse(url));
//       accessCode = response.body;
//       print('Response for access code = $accessCode');
//     } catch (e) {
//       setState(() => _inProgress = false);
//       _updateStatus(
//           reference,
//           'There was a problem getting a new access code form'
//           ' the backend: $e');
//     }

//     return accessCode;
//   }

//   void _verifyOnServer(String? reference) async {
//     _updateStatus(reference, 'Verifying...');
//     String url = '$backendUrl/verify/$reference';
//     try {
//       http.Response response = await http.get(Uri.parse(url));
//       var body = response.body;
//       _updateStatus(reference, body);
//     } catch (e) {
//       _updateStatus(
//           reference,
//           'There was a problem verifying %s on the backend: '
//           '$reference $e');
//     }
//     setState(() => _inProgress = false);
//   }

//   _updateStatus(String? reference, String message) {
//     _showMessage('Transaction cancelled', const Duration(seconds: 7));
//   }

//   _showMessage(String message,
//       [Duration duration = const Duration(seconds: 4)]) {
//     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//       content: Text(message),
//       duration: duration,
//       action: SnackBarAction(
//           label: 'CLOSE',
//           onPressed: () =>
//               ScaffoldMessenger.of(context).removeCurrentSnackBar()),
//     ));
//   }

//   bool get _isLocal => _radioValue == 0;
// }

// var banks = ['Select method', 'Bank', 'Card'];

// CheckoutMethod _parseStringToMethod(String string) {
//   CheckoutMethod method = CheckoutMethod.selectable;
//   switch (string) {
//     case 'Bank':
//       method = CheckoutMethod.bank;
//       break;
//     case 'Card':
//       method = CheckoutMethod.card;
//       break;
//   }
//   return method;
// }

// class MyLogo extends StatelessWidget {
//   const MyLogo({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: const BoxDecoration(
//         shape: BoxShape.circle,
//         color: Colors.black,
//       ),
//       alignment: Alignment.center,
//       padding: const EdgeInsets.all(10),
//       child: const Text(
//         "CO",
//         style: TextStyle(
//           color: Colors.white,
//           fontSize: 13,
//           fontWeight: FontWeight.bold,
//         ),
//       ),
//     );
//   }
// }

// const Color green = Color(0xFF3db76d);
// const Color lightBlue = Color(0xFF34a5db);
// const Color navyBlue = Color(0xFF031b33);
