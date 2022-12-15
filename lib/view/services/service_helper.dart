import 'package:flutter/material.dart';
import 'package:seribujasa/view/utils/constant_colors.dart';

class ServiceHelper {
  ConstantColors cc = ConstantColors();
  checkListCommon(String title) {
    return Container(
      margin: const EdgeInsets.only(bottom: 13),
      child: Row(
        children: [
          Icon(
            Icons.check,
            color: cc.successColor,
          ),
          const SizedBox(
            width: 14,
          ),
          Text(
            title,
            style: TextStyle(
              color: cc.greyFour,
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }

  serviceDetails(String title1, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title1,
          style: TextStyle(
            color: cc.greyParagraph,
            fontSize: 14,
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Text(
          value,
          style: TextStyle(color: cc.greyPrimary, fontSize: 17, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
