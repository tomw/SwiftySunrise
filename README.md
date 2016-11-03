# SwiftySunrise

A Swift 3 project for calculating sunrise and sunset times. SwiftySunrise returns a Date struct, for example:

```
let inputDate = Date(timeIntervalSince1970: 1478194901)
let sunriseInLondon = SwiftySunrise.sunPhaseTime(forPhase: .sunrise, withTwilightType: .official, onDay: inputDate, atLatitude: 51.527383, andLongitude: -0.0881353)
```

For convenience, the Date extension can also be used:

```
let inputDate = Date(timeIntervalSince1970: 1478194901)
let extensionOutput = inputDate.toSunPhase(forPhase: .sunrise, withTwilightType: .official, atLatitude: 51.527383, andLongitude: -0.0881353)
```

SwiftySunrise only uses the Foundation framework, making it cross platform compatible.
