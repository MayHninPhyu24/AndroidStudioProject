import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_stripe/flutter_stripe.dart';

class StripeTransactionResponse {
  String message;
  bool success;
  StripeTransactionResponse({required this.message, required this.success});
}

class StripeService {
  static Map<String, dynamic>? paymentIntentData;
  static Future<StripeTransactionResponse?> makePayment(String amount, String currency) async{
    try{
      paymentIntentData = await createPaymentIntent(amount, currency);
      await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
            paymentIntentClientSecret: paymentIntentData!['client_secret'],
            applePay: true,
            googlePay: true,
            merchantCountryCode: 'US',
            merchantDisplayName: 'ASIF'
          ));
      var displayMessage = displayPaymentSheet();
      return displayMessage;
    }catch(e){
      print('éxception'+ e.toString());
    }
  }

  static Future<StripeTransactionResponse> displayPaymentSheet() async{
    try{
      await Stripe.instance.presentPaymentSheet(
        parameters: PresentPaymentSheetParameters(
            clientSecret: paymentIntentData!['client_secret'],
            confirmPayment: true,
        )
      );
      paymentIntentData = null;
      return StripeTransactionResponse(
            message: 'Transaction successful', success: true);
    } on PlatformException catch (error) {
      return StripeService.getPlatformExceptionErrorResult(error);
    } catch (error) {
      return StripeTransactionResponse(
          message: 'Transaction failed : $error', success: false);
    }
  }

  static getPlatformExceptionErrorResult(err) {
    String message = 'Something went wrong';
    if (err.code == 'cancelled') {
      message = 'Transaction cancelled';
    }

    return new StripeTransactionResponse(message: message, success: false);
  }

  static Future<Map<String, dynamic>?> createPaymentIntent(String amount, String currency) async{
    try{
      Map<String, dynamic> body = {
        'amount' : calculateAmount(amount).toString(),
        'currency' : currency,
        'payment_method_types[]' : 'card'
      };
      
      var response = await http.post(Uri.parse('https://api.stripe.com/v1/payment_intents'),
          body: body,
          headers: {
          'Authorization': 'Bearer sk_test_c3sFNVBQmWJesiyDVmcdKFNy',
          'Content-type': 'application/x-www-form-urlencoded'
          });

      return jsonDecode(response.body.toString());

    }catch(e){
      print('exception'+ e.toString());
    }
  }

  static int calculateAmount(String amount) {
    final price = int.parse(amount) * 100;
    return price;
  }
}
