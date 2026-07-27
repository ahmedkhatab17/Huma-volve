import 'product.dart';

class DigitalProduct extends Product {
  final String downloadUrl;
  final double fileSizeInMB;

  DigitalProduct(
    String id,
    String name,
    double basePrice,
    this.downloadUrl,
    this.fileSizeInMB,
  ) : super(id, name, basePrice);

  @override
  double calculateFinalPrice() {
    print("$name: \$$basePrice (digital)");
    return basePrice;
  }
}
