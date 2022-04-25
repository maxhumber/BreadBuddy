

### BreadBuddy

BreadBuddy is a recipe manager, planner, and scheduler for baked goods. I use it to schedule my overnight pizza dough, and my partner uses it schedule her awesomely complicated (but incredibly yummy) sourdough baguettes!

### Screenshots

<h3>
  <img src="https://raw.githubusercontent.com/maxhumber/BreadBuddy/master/Marketing/Screenshots/Simulator%20Screen%20Shot%20-%20iPhone%2013%20Pro%20Max%20-%201.png?token=GHSAT0AAAAAABRP7X6R3T2ZCBALJJVJ3UUEYTG4XMQ" height="300px" alt="BreadBuddy1">
  <img src="https://raw.githubusercontent.com/maxhumber/BreadBuddy/master/Marketing/Screenshots/Simulator%20Screen%20Shot%20-%20iPhone%2013%20Pro%20Max%20-%202.png?token=GHSAT0AAAAAABRP7X6QQHEPYWFUAILMRMESYTG4XNQ" height="300px" alt="BreadBuddy2">
    <img src="https://raw.githubusercontent.com/maxhumber/BreadBuddy/master/Marketing/Screenshots/Simulator%20Screen%20Shot%20-%20iPhone%2013%20Pro%20Max%20-%203.png?token=GHSAT0AAAAAABRP7X6RKJWV5B74B7YVHQI4YTG4XOQ" height="300px" alt="BreadBuddy3">
    <img src="https://raw.githubusercontent.com/maxhumber/BreadBuddy/master/Marketing/Screenshots/Simulator%20Screen%20Shot%20-%20iPhone%2013%20Pro%20Max%20-%204.png?token=GHSAT0AAAAAABRP7X6QRZNKHDXMRB776FUGYTG4XPQ" height="300px" alt="BreadBuddy4">
</h3>

### Download

[![BreadBuddy Download Link](https://moonlight-stream.org/images/App_Store_Badge_135x40.svg)](https://apps.apple.com/app/id1549289924)

### Open Source

BreadBuddy is also a reference. It's the reference app that I wish I had when I was learning how to program with Swift/SwiftUI. In other words, I built it to open source it.

### Code Philosophy

The source code for BreadBuddy is written to be read, tested, and replaced. Or, if you like, influenced by [Clean Code](https://en.wikipedia.org/wiki/Robert_C._Martin), [SOLID](https://en.wikipedia.org/wiki/SOLID), and [TDD](https://en.wikipedia.org/wiki/Test-driven_development)... but not quite as dogmatic 😘

### CADI

BreadBuddy is built with SwiftUI and uses the [MVVM](https://en.wikipedia.org/wiki/Model%E2%80%93view%E2%80%93viewmodel) architectual pattern. It's organized according to a system I've come to dub CADI. Pronounced like and an homage to "[Caddie](https://en.wikipedia.org/wiki/Caddie)", the system compliments MVVM, much like a caddie compliments a golfer. CADI is an acronym that stands for **C**ore, **A**pp, **D**ata, **I**nterface. It uses folders, local packages, and protocols to make feature iteration, code replacement, and refactoring a relative breeze. 

With CADI code is organized into the following folders:

[`Core/`](https://github.com/maxhumber/BreadBuddy/tree/master/BreadBuddy/Core)*

- Models (the **M** in **M** V VM)
  - Core data representations
- Services (domain logic)
  - Made as thin as possible
- Type extensions
- Critical unit tests

[`App/`](https://github.com/maxhumber/BreadBuddy/tree/master/BreadBuddy/App)

  - @main entry point
  - Configuration files
  - Asset catalogues
  - Environment/plist variables

[`Data/`](https://github.com/maxhumber/BreadBuddy/tree/master/BreadBuddy/Data)

  - Database 
    - UserDefaults, CoreData, [GRDB.swift](https://github.com/groue/GRDB.swift), or similar
  - Stores
  - With protocols to allow for future data layer substitutions

[`Interface/`](https://github.com/maxhumber/BreadBuddy/tree/master/BreadBuddy/Interface)

  - Views (the **V** in M **V** VM)
    - Organized by screen
    - With nested ViewModels (the **VM** in M V **VM**)
  - Fonts
  - Colors
  - Sugar*
    - Custom and reusable UI components

** `Core` and `Sugar` are local package firewall-ed from the rest of the app*

### Notable Files

- [`RecipeService.swift`](https://github.com/maxhumber/BreadBuddy/blob/master/BreadBuddy/Core/Sources/Core/Recipe/Service/RecipeService.swift) - core engine of the app, really not that complicated!
- [`RecipeServiceTests.swift`](https://github.com/maxhumber/BreadBuddy/blob/master/BreadBuddy/Core/Tests/CoreTests/RecipeServiceTests.swift) - XCTestCase for the core engine
- [`Data/Database`](https://github.com/maxhumber/BreadBuddy/tree/master/BreadBuddy/Data/Database) - files for the SQLite data persistence layer (using GRDB.swift)
- [`RecipeStore.swift`](https://github.com/maxhumber/BreadBuddy/blob/master/BreadBuddy/Data/Stores/Recipe/RecipeStore.swift) - replaceable bridge intended to span ViewModel and data persistence layer
- [`AlertInput`](https://github.com/maxhumber/BreadBuddy/tree/master/BreadBuddy/Interface/Sugar/Sources/Sugar/AlertInput) - files that wrap a UIKit input alert for use in SwiftUI