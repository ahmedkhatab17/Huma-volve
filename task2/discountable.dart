mixin Discountable {
  double discountPercentage = 0;

  double applyDiscount(double price) {
    double discounted = price - (price * discountPercentage / 100);
    print("Applied $discountPercentage% discount. $price -> $discounted");
    return discounted;
  }
}
