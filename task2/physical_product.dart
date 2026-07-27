import 'product.dart';
import 'trackable.dart';

class PhysicalProduct extends Product with Trackable {
  final double weightInKg;
  final double shippingRatePerKg;

  PhysicalProduct(
    String id,
    String name,
    double basePrice,
    this.weightInKg,
    this.shippingRatePerKg,
  ) : super(id, name, basePrice);

  @override
  double calculateFinalPrice() {
    double shippingCost = weightInKg * shippingRatePerKg;
    double finalPrice = basePrice + shippingCost;
    print("$name: \$$finalPrice (base \$$basePrice + shipping \$$shippingCost)");
    return finalPrice;
  }
}
