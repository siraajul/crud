# Flutter Product Management App(CRUD)

## Overview
A robust Flutter application for seamless product management, featuring comprehensive API integration, input validation, and error handling.

## Features
- Create new products via RESTful API
- Detailed input validation
- Advanced error handling
- Clean, modular code architecture
- Responsive UI design

## Screenshots
<img src="/screenshot/shot01.png" alt="App Screenshot" width="200"> <img src="/screenshot/shot02.png" alt="App Screenshot" width="200">
<img src="/screenshot/shot03.png" alt="App Screenshot" width="200"> <img src="/screenshot/shot04.png" alt="App Screenshot" width="200">
<img src="/screenshot/shot05.png" alt="App Screenshot" width="200"> <img src="/screenshot/shot06.png" alt="App Screenshot" width="200">
<img src="/screenshot/shot07.png" alt="App Screenshot" width="200"> <img src="/screenshot/shot08.png" alt="App Screenshot" width="200">


## Prerequisites
- Flutter SDK (latest stable version)
- Dart SDK
- Android Studio / VS Code
- Xcode (for iOS development)

## Dependencies
```bash
dependencies:
  http: ^1.2.2
  shimmer: ^3.0.0
```

## Installation

### Clone the Repository
```bash
git clone https://github.com/yourusername/product-management-app.git
cd product-management-app
```
## Install Dependencies
```bash
flutter pub get
```

## Run the App
```bash
flutter run
```

## Project Structure 
```bash
lib/
├── main.dart
├── models/
│   └── product_model.dart
├── screens/
│   └── product_creation_screen.dart
├── services/
│   └── api_service.dart
└── utils/
    └── validators.dart
```

### API Integration
```bash
- Endpoint: https://crud.teamrabbil.com/api/v1/CreateProduct
- Method: POST
- Content-Type: application/json
```
## Error Handling

- Input validation before API call
- Detailed error messages
- Graceful error management

## State Management

- Built-in Flutter state management
- Modular loading state implementation

## Contribution Guidelines

- Fork the repository
- Create your feature branch (git checkout -b feature/AmazingFeature)
- Commit your changes (git commit -m 'Add some AmazingFeature')
- Push to the branch (git push origin feature/AmazingFeature)
- Open a Pull Request

