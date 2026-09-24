# Clocks

A SwiftUI clone of Apple's Clock app, built as a personal learning project to get hands-on with SwiftUI, `@State`/`@Binding`, `List`/`Section` layouts, and custom UIKit interop via `UIViewRepresentable`.

## Why this project

I wanted to go beyond tutorials and rebuild a real, polished system app pixel-by-pixel. Matching Apple's own UI forces me to actually understand layout, typography, and the gap between what SwiftUI exposes and what's happening under the hood in UIKit.

## Features

- [x] Alarms list with grouped sections ("Sleep | Wake Up", "Other")
- [x] Toolbar with Edit / Add buttons, iOS 26 Liquid Glass styling
- [x] Add Alarm screen with custom time wheel
- [x] Repeat day selector (M T W T F S S)
- [x] Label, Sound, Snooze, Snooze Duration rows
- [ ] Persisting alarms (currently in-memory only)
- [ ] Actual local notifications when an alarm fires
- [ ] World Clock / Stopwatch / Timers tabs

## Screens

| Alarms List | Add Alarm |
|---|---|
| _screenshot here_ | _screenshot here_ |

## What I learned

- **`@State` vs `@Binding`**: `@State` owns data (like `useState` in React); `@Binding` is a read/write handle passed down, closer to a getter+setter pair than a plain prop.
- **`List` + `Section`**: pinned headers, `.listRowInsets`, `.listRowBackground`, and `.listSectionSpacing` for matching native card layouts.
- **iOS 26 Liquid Glass toolbars**: adjacent `ToolbarItem`s auto-group into one glass background; `ToolbarSpacer` separates them.
- **SF Pro vs SF Pro Rounded**: how to tell the two apart visually (terminal shapes on digits like `3`), and when Apple uses each.
- **The limits of `DatePicker(.wheel)`**: it wraps a private `UIPickerView` subclass with internal padding SwiftUI can't override — confirmed via `GeometryReader` measurements and Apple's own docs.
- **`UIViewRepresentable`**: dropping down to raw `UIPickerView` to get real control over column width (`widthForComponent`), plus simulating infinite scroll by inflating row count and using modulo.

## Requirements

- Xcode 16+
- iOS 18+ simulator or device (built alongside iOS 26 Liquid Glass APIs)

## Running

1. Clone the repo
2. Open `Clocks.xcodeproj` in Xcode
3. Select a simulator (e.g. iPhone 17 Pro) and run

## Notes

This is a learning project, not a production app — some things (like the time wheel) are deliberately over-engineered relative to what a real app would need, because the point was learning *how far SwiftUI can go* before you have to drop to UIKit.

## License

MIT
