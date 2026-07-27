mixin Trackable {
  double? _latitude;
  double? _longitude;
  String trackingStatus = "not started";

  void updateLocation(double lat, double lng) {
    _latitude = lat;
    _longitude = lng;
    trackingStatus = "in transit";
    print("[$trackingStatus] location: ($lat, $lng)");
  }

  void markDelivered() {
    trackingStatus = "delivered";
    print("delivery confirmed.");
  }
}
