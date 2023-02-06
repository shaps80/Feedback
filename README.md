![ios](https://img.shields.io/badge/iOS-0C62C7)
[![swift](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fshaps80%2FFeedback%2Fbadge%3Ftype%3Dswift-versions)](https://swiftpackageindex.com/shaps80/Feedback)

# Feedback

A SwiftUI library for conveniently adding haptic, audio and other feedback to your view's and state changes.

## Sponsor

Building useful libraries like these, takes time away from my family. I build these tools in my spare time because I feel its important to give back to the community. Please consider [Sponsoring](https://github.com/sponsors/shaps80) me as it helps keep me working on useful libraries like these 😬

You can also give me a follow and a 'thanks' anytime.

[![Twitter](https://img.shields.io/badge/Twitter-@shaps-4AC71B)](http://twitter.com/shaps)

## Features

- Familiar API (follow transition and animation API styles)
- Haptics
- Audio
- Screen flash

## Usage

**Imperative feedback**

```swift
struct ContentView: View {
    var body: some View {
        Button {
            withFeedback(
                .haptic(.selection)
                .combined(
                    .audio(.keyboardPress)
                )
            ) {
                // state change
            }
        } label: {
            Text("Submit")
        }
    }
}
```

**State observation**

```swift
struct ContentView: View {
    @State private var toggle: Bool = false
    
    var body: some View {
        Toggle("Toggle", isOn: $toggle.feedback(.haptic(.selection)))
    }
}
```

## Installation

You can install manually (by copying the files in the `Sources` directory) or using Swift Package Manager (**preferred**)

To install using Swift Package Manager, add this to the `dependencies` section of your `Package.swift` file:

`.package(url: "https://github.com/shaps80/Feedback.git", .upToNextMinor(from: "1.0.0"))`
