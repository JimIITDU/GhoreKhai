import '../models/models.dart';

/// Placeholder data so the UI has something to show before a backend
/// exists. Replace this with real API calls once the backend (see
/// architecture diagram: orders & subscriptions service) is built.
class MockData {
  static final currentUser = const AppUser(
    id: 'u1',
    fullName: 'Sakib',
    email: 'sakib@student.du.ac.bd',
    verified: true,
  );

  static final dishes = <Dish>[
    const Dish(
      id: 'd1',
      cookId: 'c1',
      cookName: "Rima's Kitchen",
      name: 'Bhorta thali',
      area: 'Amtali hostel area',
      rating: 4.8,
      priceOneTime: 70,
      priceWeekly: 390,
      priceMonthly: 1500,
      dailyCap: 20,
    ),
    const Dish(
      id: 'd2',
      cookId: 'c2',
      cookName: "Maruf's Mess",
      name: 'Chicken curry set',
      area: 'Nilkhet gate',
      rating: 4.6,
      priceOneTime: 90,
      priceWeekly: 480,
      priceMonthly: 1850,
      dailyCap: 15,
    ),
    const Dish(
      id: 'd3',
      cookId: 'c3',
      cookName: "Shanta's Table",
      name: 'Veg thali',
      area: 'Shahbagh side',
      rating: 4.9,
      priceOneTime: 60,
      priceWeekly: 330,
      priceMonthly: 1300,
      dailyCap: 25,
    ),
  ];
}
