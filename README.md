# Properties
iOS app displaying list of properties with detail view.

# Requirements 
* Xcode 15.4
* iOS >= 16.0


## App

Project build with `MVVM` architecture utilizing:
 * `SwiftUI` for layout.
 * `Combine` for reactive UI update.
 * `Async/await` for remote data fetch.
 * `NavigationStack` for stack navigation within UI.
 * `URLCache` for remote data caching, like images.

## Demo
Project provides `Demo` mode which utilizes bundeled resources (json) for `Demo run` purposes.
Mode switch located in project Run action, as argument to toggle.

## Previews
View model protocol within app provided with `demo types` for preview (in different states), demo and possible snapshot testing.

## Unit Tests
At the moment production intended view models covered with unit tests.