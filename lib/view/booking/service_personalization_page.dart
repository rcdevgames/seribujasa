import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:seribujasa/service/booking_services/book_service.dart';
import 'package:seribujasa/service/booking_services/personalization_service.dart';
import 'package:seribujasa/service/booking_services/shedule_service.dart';
import 'package:seribujasa/service/common_service.dart';
import 'package:seribujasa/view/booking/components/extras.dart';
import 'package:seribujasa/view/booking/delivery_address_page.dart.dart';
import 'package:seribujasa/view/booking/service_schedule_page.dart';
import 'package:seribujasa/view/utils/common_helper.dart';
import 'package:seribujasa/view/utils/constant_colors.dart';
import 'package:seribujasa/view/utils/constant_styles.dart';
import 'package:seribujasa/view/utils/others_helper.dart';

import '../../service/book_steps_service.dart';
import 'booking_helper.dart';
import 'components/included.dart';
import 'components/steps.dart';

class ServicePersonalizationPage extends StatefulWidget {
  const ServicePersonalizationPage({
    Key? key,
  }) : super(key: key);

  @override
  _ServicePersonalizationPageState createState() => _ServicePersonalizationPageState();
}

class _ServicePersonalizationPageState extends State<ServicePersonalizationPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ConstantColors cc = ConstantColors();
    return WillPopScope(
      onWillPop: () {
        // BookStepsService().decreaseStep(context);
        return Future.value(true);
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar:
            CommonHelper().appbarForBookingPages('Personalize', context, isPersonalizatioPage: true, extraFunction: () {
          //Whatever quanity or other extra user has selected.. set the totalprice to the default service price again
          Provider.of<BookService>(context, listen: false)
              .setTotalPrice(Provider.of<PersonalizationService>(context, listen: false).defaultprice);

          //set default steps to 1 again
        }),
        body: SingleChildScrollView(
          physics: physicsCommon,
          child: Consumer<PersonalizationService>(
              builder: (context, provider, child) => provider.isloading == false
                  ? provider.serviceExtraData != 'error'
                      ? Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: screenPadding,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              provider.isOnline == 0 ? Steps(cc: cc) : Container(),

                              provider.serviceExtraData['service']['is_service_online'] != 1
                                  ? Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        CommonHelper().titleCommon('What’s included:'),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Included(
                                          cc: cc,
                                          data: provider.includedList,
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                      ],
                                    )
                                  : Container(),

                              provider.extrasList.isNotEmpty
                                  ? Extras(
                                      cc: cc,
                                      additionalServices: provider.extrasList,
                                      serviceBenefits: provider.serviceExtraData['service']['service_benifit'],
                                    )
                                  : Container(),

                              // button ==================>
                              const SizedBox(
                                height: 27,
                              ),
                              // CommonHelper().buttonOrange("Next", () {
                              //   Navigator.push(
                              //     context,
                              //     MaterialPageRoute<void>(
                              //       builder: (BuildContext context) =>
                              //           const ServiceSchedulePage(),
                              //     ),
                              //   );
                              // }),

                              const SizedBox(
                                height: 147,
                              ),
                            ],
                          ))
                      : const Text("Something went wrong")
                  : Container(
                      height: MediaQuery.of(context).size.height - 250,
                      alignment: Alignment.center,
                      child: OthersHelper().showLoading(cc.primaryColor),
                    )),
        ),
        bottomSheet: Consumer<BookService>(
          builder: (context, provider, child) => Consumer<PersonalizationService>(
            builder: (context, personalizationProvider, child) => Container(
              height: 157,
              padding: EdgeInsets.only(left: screenPadding, top: 30, right: screenPadding),
              decoration: BookingHelper().bottomSheetDecoration(),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                BookingHelper().detailsPanelRow('Total', 0, '${provider.totalPrice}'),
                const SizedBox(
                  height: 23,
                ),
                CommonHelper().buttonOrange("Next", () {
                  if (personalizationProvider.isloading == false) {
                    if (personalizationProvider.isOnline == 1) {
                      //if it is an online service no need to show service schedule and choose location page

                      Navigator.push(context,
                          PageTransition(type: PageTransitionType.rightToLeft, child: const DeliveryAddressPage()));
                      BookStepsService().onNext(context);
                    } else {
                      //increase page steps by one
                      BookStepsService().onNext(context);
                      //fetch shedule
                      Provider.of<SheduleService>(context, listen: false)
                          .fetchShedule(provider.sellerId, firstThreeLetter(DateTime.now()));

                      //go to shedule page
                      Navigator.push(context,
                          PageTransition(type: PageTransitionType.rightToLeft, child: const ServiceSchedulePage()));
                    }
                  }
                }),
                const SizedBox(
                  height: 30,
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
