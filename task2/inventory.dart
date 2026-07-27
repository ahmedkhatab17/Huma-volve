import 'product.dart';

class Inventory {
  final List<Product> products = [];

  void addProduct(Product product) {
    products.add(product);
    print("Added ${product.name} to inventory.");
  }
}
