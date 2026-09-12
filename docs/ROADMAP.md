# Project Status & Roadmap

This document exists to give an honest, current answer to: **"is this ready
to ship?"** — so anyone picking up this repo (a supervisor, a new
contributor, future you) knows exactly what's real and what's still a plan.

## What's built right now

- A working Flutter (Android) UI prototype covering:
  - **Local-only verification flow**: DU email format check
    (`@du.ac.bd`), followed by a camera-based QR scan of the student ID
    card (via `mobile_scanner`). Neither step is checked against a real DU
    system yet — see "What's stubbed" below.
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
| Authentication | Email format and QR scan both run **locally only** — no real OTP/email verification and no server-side check that a scanned ID is a genuine, currently-enrolled DU student. Verification also doesn't persist: closing the app resets it. |
| Backend | None — the app talks to nothing. `mock_data.dart` stands in for a real database |
| Payments | Cash on delivery is a label in the UI, not a real payment/settlement flow |
| Delivery matching | No real matching logic — the delivery dashboard shows static example data |
| Data persistence | None — close the app and all state (cart, orders) resets |

## Path to a functional (not yet store-ready) app

1. ~~Build the auth screen: DU email input + ID card QR camera scan~~ —
   done as a local-only flow (see above)
2. Stand up the backend services described in
   [ARCHITECTURE.md](ARCHITECTURE.md) (auth, orders & subscriptions,
   delivery matching) and the database from
   [DATABASE_SCHEMA.md](DATABASE_SCHEMA.md)
3. Wire the email step to a real verification send (OTP or magic link) via
   the auth service, and the QR step to a real check against DU's ID
   records — the current local-only checks are a placeholder for the flow,
   not real verification
4. Replace `mock_data.dart` with real API calls throughout the `screens/`
   folder
5. Build the cook's "add a dish" flow and the delivery partner's "available
   orders" claim list — currently only the dashboards' summary views exist
6. Decide and implement the delivery-matching approach (manual claiming is
   the recommended v1 — see [DESIGN.md § Delivery model](DESIGN.md#6-delivery-model))
7. Pilot in a single hall/department first, per the cold-start
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
