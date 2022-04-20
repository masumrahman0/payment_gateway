import 'dart:convert';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as https;


class PaymentController {
Map<String, dynamic>? paymentIntenData;
Future<void>makePayment({required String amount, required String currency}) async{
  try{
    paymentIntenData = await createPaymentInten(amount,currency);
    if(paymentIntenData != null){
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          applePay: true,
          googlePay: true,
          testEnv: true,
          merchantCountryCode: 'US',
          merchantDisplayName: 'Prospects',
          customerId: paymentIntenData!['customer'],
          paymentIntentClientSecret: paymentIntenData!['client_secret'],
          customerEphemeralKeySecret: paymentIntenData!['ephemeralkey'],
        )
      );
      displayPaymentSheet();
    }
  } catch (e,s){
    print('exception:$e$s');
  }
}

displayPaymentSheet()async{
  try{
    await Stripe.instance.presentPaymentSheet();
    print('Payment Successful');
  } on Exception catch (e){
    if (e is StripeException){
      print('Error from Stripe: ${e.error.localizedMessage}');
    }else {
      print('Unforeseen error: ${e}');
    }
  } catch (e){
    print('exception: $e');
  }
}

createPaymentInten(String amount, String currency) async {
  try{
    Map<String, dynamic> body = {
      'amount': calculateAmount(amount),
      'currency': currency,
      'payment_method_types[]': 'card'
    };
    var response = await https.post(Uri.parse('https://api.stripe.com/v1/payment_intents'),
    body: body,
    headers: {
      'Authorization': 
      'Bearer sk_test_51KqDTuBtp1eoRtcdkypsN1XMHim5d7fyvZdC83YRPUdcKIXbxmWdxJvStDJrXeNOM4D8X5ETI5LU2mp82tgMGSu000IXODJI37',
      'Content-Type' : 'application/x-www-form-urlencoded'
    }
    );
    return jsonDecode(response.body);
  } catch (err){
    print('err charging user: ${err.toString()}');
  }
}

calculateAmount(String amount) {
  final a = (int.parse(amount)) *100;
  return a.toString();
}
}