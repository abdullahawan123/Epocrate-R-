import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class PaymentsController extends GetxController {
  static const stripePublishableKey = "pk_test_51I6fsKEE5uPtxrFlVJAaP1IQIWtNk0lPIFV71U77dnoD4bOuqctPZuxLU581AmXZWv3IudbGRcS3xLUdLo02CqFu00UY2YYkwD";
  final _stripeSecretKey = "sk_test_51I6fsKEE5uPtxrFlvj1kCwbUdhUsHBxWJNN5JEWOG1uTvprVhy0QsZE9eKf27LEk6DYRt1czzRQN9qXIiMcpirmV00QK1MjVF7";

  Rx<bool> paymentLoading = false.obs;
  Map<String, dynamic>? stripePaymentIntentData = {};

  Future<String> makePayment(double amount, String currency, String merchantCountryCode, String merchantDisplayName,
      {Function(Map<String, dynamic> infoData)? onSuccess, Function(String error)? onError, ThemeMode? themeMode, double? feePercent}) async {
    paymentLoading.value = true;
    try {
      amount += amount * ((feePercent ?? 0.0) / 100);
      int intAmount = amount.toInt();
      intAmount = intAmount < amount ? (intAmount + 1) : intAmount;

      print("Amount: $intAmount");

      stripePaymentIntentData = await _createPaymentIntent("$intAmount", currency);
      log("paymentIntentData $stripePaymentIntentData");

      await Stripe.instance
          .initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: stripePaymentIntentData!['client_secret'],
          style: themeMode,
          merchantDisplayName: merchantDisplayName,
          // applePay: PaymentSheetApplePay(merchantCountryCode: merchantCountryCode),
          // googlePay: PaymentSheetGooglePay(merchantCountryCode: merchantCountryCode),
        ),
      )
          .catchError((error) {
        log(error);
      });
      paymentLoading.value = false;

      Map<String, dynamic> infoData = {
        "id": "${stripePaymentIntentData?["id"] ?? ""}",
        "status": "paid",
        "amount": ((stripePaymentIntentData?["amount"] ?? -100) / 100),
        "created": stripePaymentIntentData?["created"] ?? 0,
        "currency": stripePaymentIntentData?["currency"] ?? "",
        "livemode": stripePaymentIntentData?["livemode"] ?? false,
      };

      return _displayPaymentSheet(onSuccess, infoData);
    } catch (e) {
      paymentLoading.value = false;
      log("makePayment Exc: $e");
      if (onError != null) {
        onError("$e");
      }
      return "Payment Error: $e";
    }
  }

  Future<String> _displayPaymentSheet(Function(Map<String, dynamic> infoData)? onSuccess, Map<String, dynamic> infoData) async {
    try {
      await Stripe.instance
          .presentPaymentSheet(
        parameters: PresentPaymentSheetParameters(clientSecret: stripePaymentIntentData!['client_secret'], confirmPayment: true),
      )
          .then((value) {
        stripePaymentIntentData = null;
        if (onSuccess != null) {
          onSuccess(infoData);
        }
      });

      return "success";
    } on StripeException catch (e) {
      log("displayPaymentSheet Exc: $e");
      return "$e";
    }
  }

  _createPaymentIntent(String amount, String currency) async {
    Map<String, dynamic> body = {'amount': _calculateAmount(amount), 'currency': currency, 'payment_method_types[]': 'card'};

    try {
      var response = await http.post(Uri.parse("https://api.stripe.com/v1/payment_intents"),
          body: body, headers: {'Authorization': 'Bearer $_stripeSecretKey', 'Content-Type': 'application/x-www-form-urlencoded'});
      return json.decode(response.body.toString());
    } catch (e) {
      log("createPaymentIntent Exc: $e");
    }
  }

  _calculateAmount(String amount) {
    return (int.parse(amount) * 100).toString();
  }
}
