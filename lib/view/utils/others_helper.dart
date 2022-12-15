import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:seribujasa/view/utils/constant_colors.dart';

class OthersHelper with ChangeNotifier {
  ConstantColors cc = ConstantColors();
  int deliveryCharge = 60;

  showLoading(Color color) {
    return SpinKitThreeBounce(
      color: color,
      size: 16.0,
    );
  }

  showError(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height - 180,
        alignment: Alignment.center,
        child: const Text("Something went wrong"));
  }

  void showToast(String msg, Color? color) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: color,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  void toastShort(String msg, Color color) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: color,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
// String baseApi = 'https://bytesed.com/laravel/qixer/api/v1';
String baseApi = 'https://api.seribujasa.co.id/api/v1';

List colors = [const Color(0xffFF6B2C), const Color(0xff65C18C), const Color(0xffFFC300), const Color(0xff64BA10)];

getCategoryIconColor(int i) {}

getLineAwsome(String lineIcon) {
  var a = lineIcon.split(' ');
  var splitLa = a[1].substring(3);
  var b = 'LineAwesomeIcons.$splitLa';

  // print(b);
  // print(LineAwesomeIcons.accessible_icon.codePoint);
}

// categoryIconList(int i) {
//   List icons = [
//     LineAwesomeIcons.charging_station,
//     LineAwesomeIcons.toilet,
//     LineAwesomeIcons.people_carry,
//     LineAwesomeIcons.paint_roller,
//     LineAwesomeIcons.scissors__hand_,
//     LineAwesomeIcons.accessible_icon,
//   ];
//   if (i < icons.length) {
//     return icons[i];
//   } else {
//     return LineAwesomeIcons.accessible_icon;
//   }
// }

String placeHolderUrl = 'https://i.postimg.cc/3RKkSRDb/placeholder.png';
