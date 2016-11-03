//
//  SwiftySunrise.swift
//
//  Copyright (c) 2016 Tom Weightman
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import Foundation

//MARK:- Main class
final public class SwiftySunrise {
    
    //MARK: Types
    public enum SunPhase {
        case sunrise
        case sunset
    }
    
    public enum TwilightType: Int {
        case official = 90
        case civil = 96
        case nautical = 102
        case astronomical = 108
    }
    
    //MARK: Public functions
    public static func sunPhaseTime(forPhase phase: SunPhase, withTwilightType twilightType: TwilightType = .official, onDay date: Date, atLatitude latitude: Double, andLongitude longitude: Double) -> Date? {
        
        var calendar = Calendar(identifier: .gregorian)
        calendar.timeZone = TimeZone(identifier: "Etc/UTC")! //pretty sure UTC wont disappear!
        
        let dateComponents = calendar.dateComponents([ .timeZone, .day, .month, .year ], from: date)
        
        let day = dateComponents.day!
        let month = dateComponents.month!
        let year = dateComponents.year!
        
        //Calculate day of the year
        let n1 = floor(275 * Double(month) / 9)
        let n2 = floor(Double(month + 9) / 12)
        let n3 = 1 + floor((Double(year) - 4 * floor(Double(year) / 4) + 2) / 3)
        let n = n1 - (n2 * n3) + Double(day) - 30
        
        //Convert longitude to hour value
        let lngHour = longitude / 15
        
        let t: Double
        switch phase {
        case .sunrise:
            t = n + ((6 - lngHour) / 24)
        case .sunset:
            t = n + ((18 - lngHour) / 24)
        }
        
        //Sun's mean anomaly
        let m = (0.9856 * t) - 3.289
        
        //Sun's true longitude
        let l = fixRange(m + (1.916 * sin(degrees: m)) + (0.020 * sin(degrees: 2 * m)) + 282.634, max: 360)
        
        //Sun's right ascension
        var ra = fixRange(atan(degrees: 0.91764 * tan(degrees: l)), max: 360)
        let lQuadrant  = (floor(l / 90)) * 90
        let raQquadrant = (floor(ra / 90)) * 90
        ra += (lQuadrant - raQquadrant) //needs to be in same quandrant as l
        ra /= 15 //convert to hours
        
        //Sun's declination
        let sinDec = 0.39782 * sin(degrees: l)
        let cosDec = cos(degrees: asin(degrees: sinDec))
        
        //Sun's local hour angle
        let cosH = (cos(degrees: Double(twilightType.rawValue)) - (sinDec * sin(degrees: latitude))) / (cosDec * cos(degrees: latitude))
        
        if (cosH >  1) {
            //Sun never rises at this location/day
            return nil
        }
        else if (cosH < -1) {
            //Sun never sets at this location/day
            return nil
        }
        
        //Calculate hour
        let h: Double
        switch phase {
        case .sunrise:
            h = (360 - acos(degrees: cosH)) / 15
        case .sunset:
            h = acos(degrees: cosH) / 15
        }
        
        //Local time of rising/setting
        let localTime = h + ra - (0.06571 * t) - 6.622
        
        let localTimeHourUTC = fixRange(localTime - lngHour, max: 24)
        
        var resultDateComponentsUTC = DateComponents()
        resultDateComponentsUTC.timeZone = calendar.timeZone
        resultDateComponentsUTC.calendar = calendar
        resultDateComponentsUTC.day = dateComponents.day
        resultDateComponentsUTC.month = dateComponents.month
        resultDateComponentsUTC.year = dateComponents.year
        resultDateComponentsUTC.hour = Int(localTimeHourUTC)
        resultDateComponentsUTC.minute = Int((localTimeHourUTC - floor(localTimeHourUTC)) * 60)
        
        let resultDate = calendar.date(from: resultDateComponentsUTC)
        
        return resultDate
        
    }
    
}

//MARK:- Date extension
public extension Date {
    
    func toSunPhase(forPhase phase: SwiftySunrise.SunPhase, withTwilightType twilightType: SwiftySunrise.TwilightType = .official, atLatitude latitude: Double, andLongitude longitude: Double) -> Date? {
        
        return SwiftySunrise.sunPhaseTime(forPhase: phase, withTwilightType: twilightType, onDay: self, atLatitude: latitude, andLongitude: longitude)
        
    }
    
}

//MARK:- Convenience functions
fileprivate extension SwiftySunrise {
    
    // e.g. angle is within 0...360 degrees
    fileprivate static func fixRange(_ x: Double, max: Double) -> Double {
        return x - max * floor(x * (1 / max))
    }
    
}
