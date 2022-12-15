import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';
import 'package:seribujasa/service/auth_services/signup_service.dart';
import 'package:seribujasa/service/rtl_service.dart';
import 'package:seribujasa/view/auth/reset_password/reset_pass_otp_page.dart';
import 'package:seribujasa/view/auth/signup/signup_helper.dart';
import 'package:seribujasa/view/utils/common_helper.dart';
import 'package:seribujasa/view/utils/constant_colors.dart';
import 'package:seribujasa/view/utils/others_helper.dart';

class SignupPhonePass extends StatefulWidget {
  const SignupPhonePass({Key? key, this.passController, this.repeatPassController}) : super(key: key);

  final passController;
  final repeatPassController;

  @override
  _SignupPhonePassState createState() => _SignupPhonePassState();
}

class _SignupPhonePassState extends State<SignupPhonePass> {
  late bool _newpasswordVisible;
  late bool _repeatnewpasswordVisible;

  @override
  void initState() {
    super.initState();
    _newpasswordVisible = false;
    _repeatnewpasswordVisible = false;
  }

  final _formKey = GlobalKey<FormState>();

  bool keepLoggedIn = true;

  @override
  Widget build(BuildContext context) {
    ConstantColors cc = ConstantColors();
    return Consumer<SignupService>(
      builder: (context, provider, child) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Phone number field
              CommonHelper().labelCommon("Phone"),
              Consumer<RtlService>(
                builder: (context, rtlP, child) => IntlPhoneField(
                  decoration: SignupHelper().phoneFieldDecoration(),
                  initialCountryCode: provider.countryCode,
                  textAlign: rtlP.direction == 'ltr' ? TextAlign.left : TextAlign.right,
                  onChanged: (phone) {
                    provider.setCountryCode(phone.countryISOCode);

                    provider.setPhone(phone.number);
                  },
                ),
              ),

              const SizedBox(
                height: 10,
              ),

              //New password =========================>
              CommonHelper().labelCommon("Password"),

              Container(
                  margin: const EdgeInsets.only(bottom: 19),
                  decoration: BoxDecoration(
                      // color: const Color(0xfff2f2f2),
                      borderRadius: BorderRadius.circular(10)),
                  child: TextFormField(
                    controller: widget.passController,
                    textInputAction: TextInputAction.next,
                    obscureText: !_newpasswordVisible,
                    style: const TextStyle(fontSize: 14),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        prefixIcon: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 22.0,
                              width: 40.0,
                              decoration: const BoxDecoration(
                                image:
                                    DecorationImage(image: AssetImage('assets/icons/lock.png'), fit: BoxFit.fitHeight),
                              ),
                            ),
                          ],
                        ),
                        suffixIcon: IconButton(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          icon: Icon(
                            // Based on passwordVisible state choose the icon
                            _newpasswordVisible ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                            color: Colors.grey,
                            size: 22,
                          ),
                          onPressed: () {
                            // Update the state i.e. toogle the state of passwordVisible variable
                            setState(() {
                              _newpasswordVisible = !_newpasswordVisible;
                            });
                          },
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: ConstantColors().greyFive),
                            borderRadius: BorderRadius.circular(9)),
                        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: ConstantColors().primaryColor)),
                        errorBorder: OutlineInputBorder(borderSide: BorderSide(color: ConstantColors().warningColor)),
                        focusedErrorBorder:
                            OutlineInputBorder(borderSide: BorderSide(color: ConstantColors().primaryColor)),
                        hintText: 'Enter password',
                        contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 18)),
                  )),

              //Repeat New password =========================>
              CommonHelper().labelCommon("Repeat password"),

              Container(
                  margin: const EdgeInsets.only(bottom: 19),
                  decoration: BoxDecoration(
                      // color: const Color(0xfff2f2f2),
                      borderRadius: BorderRadius.circular(10)),
                  child: TextFormField(
                    controller: widget.repeatPassController,
                    textInputAction: TextInputAction.next,
                    obscureText: !_repeatnewpasswordVisible,
                    style: const TextStyle(fontSize: 14),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please retype your password';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        prefixIcon: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 22.0,
                              width: 40.0,
                              decoration: const BoxDecoration(
                                image:
                                    DecorationImage(image: AssetImage('assets/icons/lock.png'), fit: BoxFit.fitHeight),
                              ),
                            ),
                          ],
                        ),
                        suffixIcon: IconButton(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          icon: Icon(
                            // Based on passwordVisible state choose the icon
                            _repeatnewpasswordVisible ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                            color: Colors.grey,
                            size: 22,
                          ),
                          onPressed: () {
                            // Update the state i.e. toogle the state of passwordVisible variable
                            setState(() {
                              _repeatnewpasswordVisible = !_repeatnewpasswordVisible;
                            });
                          },
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: ConstantColors().greyFive),
                            borderRadius: BorderRadius.circular(9)),
                        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: ConstantColors().primaryColor)),
                        errorBorder: OutlineInputBorder(borderSide: BorderSide(color: ConstantColors().warningColor)),
                        focusedErrorBorder:
                            OutlineInputBorder(borderSide: BorderSide(color: ConstantColors().primaryColor)),
                        hintText: 'Enter password',
                        contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 18)),
                  )),

              //Login button ==================>
              const SizedBox(
                height: 13,
              ),

              CommonHelper().buttonOrange("Continue", () {
                if (widget.passController.text != widget.repeatPassController.text) {
                  OthersHelper().showToast('Password didn\'t match', Colors.black);
                } else if (widget.passController.text.length < 6) {
                  OthersHelper().showToast('Password must be at least 6 characters', Colors.black);
                } else if (_formKey.currentState!.validate()) {
                  provider.pagecontroller.animateToPage(provider.selectedPage + 1,
                      duration: const Duration(milliseconds: 300), curve: Curves.ease);
                }
              }),

              const SizedBox(
                height: 25,
              ),
              SignupHelper().haveAccount(context),

              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
