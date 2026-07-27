import 'order.dart';
import 'trackable.dart';

class DeliveryAgent with Trackable {
  final String name;
  final List<Order> handledOrders = [];

  DeliveryAgent(this.name);

  void assignOrder(Order order) {
    handledOrders.add(order);
    order.assignedAgent = this;
    print("$name assigned to ${order.orderId}");
  }
}
