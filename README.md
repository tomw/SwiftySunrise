# SwiftySunrise

A Swift 3 project for calculating sunrise and sunset times. 

## Usage

SwiftySunrise returns a Date struct, for example:

```
let today = Date()
let sunriseInLondon = SwiftySunrise.sunPhaseTime(forPhase: .sunrise, withTwilightType: .official, onDay: today, atLatitude: 51.527383, andLongitude: -0.0881353)
```

For convenience, the Date extension can also be used:

```
let today = Date()
let extensionOutput = today.toSunPhase(forPhase: .sunrise, withTwilightType: .official, atLatitude: 51.527383, andLongitude: -0.0881353)
```

SwiftySunrise only uses the Foundation framework, making it cross platform compatible.

## Twilight Types
For each phase (sunrise or sunset), times can be requested for the following twilight types:
- Official
- Civil
- Nautical
- Astronomical

## Licence
The MIT License (MIT)
