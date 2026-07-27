import 'discountable.dart';
import 'invoice.dart';
import 'order_item.dart';
import 'payment_processor.dart';
import 'product.dart';

class Order with Discountable {
  final String orderId;

  Invoice? _invoice;
  final List<OrderItem> _items = [];

  dynamic assignedAgent;

  Order(this.orderId) {
    _invoice = Invoice("INV-$orderId", 0);
  }

  void addItem(Product product, int quantity) {
    if (_invoice == null) {
      print("Cannot add item, order already canceled.");
      return;
    }
    _items.add(OrderItem(product, quantity));
    print("${product.name} x$quantity added to $orderId");
  }

  void cancelOrder() {
    _invoice = null;
    _items.clear();
    print("order $orderId cancelled.");
  }

  bool checkout(PaymentProcessor payment) {
    if (_invoice == null) {
      print("order cancelled, cannot checkout.");
      return false;
    }
    if (_items.isEmpty) {
      print("no items in cart.");
      return false;
    }

    double total = 0;
    for (OrderItem item in _items) {
      total += item.lineTotal();
    }

    double finalAmount = applyDiscount(total);
    bool paid = payment.processPayment(finalAmount);

    if (paid) {
      _invoice!.totalAmount = finalAmount;
      _invoice!.printInvoice();
      print("order $orderId done.");
    } else {
      print("payment failed.");
    }
    return paid;
  }
}
