import 'payment_processor.dart';

class CreditCardPayment implements PaymentProcessor {
  @override
  bool processPayment(double amount) {
    print("Paying $amount with credit card... approved!");
    return true;
  }
}
