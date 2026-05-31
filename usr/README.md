# Architecture Control Panel

This project is a Flutter-based frontend dashboard designed to act as the primary interface for a microservices architecture. It provides specialized views and controls for the different components of the system.

## Overview

The dashboard visualizes and interacts with the following backend services:
- **API Gateway**: Entry point for all frontend requests.
- **Authentication Service**: Handles user access (UI placeholders).
- **AI Engine**: Interfaces with AI generation and tuning systems.
- **Campaign Service**: Manages marketing, outbound, or operational campaigns.
- **Analytics Service**: Aggregates metrics and provides charts (using `fl_chart`).

## Features
- **Responsive Layout**: Adapts from wide desktop dashboards to compact mobile views using bottom navigation and clean single-column layouts.
- **Analytics Visualization**: Interactive line charts representing aggregate data from the Analytics Service.
- **Campaign Management**: List views and status cards for active campaigns.
- **AI Operations**: Control surfaces for interacting with the AI Engine.

## Tech Stack
- Flutter
- `fl_chart` for data visualization

## Running the App

```bash
flutter pub get
flutter run
```

---

## About CouldAI
This app was generated with [CouldAI](https://could.ai), an AI app builder for cross-platform apps that turns prompts into real native iOS, Android, Web, and Desktop apps with autonomous AI agents that architect, build, test, deploy, and iterate production-ready applications.
