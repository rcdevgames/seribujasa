import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:seribujasa/view/services/components/desc_from_html.dart';
import 'package:seribujasa/view/utils/constant_colors.dart';

import '../service_helper.dart';

class OverviewTab extends StatelessWidget {
  const OverviewTab({Key? key, required this.provider}) : super(key: key);

  final provider;
  @override
  Widget build(BuildContext context) {
    ConstantColors cc = ConstantColors();
    return Container(
      margin: const EdgeInsets.only(top: 16),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        // Text(
        //   provider.serviceAllDetails.serviceDetails.description,
        //   style: TextStyle(
        //     color: cc.greyParagraph,
        //     fontSize: 14,
        //     height: 1.4,
        //   ),
        // ),
        DescInHtml(
          desc: provider.serviceAllDetails['service_details']['description'],
        ),
        const SizedBox(
          height: 20,
        ),
        AutoSizeText(
          'Benefits of the premium package:',
          maxLines: 1,
          style: TextStyle(color: cc.greyFour, fontSize: 19, fontWeight: FontWeight.bold),
        ),
        //checklist
        const SizedBox(
          height: 19,
        ),
        for (int i = 0; i < provider.serviceAllDetails['service_benifits'].length; i++)
          ServiceHelper().checkListCommon(provider.serviceAllDetails['service_benifits'][i]['benifits']),
        //Benefit ===============>

        // const SizedBox(
        //   height: 20,
        // ),
        // AutoSizeText(
        //   'Benefits of the premium package:',
        //   maxLines: 1,
        //   style: TextStyle(
        //       color: cc.greyFour, fontSize: 19, fontWeight: FontWeight.bold),
        // ),
        //checklist
        // const SizedBox(
        //   height: 19,
        // ),
        // for (int i = 0; i < 3; i++)
        //   ServiceHelper().checkListCommon('Face+Body massage free'),
      ]),
    );
  }
}
