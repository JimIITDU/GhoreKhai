# Ghore Khai — Design Document

## 1. Overview

Ghore Khai is a platform aimed at solving the food problem for DU students
while creating new earning opportunities for students of DU.

Students at DU do not have access to quality food inside campus in most
places. At the same time, some students can cook decent meals but have no
way to manage or sell them at scale.

Ghore Khai solves this by letting a student run her own "channel" — selling
meals with subscription support, delivery logistics support, and consistent,
decent-priced food for students who are willing to pay for it.

Students browse the app to find cooks and their dishes. They can place a
one-time order to try a dish, then move to a subscription if they like it.
The menu can stay the same or rotate, depending on the cook's choice. Some
students can also take on the work of delivery, earning from that instead of
(or alongside) cooking.

Because the platform is subscription-based, all three sides gain
predictability: the hungry student knows food is coming, the cook knows how
much to prepare, and the delivery student knows what they'll earn and how
long the work will take that day.

## 2. Problem

- Hostel and mess food is repetitive and often low quality; restaurant
  delivery (Foodpanda, Pathao Food) is expensive for daily use and not
  home-style.
- Some students already cook well and informally feed friends, but have no
  structured way to reach more buyers, manage orders, or handle delivery.
- There is no structured, low-effort way for students to earn money through
  cooking or delivering on campus, despite clear demand on both sides.
- Existing home-cooked food marketplaces in Bangladesh (e.g. Cookups, Sheba
  Food) operate city-wide and are not student-to-student, not hyperlocal to
  a campus, and not built around subscriptions tuned to a student's weekly
  schedule.

**Note on originality:** the broad concept of a home-cook marketplace is not
new — Cookups has run one in Dhaka since 2016. The differentiation here is
narrow and deliberate: DU-only, hyperlocal (walkable delivery radius),
subscription-first, and structured around three student roles — buyer, cook,
and delivery partner — rather than just buyer and seller.

## 3. Target users

| Role | Description |
|---|---|
| **Buyer** | Any verified DU student who wants daily/weekly home-cooked meals near their hall or department, at a decent, affordable price. |
| **Cook (seller)** | A DU student who cooks and wants to sell meals to a small, walkable radius of buyers, on their own schedule and order cap, without needing to manage delivery themselves. |
| **Delivery partner** | A DU student who wants to earn by delivering orders from cooks to buyers, on a schedule and workload they can predict in advance. |

## 4. Core user flow

### Buyer flow
1. Sign up / verify with DU email + ID card QR scan
2. Browse cooks and dishes near their hall/department
3. Open a dish, order once to try it, or choose a plan — weekly or monthly
4. Add to cart, pick a delivery time slot, place order (cash on delivery)
5. Track order status: Placed → Cooking → Out for delivery → Delivered
6. Pause or skip a subscription day (e.g. for exams or home visits)
7. Rate the cook/dish and the delivery experience after delivery

### Cook flow
1. Sign up / verify with DU email + ID card QR scan
2. Set up profile: area/hostel, cuisine, sample dishes
3. List dishes with price, available days, and a daily order cap — same menu
   daily or rotating, cook's choice
4. Receive and manage incoming orders from a simple dashboard
5. Mark orders as cooking / ready for pickup
6. Hand off ready orders to an assigned delivery partner
7. View today's orders and weekly earnings summary

### Delivery partner flow
1. Sign up / verify with DU email + ID card QR scan
2. Set availability — which time slots and areas they can deliver in
3. Get matched to ready orders within their area/route
4. Mark pickup from cook and delivery to buyer
5. View today's assigned deliveries and expected earnings, known in advance
   because of subscription volume

## 5. Feature list

| Feature | Description |
|---|---|
| Two-factor DU verification | `@du.ac.bd` email plus a scan of the student ID card QR code at registration — the core trust mechanism for all three roles. |
| Cook profile & menu builder | Cooks list dishes with price, portion size, available days/times, and photos. |
| Daily order cap | Cooks set a max number of orders per day so a solo home cook isn't overwhelmed. |
| Subscription plans | Weekly or monthly plans, fixed or rotating menu (cook's choice); one-time orders also supported so buyers can try before subscribing. |
| Pause / skip a day | Buyers can pause a subscription for specific days (exams, travel) without cancelling the whole plan. |
| Area-based browsing | Buyers see cooks filtered by proximity to their hall/department, keeping delivery routes short. |
| Cart & checkout | Add items, choose a delivery time slot, confirm order. |
| Delivery partner matching | Ready orders are matched to available delivery partners covering that area/time slot. |
| Order tracking | Status stepper: Placed, Cooking, Picked up, Delivered — visible to buyer, cook, and delivery partner. |
| Cook dashboard | Today's orders, subscription renewals, and a weekly earnings summary. |
| Delivery partner dashboard | Today's assigned deliveries, route order, and expected earnings for the day. |
| Ratings & reviews | Buyers rate cooks/dishes and delivery experience after delivery; ratings shown on browse screen. |
| Report / flag | Buyers can flag a missed order, food-quality issue, or delivery problem; light admin moderation. |
| Payments | Cash on delivery at launch; bKash/Nagad manual confirmation as a later addition. |

## 6. Delivery model

Delivery is handled by student delivery partners, not by the cooks
themselves. A cook marks an order ready for pickup; a delivery partner
already active in that area/time slot is matched to it, picks it up, and
delivers it to the buyer. This mirrors the route-matching idea behind apps
like JyGo, but applied to food handoff instead of passenger rides.

- Cooks focus only on cooking and marking orders ready — no delivery burden
  on them.
- Delivery partners set their own availability (time slots, areas) and get
  matched to nearby ready orders.
- Subscription volume means delivery partners can predict their workload and
  earnings in advance, rather than waiting for ad hoc gig requests.

**Open question for v1 scoping:** whether matching is fully automatic
(system assigns nearest available partner) or manual (delivery partners see
a list of ready orders and claim one). Manual claiming is simpler to build
first and is the current recommendation.

## 7. Trust & safety

- Two-factor verification for all three roles: DU email domain check plus ID
  card QR scan at registration, confirming both institutional affiliation
  and current enrollment.
- Cook self-declares kitchen setup (shared mess kitchen, home kitchen, hall
  kitchen) for transparency — no formal health inspection needed to launch.
- Report/flag button on every order for quality, missed order, or delivery
  issues.
- Ratings history visible before a buyer subscribes to a new cook, and
  before a cook/buyer is matched with a given delivery partner repeatedly.

## 8. Feasibility notes

- No admin/registrar dependency — entirely peer-to-peer.
- No payment gateway needed at launch (cash on delivery).
- ID card QR scanning needs a simple in-app camera scan flow at
  registration — no external hardware, but should be tested against real DU
  ID card QR formats early.
- Main ongoing manpower cost is light moderation (flag review); delivery
  partner coordination is handled by the matching system itself, not by the
  team.
- Cold-start risk: needs a small cluster of cooks, buyers, and delivery
  partners in one hall/area first, rather than launching campus-wide on day
  one — recommend piloting in a single hall or department before expanding.

## 9. Competitive landscape

| Platform | Scope | Gap vs. Ghore Khai |
|---|---|---|
| Cookups | City-wide, Dhaka | Not student-to-student, not campus-hyperlocal, no subscription tuned to student schedules |
| Sheba Food | City-wide | Same as above |
| JyGo | DU-adjacent, ride-sharing | Solves commuting, not food — different problem entirely |

See also: [docs/ROADMAP.md](ROADMAP.md) for what's built vs. planned.
