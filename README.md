# Pokemon App

This project is a SwiftUI app that displays 3 random Pokemon from the Pokemon API. Users can view Pokemon in a list and tap to see details including types.

## What the app does

- Shows 3 random Pokemon with their Pokédex number, name, and image
- Tap any Pokemon to see detailed information including types
- Handles network errors with retry functionality

## API Integration

Connects to the Pokemon API:
- Endpoint: [https://pokeapi.co/api/v2/pokemon/](https://pokeapi.co/api/v2/pokemon/)
- Usage: `https://pokeapi.co/api/v2/pokemon/{id}/` where `{id}` is random 1-1025

## How to run the app

**Requirements:**
- Xcode 17.0 or later
- iOS 26.0 or later

**Steps:**
1. Open `Foto.xcodeproj` in Xcode
2. Select a simulator or device
3. Press `Cmd + R` to build and run
