import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seribujasa/service/auth_services/facebook_login_service.dart';
import 'package:seribujasa/service/auth_services/google_sign_service.dart';
import 'package:seribujasa/service/profile_service.dart';
import 'package:seribujasa/view/tabs/settings/components/settings_page_grid.dart';
import 'package:seribujasa/view/tabs/settings/password/change_password_page.dart';
import 'package:seribujasa/view/tabs/settings/profile_edit.dart';
import 'package:seribujasa/view/tabs/settings/settings_helper.dart';
import 'package:seribujasa/view/tabs/settings/supports/my_tickets_page.dart';
import 'package:seribujasa/view/utils/common_helper.dart';
import 'package:seribujasa/view/utils/constant_colors.dart';
import 'package:seribujasa/view/utils/constant_styles.dart';
import 'package:seribujasa/view/utils/others_helper.dart';

import '../../booking/booking_helper.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ConstantColors cc = ConstantColors();

    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            physics: physicsCommon,
            child: Consumer<ProfileService>(
              builder: (context, profileProvider, child) => profileProvider.profileDetails != null
                  ? profileProvider.profileDetails != 'error'
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: screenPadding),
                              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                //profile image, name ,desc
                                Column(
                                  children: [
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    //Profile image section =======>
                                    InkWell(
                                      highlightColor: Colors.transparent,
                                      splashColor: Colors.transparent,
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute<void>(
                                            builder: (BuildContext context) => ProfileEditPage(),
                                          ),
                                        );
                                      },
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          profileProvider.profileImage != null
                                              ? CommonHelper().profileImage(profileProvider.profileImage, 62, 62)
                                              : ClipRRect(
                                                  borderRadius: BorderRadius.circular(8),
                                                  child: Image.asset(
                                                    'assets/images/avatar.png',
                                                    height: 62,
                                                    width: 62,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),

                                          const SizedBox(
                                            height: 12,
                                          ),

                                          //user name
                                          CommonHelper()
                                              .titleCommon(profileProvider.profileDetails.userDetails.name ?? ''),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          //phone
                                          CommonHelper().paragraphCommon(
                                              profileProvider.profileDetails.userDetails.phone ?? '', TextAlign.center),
                                          // const SizedBox(
                                          //   height: 10,
                                          // ),
                                          profileProvider.profileDetails.userDetails.about != null
                                              ? CommonHelper().paragraphCommon(
                                                  profileProvider.profileDetails.userDetails.about, TextAlign.center)
                                              : Container(),
                                        ],
                                      ),
                                    ),

                                    //Grid cards
                                    SettingsPageGrid(cc: cc),
                                  ],
                                ),

                                //
                              ]),
                            ),
                            SettingsHelper().borderBold(30, 20),

                            // Personal information ==========>
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: screenPadding),
                              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                CommonHelper().titleCommon('Personal informations'),
                                const SizedBox(
                                  height: 25,
                                ),
                                BookingHelper()
                                    .bRow('null', 'Email', profileProvider.profileDetails.userDetails.email ?? ''),
                                BookingHelper().bRow(
                                    'null', 'City', profileProvider.profileDetails.userDetails.city.serviceCity ?? ''),
                                BookingHelper().bRow(
                                    'null', 'Area', profileProvider.profileDetails.userDetails.area.serviceArea ?? ''),
                                BookingHelper().bRow('null', 'Country',
                                    profileProvider.profileDetails.userDetails.country.country ?? ''),
                                BookingHelper().bRow(
                                    'null', 'Post Code', profileProvider.profileDetails.userDetails.postCode ?? ''),
                                BookingHelper().bRow(
                                    'null', 'Address', profileProvider.profileDetails.userDetails.address ?? '',
                                    lastBorder: false),
                              ]),
                            ),

                            SettingsHelper().borderBold(35, 8),

                            //Other settings options ========>
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              child: Column(children: [
                                SettingsHelper().settingOption('assets/svg/message-circle.svg', 'Support Ticket', () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute<void>(
                                      builder: (BuildContext context) => const MyTicketsPage(),
                                    ),
                                  );
                                }),
                                CommonHelper().dividerCommon(),
                                SettingsHelper().settingOption('assets/svg/profile-edit.svg', 'Edit Profile', () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute<void>(
                                      builder: (BuildContext context) => ProfileEditPage(),
                                    ),
                                  );
                                }),
                                CommonHelper().dividerCommon(),
                                SettingsHelper().settingOption('assets/svg/lock-circle.svg', 'Change Password', () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute<void>(
                                      builder: (BuildContext context) => const ChangePasswordPage(),
                                    ),
                                  );
                                }),
                              ]),
                            ),

                            // logout
                            SettingsHelper().borderBold(12, 5),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              child: Column(children: [
                                SettingsHelper().settingOption('assets/svg/logout-circle.svg', 'Logout', () {
                                  SettingsHelper().logoutPopup(context);
                                }),
                                sizedBox20()
                              ]),
                            )
                          ],
                        )
                      : OthersHelper().showError(context)
                  : Container(
                      alignment: Alignment.center,
                      height: MediaQuery.of(context).size.height - 150,
                      child: OthersHelper().showLoading(cc.primaryColor),
                    ),
            ),
          ),
        ));
  }
}
