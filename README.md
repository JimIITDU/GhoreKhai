# Ghore Khai — Flutter prototype (v1)

A DU-verified home-cooked meal marketplace and subscription app.
See the design doc for the full product spec.

## What's in this scaffold

- `lib/main.dart` — app entry point
- `lib/theme.dart` — colors and Material theme
- `lib/models/models.dart` — data models (User, Cook, Dish, Order, etc.),
  mirroring the database schema in the design doc
- `lib/data/mock_data.dart` — placeholder data; **swap this for real API
  calls** once the backend exists
- `lib/screens/` — one file per screen:
  - `root_screen.dart` — bottom nav + shared cart/order state
  - `home_screen.dart` — browse cooks/dishes
  - `dish_detail_screen.dart` — pick a plan (one-time / weekly / monthly)
  - `cart_screen.dart` — checkout, delivery slot, cash on delivery
  - `orders_screen.dart` — order status tracker
  - `profile_screen.dart` — user info + Cook mode / Delivery mode toggles

## What this prototype does NOT include yet

This is a UI-only prototype running on mock data, built to validate the
screens and flow before backend work starts:

- No real authentication (DU email + ID card QR scan is not implemented —
  the mock user is already "verified")
- No backend/API calls — `mock_data.dart` stands in for the database
- No real delivery-partner matching logic
- No payment integration (cash on delivery is just a label, not a flow)

## Running it

This was written in an environment without the Flutter SDK installed, so
it has **not been run or compiled**. To run it locally:

```bash
flutter pub get
flutter run
```

You'll need the Flutter SDK and an Android emulator (or physical device)
set up. If anything doesn't compile, it's most likely a small API
mismatch with your installed Flutter version — the code targets Flutter
3.x / Dart 3.x (Material 3, `NavigationBar`, `SwitchListTile`, and record
types like `(a, b, c)` are all Dart 3 / Flutter 3.10+ features).

## Suggested next steps

1. Get this compiling and running on an emulator — fix any small API
   drift first.
2. Build the auth screen (DU email input + ID card QR camera scan) and
   wire it in before `RootScreen`.
3. Replace `mock_data.dart` with real API calls once the backend
   (see architecture diagram: auth service, orders & subscriptions
   service, delivery matching service) is up.
4. Add the cook's "add a dish" flow and the delivery partner's
   "available orders" list — currently only the dashboards' summary
   cards are stubbed in `profile_screen.dart`.
# GhoreKhai
