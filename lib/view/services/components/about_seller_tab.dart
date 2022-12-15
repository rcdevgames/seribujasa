import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:seribujasa/service/common_service.dart';
import 'package:seribujasa/view/services/services_of_user.dart';
import 'package:seribujasa/view/utils/constant_colors.dart';

import '../service_helper.dart';

class AboutSellerTab extends StatelessWidget {
  const AboutSellerTab({Key? key, required this.provider}) : super(key: key);
  final provider;
  @override
  Widget build(BuildContext context) {
    ConstantColors cc = ConstantColors();
    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        //profile image, name and completed orders
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute<void>(
                builder: (BuildContext context) => const ServicesOfUser(),
              ),
            );
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              provider.serviceAllDetails['service_seller_image'] != null ?
              ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: CachedNetworkImage(
                  imageUrl: provider.serviceAllDetails['service_seller_image'],
                  placeholder: (context, url) {
                    return Image.asset('assets/images/placeholder.png');
                  },
                  height: 60,
                  width: 60,
                  fit: BoxFit.cover,
                ),
              ) : ClipRRect(
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    provider.serviceAllDetails['service_seller_name'],
                    style: TextStyle(color: cc.greyFour, fontSize: 17, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Row(
                    children: [
                      Text(
                        'Order Completed',
                        style: TextStyle(
                          color: cc.primaryColor,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        '(${provider.serviceAllDetails['seller_complete_order'].toString()})',
                        style: TextStyle(
                          color: cc.greyParagraph,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
              border: Border.all(color: cc.borderColor, width: 1), borderRadius: BorderRadius.circular(6)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: ServiceHelper().serviceDetails('From', provider.serviceAllDetails['seller_from'] ?? ""),
                  ),
                  Expanded(
                      child: ServiceHelper().serviceDetails(
                          'Order Completion Rate', '${provider.serviceAllDetails['order_completion_rate']}%'))
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  Expanded(
                    child: ServiceHelper()
                        .serviceDetails('Seller Since', getYear(DateTime.parse(provider.serviceAllDetails['seller_since']['created_at']))),
                  ),
                  Expanded(
                      child: ServiceHelper()
                          .serviceDetails('Order Completed', provider.serviceAllDetails['seller_complete_order'].toString()))
                ],
              ),
              // const SizedBox(
              //   height: 30,
              // ),
              // Text(
              //   'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less.',
              //   style: TextStyle(
              //     color: cc.greyParagraph,
              //     fontSize: 14,
              //     height: 1.4,
              //   ),
              // ),
            ],
          ),
        ),
      ]),
    );
  }
}
