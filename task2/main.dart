import 'credit_card_payment.dart';
import 'crypto_payment.dart';
import 'customer.dart';
import 'delivery_agent.dart';
import 'digital_product.dart';
import 'inventory.dart';
import 'order.dart';
import 'physical_product.dart';

void main() {
  var laptop = PhysicalProduct("P1", "Laptop", 800, 2.5, 10);
  var ebook  = DigitalProduct("D1", "Clean Code", 20, "http://download/link", 5);

  var inventory = Inventory();
  inventory.addProduct(laptop);
  inventory.addProduct(ebook);

  var customer = Customer("Ahmed");
  var card     = CreditCardPayment();
  var crypto   = CryptoPayment();
  customer.registerPaymentOption(card);
  customer.registerPaymentOption(crypto);

  var order = Order("ORD1");
  order.addItem(laptop, 1);
  order.addItem(ebook, 2);
  order.discountPercentage = 10;
  customer.placeOrder(order);

  var agent = DeliveryAgent("Fast Fahd");
  agent.assignOrder(order);
  agent.updateLocation(30.05, 31.23);
  laptop.updateLocation(30.00, 31.20);

  order.checkout(card);

  var order2 = Order("ORD2");
  order2.addItem(laptop, 1);
  order2.cancelOrder();
  order2.checkout(crypto);

  print("laptop: ${laptop.name}");
  print("order: ${order.orderId}");
}
