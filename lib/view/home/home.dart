import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:seribujasa/service/all_services_service.dart';
import 'package:seribujasa/service/home_services/category_service.dart';
import 'package:seribujasa/service/home_services/recent_services_service.dart';
import 'package:seribujasa/service/home_services/slider_service.dart';
import 'package:seribujasa/service/home_services/top_rated_services_service.dart';
import 'package:seribujasa/service/profile_service.dart';
import 'package:seribujasa/service/rtl_service.dart';
import 'package:seribujasa/service/serachbar_with_dropdown_service.dart';
import 'package:seribujasa/view/home/categories/all_categories_page.dart';
import 'package:seribujasa/view/home/components/categories.dart';
import 'package:seribujasa/view/home/components/recent_services.dart';
import 'package:seribujasa/view/home/top_all_service_page.dart';
import 'package:seribujasa/view/search/search_bar_page_with_dropdown.dart';
import 'package:seribujasa/view/home/components/slider_home.dart';
import 'package:seribujasa/view/home/components/top_rated_services.dart';
import 'package:seribujasa/view/home/homepage_helper.dart';
import 'package:seribujasa/view/services/all_services_page.dart';
import 'package:seribujasa/view/tabs/settings/profile_edit.dart';
import 'package:seribujasa/view/utils/common_helper.dart';
import 'package:seribujasa/view/utils/constant_colors.dart';
import 'package:seribujasa/view/utils/responsive.dart';

import '../utils/constant_styles.dart';
import 'components/section_title.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  void initState() {
    super.initState();
    Provider.of<SliderService>(context, listen: false).loadSlider();
    Provider.of<CategoryService>(context, listen: false).fetchCategory();
    Provider.of<TopRatedServicesSerivce>(context, listen: false).fetchTopService();
    Provider.of<RecentServicesService>(context, listen: false).fetchRecentService();
    Provider.of<ProfileService>(context, listen: false).getProfileDetails();
    Provider.of<SearchBarWithDropdownService>(context, listen: false).fetchStates();
    Provider.of<RtlService>(context, listen: false).fetchCurrency();
    Provider.of<RtlService>(context, listen: false).fetchDirection();
  }

  @override
  Widget build(BuildContext context) {
    print('screen width: $screenWidth');
    ConstantColors cc = ConstantColors();
    return Listener(
      onPointerDown: (_) {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.focusedChild?.unfocus();
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            physics: physicsCommon,
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const SizedBox(
                height: 20,
              ),
              //name and profile image
              Consumer<ProfileService>(
                builder: (context, profileProvider, child) => profileProvider.profileDetails != null
                    ? profileProvider.profileDetails != 'error'
                        ? InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute<void>(
                                  builder: (BuildContext context) => ProfileEditPage(),
                                ),
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 25),
                              child: Row(
                                children: [
                                  //name
                                  Expanded(
                                      child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Welcome!',
                                        style: TextStyle(
                                          color: cc.greyParagraph,
                                          fontSize: 14,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        profileProvider.profileDetails.userDetails.name ?? '',
                                        style: TextStyle(
                                          color: cc.greyFour,
                                          fontSize: 19,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  )),

                                  //profile image
                                  profileProvider.profileImage != null
                                      ? CommonHelper().profileImage(profileProvider.profileImage, 52, 52)
                                      : ClipRRect(
                                          borderRadius: BorderRadius.circular(8),
                                          child: Image.asset(
                                            'assets/images/avatar.png',
                                            height: 52,
                                            width: 52,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                ],
                              ),
                            ),
                          )
                        : const Text('Couldn\'t load user profile info')
                    : Container(),
              ),

              //Search bar ========>
              const SizedBox(
                height: 30,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                margin: const EdgeInsets.only(bottom: 15),
                child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          PageTransition(
                              type: PageTransitionType.rightToLeft,
                              child: SearchBarPageWithDropdown(
                                cc: cc,
                              )));
                    },
                    child: HomepageHelper().searchbar(context)),
              ),
              // Container(
              //   padding: const EdgeInsets.symmetric(horizontal: 25),
              //   child: SearchBar(
              //     cc: cc,
              //     isHomePage: true,
              //   ),
              // ),
              // Container(
              //   padding: const EdgeInsets.symmetric(horizontal: 25),
              //   child: SearchBarWithDropdown(
              //     cc: cc,
              //     isHomePage: true,
              //   ),
              // ),

              const SizedBox(
                height: 10,
              ),
              CommonHelper().dividerCommon(),
              const SizedBox(
                height: 25,
              ),

              //Slider
              Consumer<SliderService>(
                  builder: (context, provider, child) => provider.sliderImageList.isNotEmpty
                      ? SliderHome(
                          cc: cc,
                          sliderDetailsList: provider.sliderDetailsList,
                          sliderImageList: provider.sliderImageList,
                        )
                      : Container()),

              Container(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //see all ============>
                    const SizedBox(
                      height: 25,
                    ),

                    SectionTitle(
                      cc: cc,
                      title: 'Browse categories',
                      pressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute<void>(
                            builder: (BuildContext context) => const AllCategoriesPage(),
                          ),
                        );
                      },
                    ),

                    const SizedBox(
                      height: 18,
                    ),

                    //Categories =============>
                    Categories(
                      cc: cc,
                    ),

                    //Top rated sellers ========>

                    TopRatedServices(cc: cc),

                    //Recent service ========>

                    RecentServices(cc: cc),

                    //Discount images
                    const SizedBox(
                      height: 25,
                    ),
                  ],
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
