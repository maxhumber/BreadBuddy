<h3>
  <img src="https://raw.githubusercontent.com/maxhumber/BreadBuddy/master/Marketing/Logos/BreadBuddy.png" height="24px" alt="BreadBuddy Logo">
  BreadBuddy
</h3>

BreadBuddy is a recipe scheduler for iOS. I use it to schedule my overnight pizza dough, and my partner uses it to schedule her awesomely complicated (but incredibly yummy) sourdough baguettes!

### Screenshots

<h3>
  <img src="https://raw.githubusercontent.com/maxhumber/BreadBuddy/master/Marketing/Screenshots/screenshot_13pm_1.png" height="300px" alt="BreadBuddy1">
  <img src="https://raw.githubusercontent.com/maxhumber/BreadBuddy/master/Marketing/Screenshots/screenshot_13pm_2.png" height="300px" alt="BreadBuddy2">
  <img src="https://raw.githubusercontent.com/maxhumber/BreadBuddy/master/Marketing/Screenshots/screenshot_13pm_3.png" height="300px" alt="BreadBuddy3">
  <img src="https://raw.githubusercontent.com/maxhumber/BreadBuddy/master/Marketing/Screenshots/screenshot_13pm_4.png" height="300px" alt="BreadBuddy4">
</h3>

### Download

[![BreadBuddy Download Link](https://raw.githubusercontent.com/maxhumber/BreadBuddy/master/Marketing/Logos/AppStore.svg)](https://apps.apple.com/app/id1549289924)

### Open Source

BreadBuddy is the reference I wish I had when I was first learning how to build apps with Swift/SwiftUI. It was therefore built to be open source.

### Code Philosophy

The source code for BreadBuddy is meant to be read, tested, and replaced. The app is influenced by—but not beholden to—Clean Code, [SOLID](https://en.wikipedia.org/wiki/SOLID), and TDD. 

### ⛳️ CADI

BreadBuddy is built with SwiftUI and [MVVM](https://en.wikipedia.org/wiki/Model%E2%80%93view%E2%80%93viewmodel). And is organized with CADI, an acronym that stands for **C**ore, **A**pp, **D**ata, **I**nterface. Pronounced like, and inspired by, "[Caddie](https://en.wikipedia.org/wiki/Caddie)", the system compliments MVVM through the use of folders, local packages, and protocols to make feature iteration, code replacement, and refactoring a relative breeze...

- [**Core/**](https://github.com/maxhumber/BreadBuddy/tree/master/BreadBuddy/Core)*
  - Models (the **M** in **M**VVM)
    - Core data representations
  - Services (domain logic)
    - Made as thin as possible
  - Type extensions
  - Critical unit tests
- [**App/**](https://github.com/maxhumber/BreadBuddy/tree/master/BreadBuddy/App)
  - @main entry point
  - Configuration files
  - Asset catalogues
  - Environment/plist variables
- [**Data/**](https://github.com/maxhumber/BreadBuddy/tree/master/BreadBuddy/Data)
  - Database 
    - UserDefaults, CoreData, [GRDB.swift](https://github.com/groue/GRDB.swift), or similar
  - Stores
    - With protocols to allow for future data layer substitutions
- [**Interface/**](https://github.com/maxhumber/BreadBuddy/tree/master/BreadBuddy/Interface)
  - Views (the **V** in M**V**VM)
    - Organized by Screen
    - Co-located/nested ViewModels (the **VM** in MV**VM**)
  - Fonts
  - Colors
  - Sugar*
    - Custom and reusable UI components

​	*Core and Sugar are local packages firewall-ed from the rest of the app

### Notable Files

- [`RecipeService.swift`](https://github.com/maxhumber/BreadBuddy/blob/master/BreadBuddy/Core/Sources/Core/Recipe/Service/RecipeService.swift) - core engine of the app (really not that complicated)
- [`RecipeServiceTests.swift`](https://github.com/maxhumber/BreadBuddy/blob/master/BreadBuddy/Core/Tests/CoreTests/RecipeServiceTests.swift) - XCTestCase for the core engine
- [`Data/Database`](https://github.com/maxhumber/BreadBuddy/tree/master/BreadBuddy/Data/Database) - files for the GRDB/SQLite data persistence layer
- [`RecipeStore.swift`](https://github.com/maxhumber/BreadBuddy/blob/master/BreadBuddy/Data/Stores/Recipe/RecipeStore.swift) - replaceable bridge intended to span ViewModel and data persistence layer
- [`AlertInput`](https://github.com/maxhumber/BreadBuddy/tree/master/BreadBuddy/Interface/Sugar/Sources/Sugar/AlertInput) - files that wrap a UIKit input alert for usage in SwiftUI
