import 'order.dart';
import 'payment_processor.dart';

class Customer {
  final String name;
  final List<Order> orders = [];
  final List<PaymentProcessor> paymentOptions = [];

  Customer(this.name);

  void registerPaymentOption(PaymentProcessor processor) {
    paymentOptions.add(processor);
    print("$name added payment option.");
  }

  void placeOrder(Order order) {
    orders.add(order);
    print("order ${order.orderId} placed by $name");
  }
}
