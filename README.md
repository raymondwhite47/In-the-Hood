# 🏙️ In the Hood
**Local Life. Verified. Connected. Empowered.**

---

### 🚀 Overview

**In the Hood** is a next-generation local community platform designed to bring neighborhoods together through **real-time auctions, local feeds, events, and community support** — all powered by AWS Amplify and Flutter.

Users can:
- Discover nearby listings, trades, and services.
- Bid in **live local auctions** like *FiveMiles*.
- Connect via a **verified neighborhood feed** (AI-moderated).
- Access and contribute to **Community Love** — a volunteer and resource hub for families, veterans, and local causes.

---

## 🧠 Vision

> “A connected neighborhood is a stronger neighborhood.”

**In the Hood** builds safer, more supportive, and more profitable communities by merging marketplace dynamics with real-world compassion.

---

## 🏗️ Architecture Overview

| Layer | Technology | Purpose |
|-------|-------------|----------|
| **Frontend** | Flutter (Dart) | Cross-platform app (Android / iOS / Web) |
| **Backend** | AWS Amplify + AppSync (GraphQL) | Real-time API + data sync |
| **Database** | Amazon DynamoDB | Serverless data layer |
| **Authentication** | Amazon Cognito | Secure user verification |
| **Storage** | S3 via Amplify Storage | Images, auction assets |
| **AI Moderation** | AWS Comprehend / Rekognition (planned) | Content safety |
| **Mapping** | AWS Location Service | Hood-level boundaries & markers |
| **Payments (planned)** | Stripe / PayPal | Bid credits & donations |

---

## 🗂️ Data Models (Simplified)

| Model | Description |
|--------|--------------|
| **Neighborhood** | Defines city zones and boundaries. |
| **UserProfile** | Stores verified user info and trust score. |
| **Post** | Local feed items: sales, events, services, barter. |
| **Auction + Bid** | Real-time auction listings and bids. |
| **CommunityPin** | Map markers for support centers and resources. |
| **VolunteerProject** | Requests or offers for local volunteer work. |
| **Wallet** | Tracks HoodCoins and bid credits. |

---

## ⚙️ Installation (Developer Setup)

### 🧩 Prerequisites
- Node.js ≥ 18
- AWS CLI ≥ 2.13
- Amplify CLI ≥ 12
- Flutter SDK ≥ 3.10
- GitHub / Git configured

### 🧭 1. Clone Repository
```bash
git clone https://github.com/yourusername/in_the_hood.git
cd in_the_hood
```

### 🧰 2. Install Flutter Dependencies
```bash
flutter pub get
```

### 🧩 3. Initialize or Pull Backend
If you already deployed the backend (from CloudShell):

```bash
amplify pull
```

Otherwise, initialize a new Amplify project:
```bash
amplify init
amplify add api
amplify push
```

> Choose **GraphQL + AppSync**, provide `schema.graphql`, and use **Amazon Cognito** auth.

### 🧾 4. Generate Dart Models
```bash
amplify codegen models
```

---

## 🧑‍💻 Running the App

```bash
flutter run
```

When launched, the app will:
- Configure Amplify plugins (API, Auth, Storage).
- Load neighborhood data from DynamoDB.
- Display your **Local Feed** home screen.

---

## 📡 Example Code Snippet

```dart
final request = ModelQueries.list(Neighborhood.classType);
final response = await Amplify.API.query(request: request).response;
for (final hood in response.data!.items) {
  safePrint('🏙️ ${hood!.name} — ${hood.city}');
}
```

---

## 💬 Community Love Tab (Planned Features)

| Feature | Description |
|----------|--------------|
| 🕊️ **Volunteer Match** | Residents can request or offer help. |
| 🎖️ **Veteran Support Map** | Locate veteran services and donation centers. |
| 💞 **Donation Portal** | Businesses and users contribute to causes. |
| 🤖 **AI Screening** | Keeps posts safe and on-topic. |

---

## 💵 Monetization Channels

| Stream | Description |
|---------|--------------|
| 🎯 **AdMob Integration** | Banner & rewarded ads (already configured). |
| 💸 **Bid Credit Packs** | Sell credits for premium auctions. |
| 🛍️ **Featured Listings** | Promote posts or local businesses. |
| ❤️ **Community Donations** | 0–3 % platform fee on charitable contributions. |

---

## 🔐 Security & Verification

- **Cognito-based authentication** for all users.
- **Optional ID Verification** for sellers and service providers.
- **Trust Score System** powered by engagement and moderation history.

---

## 🧱 Project Folder Structure

```
in_the_hood/
 ┣ lib/
 ┃ ┣ amplifyconfiguration.dart
 ┃ ┣ main.dart
 ┃ ┣ models/              # Amplify DataStore models
 ┃ ┣ screens/
 ┃ ┃ ┣ home/
 ┃ ┃ ┣ auctions/
 ┃ ┃ ┗ community/
 ┣ amplify/
 ┃ ┣ backend/
 ┃ ┃ ┗ api/
 ┃ ┗ team-provider-info.json
 ┣ assets/
 ┃ ┗ icons/, images/
 ┗ README.md
```

---

## 🧭 Developer Quick Commands

| Action | Command |
|--------|----------|
| Run App | `flutter run` |
| Pull Backend | `amplify pull` |
| Push Updates | `amplify push` |
| Generate Models | `amplify codegen models` |
| View API Console | `amplify console api` |
| Check Status | `amplify status` |

---

## 🛠️ Contributing

1. Fork the repo  
2. Create your feature branch: `git checkout -b feature/amazing`  
3. Commit: `git commit -m "Add amazing feature"`  
4. Push: `git push origin feature/amazing`  
5. Open a Pull Request

---

## 🧾 License

MIT License — Copyright © 2025  
**In the Hood Technologies**

---

## 👥 Credits

**Founder / Lead Architect:** *Raymond White*  
**AI Technical Partner:** *GPT-5 (OpenAI)*  
**Powered by:** AWS Amplify | Flutter | DynamoDB | AppSync | Cognito | S3