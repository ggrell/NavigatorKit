# NavigatorKit
> A wrapper for NavigationView and NavigationLink that makes programmatic navigation a little friendlier.

[![SwiftPM compatible](https://img.shields.io/badge/SwiftPM-compatible-brightgreen.svg)](https://swift.org/package-manager/)
[![Swift Version][swift-image]][swift-url]
[![License][license-image]][license-url]

NavigatorKit is an opinionated wrapper for NavigationView and NavigationLink that makes programmatic navigation a little friendlier.

## Installation

### Requirements
* iOS 15.0+
* Xcode 13+
* Swift 5+

# Swift Package Manager

In Xcode, select: `File > Swift Packages > Add Package Dependency`.

Paste the package github url in the search bar `https://github.com/ggrell/NavigatorKit` and press next and follow instructions given via Xcode to complete installation.

You can then add ManySheets to your file by adding `import NavigatorKit`.

**Or**

Add this project on your `Package.swift`

```swift
import PackageDescription

let package = Package(
    dependencies: [
        .Package(url: "https://github.com/ggrell/NavigatorKit.git", from: "1.0.0")
    ]
)
```
