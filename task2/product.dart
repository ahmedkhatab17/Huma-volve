abstract class Product {
  final String id;
  final String name;
  final double basePrice;

  Product(this.id, this.name, this.basePrice);

  double calculateFinalPrice();
}
