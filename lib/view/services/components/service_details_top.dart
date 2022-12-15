import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seribujasa/service/rtl_service.dart';
import 'package:seribujasa/service/service_details_service.dart';
import 'package:seribujasa/view/utils/constant_colors.dart';

import '../../utils/constant_styles.dart';
import '../service_helper.dart';

class ServiceDetailsTop extends StatelessWidget {
  const ServiceDetailsTop({
    Key? key,
    required this.cc,
  }) : super(key: key);

  final ConstantColors cc;

  @override
  Widget build(BuildContext context) {
    return Consumer<ServiceDetailsService>(
      builder: (context, provider, child) => Column(
        children: [
          //title author price details
          Container(
            margin: const EdgeInsets.only(top: 20),
            padding: EdgeInsets.symmetric(horizontal: screenPadding),
            child: Column(children: [
              ServiceTitleAndUser(
                cc: cc,
                title: provider.serviceAllDetails['service_details']['title'],
                userImg: provider.serviceAllDetails['service_seller_image'],
                userName: provider.serviceAllDetails['service_seller_name'],
              ),

              //package price
              Container(
                margin: const EdgeInsets.only(top: 20),
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
                decoration:
                    BoxDecoration(border: Border.all(color: cc.borderColor), borderRadius: BorderRadius.circular(6)),
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  Text(
                    'Our Package',
                    style: TextStyle(color: cc.greyFour, fontSize: 18, fontWeight: FontWeight.w400),
                  ),
                  Consumer<RtlService>(
                    builder: (context, rtlP, child) => Text('${provider.serviceAllDetails['service_details']['price']}',
                      style: TextStyle(color: cc.primaryColor, fontSize: 23, fontWeight: FontWeight.bold),
                    ),
                  ),
                ]),
              ),

              //checklist
              const SizedBox(
                height: 30,
              ),
              for (int i = 0; i < provider.serviceAllDetails['service_includes'].length; i++)
                ServiceHelper().checkListCommon(provider.serviceAllDetails['service_includes'][i]['include_service_title'])
            ]),
          ),
          Container(
            margin: const EdgeInsets.only(top: 20),
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 13),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(width: 1, color: cc.borderColor),
                top: BorderSide(width: 1, color: cc.borderColor),
              ),
            ),
            child: Row(children: [
              //orders completed ========>
              Expanded(
                child: Row(
                  children: [
                    Text(
                      provider.serviceAllDetails['seller_complete_order'].toString(),
                      style: TextStyle(color: cc.successColor, fontSize: 23, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    AutoSizeText(
                      'Orders completed',
                      maxLines: 1,
                      style: TextStyle(color: cc.greyFour, fontSize: 15, fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),
              //vertical border
              Container(
                height: 28,
                width: 1,
                margin: const EdgeInsets.only(left: 10, right: 15),
                color: cc.borderColor,
              ),
              //Sellers ratings ========>
              Row(
                children: [
                  Text(
                    provider.serviceAllDetails['seller_rating'].toString(),
                    style: TextStyle(color: cc.primaryColor, fontSize: 23, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  AutoSizeText(
                    'Seller Ratings',
                    maxLines: 1,
                    style: TextStyle(color: cc.greyFour, fontSize: 15, fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ]),
          ),
        ],
      ),
    );
  }
}

class ServiceTitleAndUser extends StatelessWidget {
  const ServiceTitleAndUser({Key? key, required this.cc, required this.title, this.userImg, required this.userName})
      : super(key: key);
  final ConstantColors cc;
  final String title;
  final userImg;
  final String userName;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: TextStyle(
            color: cc.greyFour,
            fontSize: 19,
            height: 1.4,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        //profile image and name
        Row(
          children: [
            userImg != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: CachedNetworkImage(
                      imageUrl: userImg,
                      placeholder: (context, url) {
                        return Image.asset('assets/images/placeholder.png');
                      },
                      height: 40,
                      width: 40,
                      fit: BoxFit.cover,
                    ),
                  )
                : ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      'assets/images/avatar.png',
                      height: 40,
                      width: 40,
                      fit: BoxFit.cover,
                    ),
                  ),
            const SizedBox(
              width: 10,
            ),
            Text(
              userName,
              style: TextStyle(
                color: cc.greyFour,
                fontSize: 15,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
