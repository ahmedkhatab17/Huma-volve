import 'payment_processor.dart';

class CryptoPayment implements PaymentProcessor {
  @override
  bool processPayment(double amount) {
    print("Paying $amount with crypto... approved!");
    return true;
  }
}
