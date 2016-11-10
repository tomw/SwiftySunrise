# SwiftySunrise

A Swift 3 project for calculating sunrise and sunset times. 

## Integration using CocoaPods

To use [CocoaPods](http://cocoapods.org/) to install `SwiftySunrise`, add it to your Podfile:

```ruby
target 'YourApp' do
    use_frameworks!
	pod 'SwiftySunrise'
end
```

## Usage

SwiftySunrise returns a Date struct, for example:

```swift
let today = Date()
let sunriseInLondon = SwiftySunrise.sunPhaseTime(forPhase: .sunrise, withTwilightType: .official, onDay: today, atLatitude: 51.527383, andLongitude: -0.0881353)
```

For convenience, the Date extension can be used:

```swift
let today = Date()
let sunriseInLondon = today.toSunPhase(forPhase: .sunrise, withTwilightType: .official, atLatitude: 51.527383, andLongitude: -0.0881353)
```
or for today, the failable initializer is another option:
```swift
let sunriseInLondon = Date(sunPhaseToday: .sunrise, latitude: 51.527383, longitude: -0.0881353)
```

SwiftySunrise only uses the Foundation framework, making it cross platform compatible.

## Time zones
SwiftySunrise returns times in UTC. For display, times can be converted like in the following example:

```swift
guard let sunriseInSanFrancisco = Date().toSunPhase(forPhase: .sunrise, withTwilightType: .official, atLatitude: 37.7576171, andLongitude: -122.5776844) else { return }
    
guard let pacificTimeZone = TimeZone(identifier: "US/Pacific") else { return }
let dateFormatter = DateFormatter()
dateFormatter.timeZone = pacificTimeZone
dateFormatter.dateFormat = "HH:mm"
    
let timeInSanFrancisco = dateFormatter.string(from: sunriseInSanFrancisco) // "07:43"
```

## Twilight Types
For each phase (sunrise or sunset), times can be requested for the following twilight types:
- Official
- Civil
- Nautical
- Astronomical

## Licence
The MIT License (MIT)
