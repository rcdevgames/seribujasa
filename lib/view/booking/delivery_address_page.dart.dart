import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:seribujasa/service/booking_services/book_service.dart';
import 'package:seribujasa/service/booking_services/personalization_service.dart';
import 'package:seribujasa/service/profile_service.dart';
import 'package:seribujasa/service/rtl_service.dart';
import 'package:seribujasa/view/auth/signup/signup_helper.dart';
import 'package:seribujasa/view/booking/book_confirmation_page.dart';
import 'package:seribujasa/view/booking/booking_helper.dart';
import 'package:seribujasa/view/utils/common_helper.dart';
import 'package:seribujasa/view/utils/constant_colors.dart';
import 'package:seribujasa/view/utils/constant_styles.dart';

import '../../service/book_steps_service.dart';
import '../utils/custom_input.dart';
import 'components/steps.dart';

class DeliveryAddressPage extends StatefulWidget {
  const DeliveryAddressPage({Key? key}) : super(key: key);

  @override
  _DeliveryAddressPageState createState() => _DeliveryAddressPageState();
}

class _DeliveryAddressPageState extends State<DeliveryAddressPage> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController postCodeController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController notesController = TextEditingController();

  String? countryCode;

  @override
  void initState() {
    super.initState();

    print(Provider.of<ProfileService>(context, listen: false).profileDetails.userDetails.countryCode);
    countryCode = Provider.of<ProfileService>(context, listen: false).profileDetails.userDetails.countryCode;

    userNameController.text = Provider.of<ProfileService>(context, listen: false).profileDetails.userDetails.name ?? '';
    emailController.text = Provider.of<ProfileService>(context, listen: false).profileDetails.userDetails.email ?? '';

    phoneController.text = Provider.of<ProfileService>(context, listen: false).profileDetails.userDetails.phone ?? '';
    postCodeController.text =
        Provider.of<ProfileService>(context, listen: false).profileDetails.userDetails.postCode ?? '';
    addressController.text =
        Provider.of<ProfileService>(context, listen: false).profileDetails.userDetails.address ?? '';

    addressController.text =
        Provider.of<ProfileService>(context, listen: false).profileDetails.userDetails.address ?? '';
  }

  var phoneNumber;

  @override
  Widget build(BuildContext context) {
    ConstantColors cc = ConstantColors();
    return Listener(
      onPointerDown: (_) {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.focusedChild?.unfocus();
        }
      },
      child: WillPopScope(
        onWillPop: () {
          BookStepsService().decreaseStep(context);
          return Future.value(true);
        },
        child: Scaffold(
          // resizeToAvoidBottomInset: false,
          backgroundColor: Colors.white,
          appBar: CommonHelper().appbarForBookingPages('Address', context),
          body: Consumer<PersonalizationService>(
            builder: (context, personalizatioProvider, child) => Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    physics: physicsCommon,
                    child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: screenPadding,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //Circular Progress bar
                            personalizatioProvider.isOnline == 0 ? Steps(cc: cc) : Container(),

                            CommonHelper().titleCommon('Booking Information'),

                            const SizedBox(
                              height: 22,
                            ),

                            Form(
                              key: _formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // name ============>
                                  CommonHelper().labelCommon("Name"),

                                  CustomInput(
                                    controller: userNameController,
                                    validation: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter your name';
                                      }
                                      return null;
                                    },
                                    hintText: "Enter your name",
                                    icon: 'assets/icons/user.png',
                                    textInputAction: TextInputAction.next,
                                  ),
                                  const SizedBox(
                                    height: 2,
                                  ),

                                  //Email ============>
                                  CommonHelper().labelCommon("Email"),

                                  CustomInput(
                                    controller: emailController,
                                    validation: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter your email';
                                      }
                                      return null;
                                    },
                                    hintText: "Enter your email",
                                    icon: 'assets/icons/email-grey.png',
                                    textInputAction: TextInputAction.next,
                                  ),
                                  const SizedBox(
                                    height: 2,
                                  ),

                                  //Phone number field
                                  CommonHelper().labelCommon("Phone"),
                                  CustomInput(
                                    controller: phoneController,
                                    validation: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Masukan No HP / Telp';
                                      }
                                      return null;
                                    },
                                    hintText: "Enter your email",
                                    icon: 'assets/icons/email.png',
                                    textInputAction: TextInputAction.next,
                                  ),
                                  const SizedBox(
                                    height: 2,
                                  ),
                                  // Consumer<RtlService>(
                                  //   builder: (context, rtlP, child) => IntlPhoneField(
                                  //     controller: phoneController,
                                  //     textAlign: rtlP.direction == 'ltr' ? TextAlign.left : TextAlign.right,
                                  //     decoration: SignupHelper().phoneFieldDecoration(),
                                  //     initialCountryCode: countryCode,
                                  //     onChanged: (phone) {
                                  //       print(phone.completeNumber);
                                  //       // phoneController.text = phone.completeNumber;
                                  //     },
                                  //   ),
                                  // ),

                                  personalizatioProvider.isOnline == 0
                                      ? Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            CommonHelper().labelCommon("Post code"),

                                            CustomInput(
                                              controller: postCodeController,
                                              validation: (value) {
                                                if (value == null || value.isEmpty) {
                                                  return 'Please enter post code';
                                                }
                                                return null;
                                              },
                                              hintText: "Enter your post code",
                                              icon: 'assets/icons/location.png',
                                              textInputAction: TextInputAction.next,
                                            ),

                                            //Address ============>

                                            const SizedBox(
                                              height: 2,
                                            ),
                                            CommonHelper().labelCommon("Your address"),

                                            CustomInput(
                                              controller: addressController,
                                              validation: (value) {
                                                if (value == null || value.isEmpty) {
                                                  return 'Please enter your address';
                                                }
                                                return null;
                                              },
                                              hintText: "Enter your address",
                                              icon: 'assets/icons/location.png',
                                              textInputAction: TextInputAction.next,
                                            ),
                                          ],
                                        )
                                      : Container(),
                                  // const SizedBox(
                                  //   height: 2,
                                  // ),
                                  // CommonHelper().labelCommon("Order note"),

                                  // TextareaField(
                                  //   hintText: 'e.g. come with ideal brushes...',
                                  //   notesController: notesController,
                                  // ),
                                  const SizedBox(
                                    height: 100,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )),
                  ),
                ),

                ///Next button
                Container(
                  height: 110,
                  padding: EdgeInsets.only(left: screenPadding, top: 30, right: screenPadding),
                  decoration: BookingHelper().bottomSheetDecoration(),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    CommonHelper().buttonOrange("Next", () {
                      if (_formKey.currentState!.validate()) {
                        //increase page steps by one
                        BookStepsService().onNext(context);
                        //set delivery address informations so that we can use it later
                        Provider.of<BookService>(context, listen: false).setAddress(
                            userNameController.text,
                            emailController.text,
                            phoneController.text,
                            // phoneNumber,
                            postCodeController.text,
                            addressController.text,
                            notesController.text);
                        Navigator.push(context,
                            PageTransition(type: PageTransitionType.rightToLeft, child: const BookConfirmationPage()));
                      }
                    }),
                  ]),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
