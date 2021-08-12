import 'package:dio/dio.dart';
import 'package:flutter_app1/src/models/stripe/payment_confirm_response.dart';
import 'package:flutter_app1/src/models/stripe/payment_intent_response.dart';
import 'package:flutter_app1/src/models/stripe/payment_method_response.dart';
import 'package:meta/meta.dart';

class StripeService {
  String _paymentIntentUrl = 'https://api.stripe.com/v1/payment_intents';
  String _paymentMethodUrl = 'https://api.stripe.com/v1/payment_methods';
  // static String _secretKey ='sk_test_51J8s7PGVQVIvsbeUtIHhIsI53pDXZ25QETcC6WzYOPIKAOwICEhp6RO5WydeZyxN3dK52XQHXwDEbEEFOq7A6f4C00LquonQNw';
  static String _secretKey =
      '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';
  final headerOptions = new Options(
      contentType: Headers.formUrlEncodedContentType,
      headers: {'Authorization': 'Bearer ${StripeService._secretKey}'});

  Future<PaymentMethodResponse> _crearPaymentMethod(
    String cardNumber,
    String expMonth,
    String expYear,
    String cvv,
  ) async {
    try {
      final dio = new Dio();
      final data = {
        'type': 'card',
        'card': {
          'number': cardNumber,
          'exp_month': expMonth,
          'exp_year': "20$expYear",
          'cvc': cvv
        }
      };

      final resp = await dio.post(
        '$_paymentMethodUrl',
        data: data,
        options: headerOptions,
      );
      return PaymentMethodResponse.fromMap(resp.data);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<PaymentIntentResponse> _crearPaymentIntent(
      {@required String amount,
      @required String currency,
      @required String paymentMethod}) async {
    try {
      final dio = new Dio();
      final data = {
        'amount': amount,
        'currency': currency,
        'payment_method': paymentMethod
      };

      final resp = await dio.post(
        _paymentIntentUrl,
        data: data,
        options: headerOptions,
      );
      return PaymentIntentResponse.fromJson(resp.data);
    } catch (e) {
      print(e.toString());
      return PaymentIntentResponse(status: '400');
    }
  }

  Future<PaymentConfirmResponse> _confirmPayment(String idIntent) async {
    try {
      final dio = new Dio();

      final resp = await dio.post(
        '$_paymentIntentUrl/$idIntent/confirm',
        options: headerOptions,
      );
      return PaymentConfirmResponse.fromMap(resp.data);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<PaymentConfirmResponse> realizarPago(
      {@required String cardNumber,
      @required String expMonth,
      @required String expYear,
      @required String cvv,
      @required String amount,
      @required String currency}) async {
    try {
      //Obtenemos el metodo de pago
      final paymentMethod =
          await this._crearPaymentMethod(cardNumber, expMonth, expYear, cvv);
      final paymentIntent = await this._crearPaymentIntent(
          amount: amount, currency: currency, paymentMethod: paymentMethod.id);
      final confirmPaymentIntent = await _confirmPayment(paymentIntent.id);

      return confirmPaymentIntent;
    } catch (e) {
      return null;
    }
    //Crear el Intentent
  }
}
