/// Plain data models for the app. These mirror the tables in the
/// database schema (see design doc) but are simplified for the
/// prototype, which currently runs on mock data instead of a backend.

enum PlanType { oneTime, weekly, monthly }

enum OrderStatus { placed, cooking, pickedUp, delivered }

class AppUser {
  final String id;
  final String fullName;
  final String email; // must end in @du.ac.bd
  final bool verified; // DU email + ID card QR both confirmed

  const AppUser({
    required this.id,
    required this.fullName,
    required this.email,
    required this.verified,
  });
}

class Cook {
  final String id;
  final String name;
  final String area;
  final double rating;
  final String kitchenType;

  const Cook({
    required this.id,
    required this.name,
    required this.area,
    required this.rating,
    required this.kitchenType,
  });
}

class Dish {
  final String id;
  final String cookId;
  final String cookName;
  final String name;
  final String area;
  final double rating;
  final double priceOneTime;
  final double priceWeekly;
  final double priceMonthly;
  final int dailyCap;

  const Dish({
    required this.id,
    required this.cookId,
    required this.cookName,
    required this.name,
    required this.area,
    required this.rating,
    required this.priceOneTime,
    required this.priceWeekly,
    required this.priceMonthly,
    required this.dailyCap,
  });

  double priceFor(PlanType plan) {
    switch (plan) {
      case PlanType.oneTime:
        return priceOneTime;
      case PlanType.weekly:
        return priceWeekly;
      case PlanType.monthly:
        return priceMonthly;
    }
  }
}

class CartItem {
  final Dish dish;
  final PlanType plan;

  const CartItem({required this.dish, required this.plan});
}

class FoodOrder {
  final String id;
  final Dish dish;
  final PlanType plan;
  OrderStatus status;

  FoodOrder({
    required this.id,
    required this.dish,
    required this.plan,
    this.status = OrderStatus.placed,
  });
}

String planLabel(PlanType plan) {
  switch (plan) {
    case PlanType.oneTime:
      return 'One-time';
    case PlanType.weekly:
      return 'Weekly (6 days)';
    case PlanType.monthly:
      return 'Monthly';
  }
}

String statusLabel(OrderStatus status) {
  switch (status) {
    case OrderStatus.placed:
      return 'Placed';
    case OrderStatus.cooking:
      return 'Cooking';
    case OrderStatus.pickedUp:
      return 'Picked up';
    case OrderStatus.delivered:
      return 'Delivered';
  }
}
