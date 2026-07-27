import 'product.dart';

class OrderItem {
  final Product product;
  final int quantity;

  OrderItem(this.product, this.quantity);

  double lineTotal() => product.calculateFinalPrice() * quantity;
}
