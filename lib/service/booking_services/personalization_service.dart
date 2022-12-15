import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seribujasa/model/service_extra_model.dart';
import 'package:seribujasa/service/booking_services/book_service.dart';
import 'package:seribujasa/service/common_service.dart';
import 'package:seribujasa/view/utils/others_helper.dart';
import 'package:http/http.dart' as http;

class PersonalizationService with ChangeNotifier {
  var serviceExtraData;

  List includedList = [];
  List extrasList = [];
  var tax = 0;

  int defaultprice = 0;
  setDefaultPrice(price) {
    defaultprice = price;

    Future.delayed(const Duration(microseconds: 600), () {
      notifyListeners();
    });
  }

  // List defaultIncludedList = [];
  // List defaultExtrasList = [];

  bool isloading = true;

  var isOnline = 0;

  setLoadingTrue() {
    isloading = true;
    notifyListeners();
  }

  setLoadingFalse() {
    isloading = false;
    notifyListeners();
  }

  //when user exits, set everything to default again
  setToDefault(BuildContext context) {
    includedList = [];
    extrasList = [];
    notifyListeners();
    //make total price to default
    // Provider.of<BookService>(context, listen: false).defaultTotalPrice();
  }

  increaseIncludedQty(index, BuildContext context) {
    includedList[index]['qty'] = includedList[index]['qty'] + 1;
    notifyListeners();
    // print(Provider.of<BookService>(context, listen: false).totalPrice + int.parse(includedList[index]['price']));
    //increase price
    Provider.of<BookService>(context, listen: false).setTotalPrice(
        Provider.of<BookService>(context, listen: false).totalPrice + int.parse(includedList[index]['price']));
  }

  decreaseIncludedQty(index, BuildContext context) {
    if (includedList[index]['qty'] != 1) {
      includedList[index]['qty'] = includedList[index]['qty'] - 1;
      notifyListeners();
      //decrease price
      Provider.of<BookService>(context, listen: false).setTotalPrice(
          Provider.of<BookService>(context, listen: false).totalPrice - int.parse(includedList[index]['price']));
    }
  }

//when an extra item is selected and quantity is increased
  increaseExtrasQty(index, bool selected, BuildContext context) {
    extrasList[index]['qty'] = extrasList[index]['qty'] + 1;

    notifyListeners();

    //if the item is selected only then increase the price
    if (selected) {
      var price = Provider.of<BookService>(context, listen: false).totalPrice;
      var itemPrice = extrasList[index]['price'];
      Provider.of<BookService>(context, listen: false).setTotalPrice(price + itemPrice);
    }
  }

//when an extra item is selected and quantity is decreased
  decreaseExtrasQty(index, bool selected, BuildContext context) {
    if (extrasList[index]['qty'] != 1) {
      extrasList[index]['qty'] = extrasList[index]['qty'] - 1;
      notifyListeners();

      if (selected) {
        var price = Provider.of<BookService>(context, listen: false).totalPrice;
        var itemPrice = extrasList[index]['price'];
        Provider.of<BookService>(context, listen: false).setTotalPrice(price - itemPrice);
      }
    }
  }

  //if any extra item selected then increase the price based on quantity
  increaseExtraItemPrice(
    BuildContext context,
    index,
  ) {
    var price = Provider.of<BookService>(context, listen: false).totalPrice;
    var itemPrice = extrasList[index]['price'] * extrasList[index]['qty'];
    Provider.of<BookService>(context, listen: false).setTotalPrice(price + itemPrice);
    extrasList[index]['selected'] = true;
  }

  //if any extra item deselected then decrease the price based on quantity
  decreaseExtraItemPrice(
    BuildContext context,
    index,
  ) {
    var price = Provider.of<BookService>(context, listen: false).totalPrice;
    var itemPrice = extrasList[index]['price'] * extrasList[index]['qty'];
    Provider.of<BookService>(context, listen: false).setTotalPrice(price - itemPrice);

    //set selected to false
    extrasList[index]['selected'] = false;
  }

  fetchServiceExtra(serviceId, BuildContext context) async {
    setLoadingTrue();
    setToDefault(context);
    var connection = await checkConnection();
    if (connection) {
      //internet connection is on
      var header = {
        //if header type is application/json then the data should be in jsonEncode method
        "Accept": "application/json",
        // "Content-Type": "application/json"
      };

      var response = await http.get(Uri.parse('$baseApi/service-list/service-book/$serviceId'), headers: header);

      if (response.statusCode == 201) {
        var data = jsonDecode(response.body);
        // var data = ServiceExtraModel.fromJson(jsonDecode(response.body));
        isOnline = int.parse(data['service']['is_service_online']) ?? 0;

        tax = int.parse(data['service']['tax']) ?? 0;

        // //adding included list
        for (int i = 0; i < data['service']['service_include'].length; i++) {
          includedList.add({
            'title': data['service']['service_include'][i]['include_service_title'],
            'price': data['service']['service_include'][i]['include_service_price'],
            'qty': 1
          });
        }

        // //adding extras list
        for (int i = 0; i < data['service']['service_additional'].length; i++) {
          extrasList.add({
            'title': data['service']['service_additional'][i]['additional_service_title'],
            'price': int.parse(data['service']['service_additional'][i]['additional_service_price']),
            'qty': 1,
            'selected': false
          });
        }
        serviceExtraData = data;
        // // var data = ServiceDetailsModel.fromJson(jsonDecode(response.body));

        notifyListeners();
        setLoadingFalse();
      } else {
        serviceExtraData == 'error';
        setLoadingFalse();
        OthersHelper().showToast('Something went wrong', Colors.black);
        notifyListeners();
      }
    }
  }
}
