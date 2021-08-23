import 'package:dio/dio.dart';
import 'package:flutter_app1/src/models/stripe/oxxo/payment_confirm_oxxo_response.dart';
import 'package:flutter_app1/src/models/stripe/oxxo/payment_intent_oxxo_response.dart';
import 'package:flutter_app1/src/models/stripe/oxxo/payment_methods_oxxo_response.dart';
import 'package:flutter_app1/src/models/stripe/payment_confirm_response.dart';
import 'package:flutter_app1/src/models/stripe/payment_intent_response.dart';
import 'package:flutter_app1/src/models/stripe/payment_method_response.dart';
import 'package:meta/meta.dart';

class StripeService {
  String _paymentIntentUrl = 'https://api.stripe.com/v1/payment_intents';
  String _paymentMethodUrl = 'https://api.stripe.com/v1/payment_methods';
  // static String _secretKey ='sk_test_51J8s7PGVQVIvsbeUtIHhIsI53pDXZ25QETcC6WzYOPIKAOwICEhp6RO5WydeZyxN3dK52XQHXwDEbEEFOq7A6f4C00LquonQNw';
  static String _secretKey =
      "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";
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

  //Metodo de pago por oxoo
  Future<PaymentIntentOxxoResponse> _crearPaymentIntentOxo(
      {@required String amount,
      @required String currency,
      @required String paymenyMethodType,
      @required String paymentMethod}) async {
    try {
      final dio = new Dio();
      final data = {
        'amount': amount,
        'currency': currency,
        'payment_method_types[]': paymenyMethodType,
        'payment_method': paymentMethod
      };

      final resp = await dio.post(
        _paymentIntentUrl,
        data: data,
        options: headerOptions,
      );
      return PaymentIntentOxxoResponse.fromMap(resp.data);
    } catch (e) {
      print(e.toString());
      return PaymentIntentOxxoResponse(status: '400');
    }
  }

  Future<PaymenMethodsOxxoResponse> _crearPaymentMethodOxxo(
      String nombre, String email) async {
    try {
      final dio = new Dio();
      final data = {
        'type': 'oxxo',
        'billing_details': {'name': nombre, 'email': email}
      };

      final resp = await dio.post(
        _paymentMethodUrl,
        data: data,
        options: headerOptions,
      );
      return PaymenMethodsOxxoResponse.fromMap(resp.data);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<PaymentConfirmOxxoResponse> _confirmPaymentOxxo(
      String idIntent) async {
    try {
      final dio = new Dio();

      final resp = await dio.post(
        '$_paymentIntentUrl/$idIntent/confirm',
        options: headerOptions,
      );
      return PaymentConfirmOxxoResponse.fromMap(resp.data);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<PaymentConfirmOxxoResponse> realizarPagoOxxo({
    @required String amount,
    @required String currency,
    @required String nombre,
    @required String email,
  }) async {
    try {
      //Obtenemos el metodo de pago
      final paymentMethodOxxo = await _crearPaymentMethodOxxo(nombre, email);
      //Validamos si nos regreso el metodo de pago
      if (paymentMethodOxxo != null) {
        //Se crea el intent pasandole el metodo de pago generado anteriormente
        final paymentIntent = await this._crearPaymentIntentOxo(
            amount: amount,
            currency: currency,
            paymenyMethodType: 'oxxo',
            paymentMethod: paymentMethodOxxo.id);

        final confirmPaymentIntent =
            await _confirmPaymentOxxo(paymentIntent.id);
        return confirmPaymentIntent;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
    //Crear el Intentent
  }
}
