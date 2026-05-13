# SportX

SportX is a modern iOS app for exploring sports, leagues, fixtures, and teams with offline-friendly favourites.

<img alt="SportX preview" src="https://github.com/user-attachments/assets/70381cc0-2cbc-49ab-bcbb-44dd7e7f41f7" />

## Features

- Browse curated sports categories (football, basketball, cricket, tennis, and handball).
- Discover leagues by sport and open detailed league pages.
- See upcoming fixtures, latest results, and participating teams per league.
- View team details with coaches and players grouped by position.
- Save leagues to favourites with Core Data for offline access.
- Connectivity-aware flows with friendly error handling.
- Onboarding and splash experiences before entering the main app.

## Architecture

SportX follows an MVP-style module structure:

- **Modules:** `Sports`, `Leagues`, `LeagueDetails`, `TeamDetails`, `Favourites`, `Onboarding`.
- **Presentation:** View controllers backed by presenters and view protocols.
- **Networking:** `NetworkManager` + Alamofire with async/await APIs.
- **Persistence:** Core Data for saved favourites.

## Tech Stack

- Swift + UIKit
- Alamofire (Swift Package Manager)
- Core Data
- Network framework (NWPathMonitor)
- iOS 15.2+ deployment target

## API

SportX uses **AllSportsAPI** (`https://apiv2.allsportsapi.com`).

- Obtain your own AllSportsAPI key and **do not commit it**.
- Store it in an `.xcconfig` file kept out of Git, environment variables, or CI/CD secrets.
- Update `Sportx/Model/Remote/Services/APIService/API.swift` (lowercase x folder) to read from that source.

## Getting Started

1. Clone the repository.
2. Open `SportX.xcodeproj` in Xcode.
3. Resolve Swift Package Manager dependencies (Alamofire).
4. Select the **SportX** scheme and run on a simulator or device.

## Tests

Run tests from Xcode, or via CLI:

```bash
xcodebuild -project SportX.xcodeproj -scheme SportX -destination 'platform=iOS Simulator,name=iPhone 15' test
```

## Project Structure

The app source lives under `Sportx/` (lowercase x in this repo; Xcode references use this casing, so keep it consistent).

```
Sportx/
  Model/
    Local/           # Core Data manager
    Remote/          # API models & networking
  Module/            # Feature modules (MVP)
  Utilities/         # Theme and shared helpers
  View/              # Shared UI components and splash
```

## License

MIT License. See [LICENSE](LICENSE).
