import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seribujasa/service/booking_services/book_service.dart';
import 'package:seribujasa/service/service_details_service.dart';
import 'package:seribujasa/view/booking/booking_location_page.dart';
import 'package:seribujasa/view/booking/service_personalization_page.dart';
import 'package:seribujasa/view/services/components/about_seller_tab.dart';
import 'package:seribujasa/view/services/components/image_big.dart';
import 'package:seribujasa/view/services/components/overview_tab.dart';
import 'package:seribujasa/view/services/components/review_tab.dart';
import 'package:seribujasa/view/services/review/write_review_page.dart';
import 'package:seribujasa/view/utils/constant_colors.dart';
import 'package:seribujasa/view/utils/constant_styles.dart';
import 'package:seribujasa/view/utils/others_helper.dart';

import '../../service/booking_services/personalization_service.dart';
import '../utils/common_helper.dart';
import 'components/service_details_top.dart';

class ServiceDetailsPage extends StatefulWidget {
  const ServiceDetailsPage({
    Key? key,
  }) : super(key: key);

  // final serviceId;

  @override
  State<ServiceDetailsPage> createState() => _ServiceDetailsPageState();
}

class _ServiceDetailsPageState extends State<ServiceDetailsPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _tabIndex = 0;
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(_handleTabSelection);

    // Provider.of<ServiceDetailsService>(context, listen: false)
    //     .fetchServiceDetails(widget.serviceId);
    super.initState();
  }

  _handleTabSelection() {
    if (_tabController.indexIsChanging) {
      setState(() {
        _tabIndex = _tabController.index;
      });
    }
  }

  int currentTab = 0;

  @override
  Widget build(BuildContext context) {
    ConstantColors cc = ConstantColors();
    return Scaffold(
      backgroundColor: Colors.white,
      body: Consumer<ServiceDetailsService>(
        builder: (context, provider, child) => provider.isloading == false
            ? provider.serviceAllDetails != 'error'
                ? Column(
                    children: [
                      Expanded(
                        child: ListView(
                          padding: EdgeInsets.zero,
                          children: [
                            Column(
                              children: [
                                // Image big
                                ImageBig(
                                  serviceName: 'Service Name',
                                  imageLink: provider.serviceAllDetails['service_image'],
                                ),

                                //package price
                                ServiceDetailsTop(cc: cc),
                              ],
                            ),
                            Container(
                              color: Colors.white,
                              padding: const EdgeInsets.symmetric(horizontal: 25),
                              margin: const EdgeInsets.only(top: 20, bottom: 20),
                              child: Column(
                                children: <Widget>[
                                  TabBar(
                                    onTap: (value) {
                                      setState(() {
                                        currentTab = value;
                                      });
                                    },
                                    labelColor: cc.primaryColor,
                                    unselectedLabelColor: cc.greyFour,
                                    indicatorColor: cc.primaryColor,
                                    unselectedLabelStyle:
                                        TextStyle(color: cc.greyParagraph, fontWeight: FontWeight.normal),
                                    controller: _tabController,
                                    tabs: const [
                                      Tab(text: 'Overview'),
                                      Tab(text: 'About seller'),
                                      Tab(text: 'Review'),
                                    ],
                                  ),
                                  Container(
                                    child: [
                                      OverviewTab(
                                        provider: provider,
                                      ),
                                      AboutSellerTab(
                                        provider: provider,
                                      ),
                                      ReviewTab(
                                        provider: provider,
                                      ),
                                    ][_tabIndex],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      //Book now button
                      CommonHelper().dividerCommon(),
                      //Button
                      sizedBox20(),

                      Container(
                          padding: EdgeInsets.symmetric(horizontal: screenPadding),
                          child: Column(
                            children: [
                              currentTab == 2
                                  ? Column(
                                      children: [
                                        CommonHelper().borderButtonOrange("Write a review", () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute<void>(
                                              builder: (BuildContext context) => WriteReviewPage(
                                                serviceId: provider.serviceAllDetails['service_details']['id'],
                                                title: provider.serviceAllDetails['service_details']['title'],
                                                userImg: provider.serviceAllDetails['service_seller_image'],
                                                userName: provider.serviceAllDetails['service_seller_name'],
                                              ),
                                            ),
                                          );
                                        }),
                                        const SizedBox(
                                          height: 14,
                                        ),
                                      ],
                                    )
                                  : Container(),
                              CommonHelper().buttonOrange("Book Appointment", () {
                                Provider.of<BookService>(context, listen: false).setData(
                                    provider.serviceAllDetails['service_details']['id'],
                                    provider.serviceAllDetails['service_details']['title'],
                                    provider.serviceAllDetails['service_image'],
                                    provider.serviceAllDetails['service_details']['price'].toString,
                                    provider.serviceAllDetails['service_details']['seller_id']);

                                //==========>
                                Provider.of<PersonalizationService>(context, listen: false)
                                    .setDefaultPrice(Provider.of<BookService>(context, listen: false).totalPrice);
                                //fetch service extra
                                Provider.of<PersonalizationService>(context, listen: false)
                                    .fetchServiceExtra(provider.serviceAllDetails['service_details']['id'], context);

                                //=============>
                                Navigator.push(
                                  context,
                                  MaterialPageRoute<void>(
                                    builder: (BuildContext context) => const ServicePersonalizationPage(),
                                  ),
                                );
                              }),
                            ],
                          )),
                      const SizedBox(
                        height: 30,
                      ),
                    ],
                  )
                : const Text("Something went wrong")
            : OthersHelper().showLoading(cc.primaryColor),
      ),
    );
  }
}
