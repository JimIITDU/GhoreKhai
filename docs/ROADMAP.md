# Project Status & Roadmap

This document exists to give an honest, current answer to: **"is this ready
to ship?"** — so anyone picking up this repo (a supervisor, a new
contributor, future you) knows exactly what's real and what's still a plan.

## What's built right now

- A working Flutter (Android) UI prototype covering:
  - Buyer flow: browse → dish detail → plan selection → cart → checkout →
    order tracking
  - Cook dashboard (toggled from Profile): today's orders, weekly earnings
    summary
  - Delivery partner dashboard (toggled from Profile): assigned deliveries,
    expected earnings
- A complete product design: problem statement, user flows for all three
  roles, feature list, delivery model, trust & safety approach — see
  [DESIGN.md](DESIGN.md)
- A planned system architecture and database schema — see
  [ARCHITECTURE.md](ARCHITECTURE.md) and [DATABASE_SCHEMA.md](DATABASE_SCHEMA.md)
- Confirmed to build and run on a real Android device (tested on a Samsung
  device running Android 14)

## What's explicitly stubbed / not real yet

The app currently runs entirely on **mock data**
(`lib/data/mock_data.dart`). Concretely, that means:

| Area | Current state |
|---|---|
| Authentication | The app assumes the user is already verified — no real DU email or ID card QR scan flow exists yet |
| Backend | None — the app talks to nothing. `mock_data.dart` stands in for a real database |
| Payments | Cash on delivery is a label in the UI, not a real payment/settlement flow |
| Delivery matching | No real matching logic — the delivery dashboard shows static example data |
| Data persistence | None — close the app and all state (cart, orders) resets |

## Path to a functional (not yet store-ready) app

1. Build the auth screen: DU email input + ID card QR camera scan, wired in
   before the app's root screen
2. Stand up the backend services described in
   [ARCHITECTURE.md](ARCHITECTURE.md) (auth, orders & subscriptions,
   delivery matching) and the database from
   [DATABASE_SCHEMA.md](DATABASE_SCHEMA.md)
3. Replace `mock_data.dart` with real API calls throughout the `screens/`
   folder
4. Build the cook's "add a dish" flow and the delivery partner's "available
   orders" claim list — currently only the dashboards' summary views exist
5. Decide and implement the delivery-matching approach (manual claiming is
   the recommended v1 — see [DESIGN.md § Delivery model](DESIGN.md#6-delivery-model))
6. Pilot in a single hall/department first, per the cold-start
   recommendation in [DESIGN.md](DESIGN.md#8-feasibility-notes)

## Additional requirements before Google Play Store submission

Being functional is a different bar from being store-ready. Once the app
above is working, Play Store submission additionally requires:

- [ ] A **signed release build** (what exists today is a debug build, which
      the Play Store does not accept)
- [ ] App icon and store screenshots
- [ ] A **privacy policy** — mandatory, and non-optional here specifically
      because the app handles DU emails, student ID data, and food orders
- [ ] A completed **Data Safety** form (what data is collected, why, and how
      it's stored)
- [ ] A Google Play Developer account (one-time registration fee)
- [ ] Content/age rating questionnaire
- [ ] Testing across multiple real devices, not just one

## Business/legal considerations (outside the app itself)

- **Food safety liability**: since real money and real food change hands
  between students, this needs an explicit terms-of-service and a decision
  on what liability, if any, the platform accepts for food safety issues —
  currently unaddressed
- **Terms of service** for the marketplace generally (cancellations,
  disputes, refunds)

## Summary

This repo currently represents a **validated design + working UI
prototype** — a real and meaningful milestone, and the expected output of a
"design first, then implementation" process. It is **not** yet a functional
product (no backend) and **not** close to Play Store submission. The steps
above are the concrete path from here to there, in order.
