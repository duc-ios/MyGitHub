[![Swift Version][swift-image]][swift-url]
[![License][license-image]][license-url]
[![Platform](https://img.shields.io/cocoapods/p/LFAlertController.svg?style=flat)](http://cocoapods.org/pods/LFAlertController)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg?style=flat-square)](http://makeapullrequest.com)

# MyGitHub App

MyGitHub is a mobile application that displays a list of GitHub users. Tapping on a user from the list opens a detailed view of the selected user's profile and repositories. This app is designed to make browsing GitHub profiles simple and convenient.

## Features

- **GitHub User List**: Displays a paginated list of GitHub users fetched via GitHub's public API.
- **User Profile**: Tapping on a user in the list opens a detailed view of the user's profile, including their repositories, followers, and other relevant information.
- **Responsive UI**: The app is optimized for various screen sizes, ensuring a smooth experience on both smartphones and tablets.
- **Offline Support**: The app caches data locally for a limited time, allowing users to view the last-loaded data when offline.

## Requirements

- iOS 17.0+
- Xcode 15.0+
- Swift 5.10+

## Getting Started

Follow the steps below to set up and run the project locally.

### Prerequisites

- [Xcode](https://developer.apple.com/xcode/) for iOS development.

### Installation

1. Clone the repository:

   ```bash
   git clone https://github.com/duc-ios/MyGitHub.git
   ```

2. Run the app:

   ```bash
   open MyGitHub/MyGitHub.xcodeproj
   ```

## API Usage

The app fetches data from the [GitHub Users Public API](https://api.github.com/users).

## Usage

1. Launch the app on your device.
2. Browse the list of GitHub users.
3. Tap on any user to view their profile details, repositories, and followers.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

[swift-image]: https://img.shields.io/badge/swift-5.10-orange.svg
[swift-url]: https://swift.org/
[license-image]: https://img.shields.io/badge/License-MIT-blue.svg
[license-url]: LICENSE
