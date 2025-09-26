# 🚨 Smart Travel Alarm

A Flutter-based smart travel alarm application with optimized architecture and clean code practices.

## 📱 Features

- **Smart Alarm Management**: Set and manage multiple alarms with precise timing
- **Location Integration**: Add location context to your alarms
- **Notification System**: Reliable alarm notifications
- **Clean UI/UX**: Modern, intuitive interface based on Figma design
- **Responsive Design**: Works on all screen sizes and handles keyboard interactions

## 🏗️ Architecture

### Clean Architecture Pattern
```
lib/
├── features/           # Feature-based organization
│   ├── home/          # Home feature
│   │   ├── models/    # Data models
│   │   ├── pages/     # Screen widgets
│   │   └── widgets/   # Feature-specific widgets
│   ├── location/      # Location feature
│   └── onboarding/    # Onboarding feature
├── services/          # Business logic services
├── common_widgets/    # Reusable widgets
└── constants/         # App constants and styles
```

## 🛠️ Tech Stack

- **Flutter**: Cross-platform mobile development
- **Dart**: Programming language
- **Google Fonts**: Typography (Poppins, Oxygen)
- **Local Notifications**: Alarm notifications
- **Geolocator**: Location services

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (>=3.0.0)
- Dart SDK
- Android Studio / Xcode for platform-specific builds

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/YOUR_USERNAME/smart-travel-alarm.git
   cd smart-travel-alarm
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   flutter run
   ```

## 🎨 Code Quality

### Optimizations Implemented
- **Text Styles**: Reduced from 8+ functions to 2 flexible functions
- **Error Handling**: Comprehensive try-catch with user feedback
- **State Management**: Clean setState pattern with proper lifecycle
- **File Organization**: Feature-based modular structure

### Best Practices
- ✅ Single Responsibility Principle
- ✅ Proper error handling and user feedback
- ✅ Responsive design patterns
- ✅ Clean code architecture
- ✅ Comprehensive documentation

## 👨‍💻 Built With Clean Code Principles

This project demonstrates professional Flutter development practices suitable for production applications and technical interviews.
