import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:seribujasa/firebase_options.dart';
import 'package:seribujasa/service/all_services_service.dart';
import 'package:seribujasa/service/auth_services/change_pass_service.dart';
import 'package:seribujasa/service/auth_services/email_verify_service.dart';
import 'package:seribujasa/service/auth_services/facebook_login_service.dart';
import 'package:seribujasa/service/auth_services/google_sign_service.dart';
import 'package:seribujasa/service/auth_services/login_service.dart';
import 'package:seribujasa/service/auth_services/logout_service.dart';
import 'package:seribujasa/service/auth_services/reset_password_service.dart';
import 'package:seribujasa/service/book_confirmation_service.dart';
import 'package:seribujasa/service/book_steps_service.dart';
import 'package:seribujasa/service/booking_services/book_service.dart';
import 'package:seribujasa/service/booking_services/coupon_service.dart';
import 'package:seribujasa/service/booking_services/personalization_service.dart';
import 'package:seribujasa/service/booking_services/place_order_service.dart';
import 'package:seribujasa/service/booking_services/shedule_service.dart';
import 'package:seribujasa/service/country_states_service.dart';
import 'package:seribujasa/service/home_services/category_service.dart';
import 'package:seribujasa/service/home_services/recent_services_service.dart';
import 'package:seribujasa/service/home_services/slider_service.dart';
import 'package:seribujasa/service/home_services/top_all_services_service.dart';
import 'package:seribujasa/service/home_services/top_rated_services_service.dart';
import 'package:seribujasa/service/leave_feedback_service.dart';
import 'package:seribujasa/service/my_orders_service.dart';
import 'package:seribujasa/service/order_details_service.dart';
import 'package:seribujasa/service/pay_services/bank_transfer_service.dart';
import 'package:seribujasa/service/profile_edit_service.dart';
import 'package:seribujasa/service/profile_service.dart';
import 'package:seribujasa/service/rtl_service.dart';
import 'package:seribujasa/service/saved_items_service.dart';
import 'package:seribujasa/service/serachbar_with_dropdown_service.dart';
import 'package:seribujasa/service/service_details_service.dart';
import 'package:seribujasa/service/auth_services/signup_service.dart';
import 'package:seribujasa/service/serviceby_category_service.dart';
import 'package:seribujasa/service/support_ticket/create_ticket_service.dart';
import 'package:seribujasa/service/support_ticket/support_messages_service.dart';
import 'package:seribujasa/service/support_ticket/support_ticket_service.dart';
import 'package:seribujasa/view/intro/splash.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());

//get user id, so that we can clear everything cached by provider when user logs out and logs in again
  SharedPreferences prefs = await SharedPreferences.getInstance();
  userId = prefs.getInt('userId');
}

int? userId;

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return MultiProvider(
      key: ObjectKey(userId),
      providers: [
        ChangeNotifierProvider(create: (_) => CountryStatesService()),
        ChangeNotifierProvider(create: (_) => SignupService()),
        ChangeNotifierProvider(create: (_) => BookConfirmationService()),
        ChangeNotifierProvider(create: (_) => BookStepsService()),
        ChangeNotifierProvider(create: (_) => AllServicesService()),
        ChangeNotifierProvider(create: (_) => LoginService()),
        ChangeNotifierProvider(create: (_) => ResetPasswordService()),
        ChangeNotifierProvider(create: (_) => LogoutService()),
        ChangeNotifierProvider(create: (_) => ChangePassService()),
        ChangeNotifierProvider(create: (_) => ProfileService()),
        ChangeNotifierProvider(create: (_) => SliderService()),
        ChangeNotifierProvider(create: (_) => CategoryService()),
        ChangeNotifierProvider(create: (_) => TopRatedServicesSerivce()),
        ChangeNotifierProvider(create: (_) => ProfileEditService()),
        ChangeNotifierProvider(create: (_) => RecentServicesService()),
        ChangeNotifierProvider(create: (_) => SavedItemService()),
        ChangeNotifierProvider(create: (_) => ServiceDetailsService()),
        ChangeNotifierProvider(create: (_) => LeaveFeedbackService()),
        ChangeNotifierProvider(create: (_) => GoogleSignInService()),
        ChangeNotifierProvider(create: (_) => BankTransferService()),
        ChangeNotifierProvider(create: (_) => ServiceByCategoryService()),
        ChangeNotifierProvider(create: (_) => PersonalizationService()),
        ChangeNotifierProvider(create: (_) => BookService()),
        ChangeNotifierProvider(create: (_) => BookService()),
        ChangeNotifierProvider(create: (_) => SheduleService()),
        ChangeNotifierProvider(create: (_) => CouponService()),
        ChangeNotifierProvider(create: (_) => SearchBarWithDropdownService()),
        ChangeNotifierProvider(create: (_) => MyOrdersService()),
        ChangeNotifierProvider(create: (_) => PlaceOrderService()),
        ChangeNotifierProvider(create: (_) => FacebookLoginService()),
        ChangeNotifierProvider(create: (_) => SupportTicketService()),
        ChangeNotifierProvider(create: (_) => SupportMessagesService()),
        ChangeNotifierProvider(create: (_) => CreateTicketService()),
        ChangeNotifierProvider(create: (_) => EmailVerifyService()),
        ChangeNotifierProvider(create: (_) => OrderDetailsService()),
        ChangeNotifierProvider(create: (_) => RtlService()),
        ChangeNotifierProvider(create: (_) => TopAllServicesService()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Qixer',
        builder: (context, rtlchild) {
          return Consumer<RtlService>(
            builder: (context, rtlP, child) => Directionality(
              textDirection: rtlP.direction == 'ltr' ? TextDirection.ltr : TextDirection.rtl,
              child: rtlchild!,
            ),
          );
        },
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
