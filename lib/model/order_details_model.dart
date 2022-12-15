// To parse this JSON data, do
//
//     final orderDetailsModel = orderDetailsModelFromJson(jsonString);

import 'dart:convert';

OrderDetailsModel orderDetailsModelFromJson(String str) =>
    OrderDetailsModel.fromJson(json.decode(str));

String orderDetailsModelToJson(OrderDetailsModel data) =>
    json.encode(data.toJson());

class OrderDetailsModel {
  OrderDetailsModel({
    required this.orderInfo,
  });

  OrderInfo orderInfo;

  factory OrderDetailsModel.fromJson(Map<String, dynamic> json) =>
      OrderDetailsModel(
        orderInfo: OrderInfo.fromJson(json["orderInfo"]),
      );

  Map<String, dynamic> toJson() => {
        "orderInfo": orderInfo.toJson(),
      };
}

class OrderInfo {
  OrderInfo({
    this.id,
    this.serviceId,
    this.sellerId,
    this.buyerId,
    this.name,
    this.email,
    this.phone,
    this.postCode,
    this.address,
    this.city,
    this.area,
    this.country,
    this.date,
    this.schedule,
    this.packageFee,
    this.extraService,
    this.subTotal,
    this.tax,
    this.total,
    this.couponCode,
    this.couponType,
    this.couponAmount,
    this.commissionType,
    this.commissionCharge,
    this.commissionAmount,
    this.paymentGateway,
    this.paymentStatus,
    this.status,
    this.isOrderOnline,
    this.orderCompleteRequest,
    this.cancelOrderMoneyReturn,
    this.transactionId,
    this.orderNote,
    this.manualPaymentImage,
  });

  int? id;
  int? serviceId;
  int? sellerId;
  int? buyerId;
  String? name;
  String? email;
  String? phone;
  String? postCode;
  String? address;
  int? city;
  int? area;
  int? country;
  String? date;
  String? schedule;
  String? packageFee;
  String? extraService;
  String? subTotal;
  String? tax;
  String? total;
  dynamic couponCode;
  String? couponType;
  int? couponAmount;
  String? commissionType;
  int? commissionCharge;
  double? commissionAmount;
  String? paymentGateway;
  String? paymentStatus;
  int? status;
  int? isOrderOnline;
  int? orderCompleteRequest;
  int? cancelOrderMoneyReturn;
  dynamic transactionId;
  dynamic orderNote;

  dynamic manualPaymentImage;

  factory OrderInfo.fromJson(Map<String, dynamic> json) => OrderInfo(
        id: json["id"],
        serviceId: json["service_id"],
        sellerId: json["seller_id"],
        buyerId: json["buyer_id"],
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        postCode: json["post_code"],
        address: json["address"],
        city: json["city"],
        area: json["area"],
        country: json["country"],
        date: json["date"],
        schedule: json["schedule"],
        packageFee: json["package_fee"],
        extraService: json["extra_service"],
        subTotal: json["sub_total"],
        tax: json["tax"],
        total: json["total"],
        couponCode: json["coupon_code"],
        couponType: json["coupon_type"],
        couponAmount: json["coupon_amount"],
        commissionType: json["commission_type"],
        commissionCharge: json["commission_charge"],
        commissionAmount: json["commission_amount"].toDouble(),
        paymentGateway: json["payment_gateway"],
        paymentStatus: json["payment_status"],
        status: json["status"],
        isOrderOnline: json["is_order_online"],
        orderCompleteRequest: json["order_complete_request"],
        cancelOrderMoneyReturn: json["cancel_order_money_return"],
        transactionId: json["transaction_id"],
        orderNote: json["order_note"],
        manualPaymentImage: json["manual_payment_image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "service_id": serviceId,
        "seller_id": sellerId,
        "buyer_id": buyerId,
        "name": name,
        "email": email,
        "phone": phone,
        "post_code": postCode,
        "address": address,
        "city": city,
        "area": area,
        "country": country,
        "date": date,
        "schedule": schedule,
        "package_fee": packageFee,
        "extra_service": extraService,
        "sub_total": subTotal,
        "tax": tax,
        "total": total,
        "coupon_code": couponCode,
        "coupon_type": couponType,
        "coupon_amount": couponAmount,
        "commission_type": commissionType,
        "commission_charge": commissionCharge,
        "commission_amount": commissionAmount,
        "payment_gateway": paymentGateway,
        "payment_status": paymentStatus,
        "status": status,
        "is_order_online": isOrderOnline,
        "order_complete_request": orderCompleteRequest,
        "cancel_order_money_return": cancelOrderMoneyReturn,
        "transaction_id": transactionId,
        "order_note": orderNote,
        "manual_payment_image": manualPaymentImage,
      };
}
