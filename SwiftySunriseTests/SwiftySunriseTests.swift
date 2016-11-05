//
//  SwiftySunriseTests.swift
//  SwiftySunriseTests
//
//  Created by Tom Weightman on 03/11/2016.
//  Copyright © 2016 Tom Weightman. All rights reserved.
//

import XCTest
@testable import SwiftySunrise

class SwiftySunriseTests: XCTestCase {
    
    private var calendar: Calendar?
    
    override func setUp() {
        
        super.setUp()
        
        self.calendar = Calendar(identifier: .gregorian)
        self.calendar?.timeZone = TimeZone(identifier: "Etc/UTC")!
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testLondonSunriseTime() {

        let inputDate = Date(timeIntervalSince1970: 1478194901) //3rd Nov 2016
        let inputDateComponents = self.calendar!.dateComponents([ .calendar, .day, .month, .year ], from: inputDate)
        
        let output = SwiftySunrise.sunPhaseTime(forPhase: .sunrise, withTwilightType: .official, onDay: inputDate, atLatitude: 51.527383, andLongitude: -0.0881353)
        XCTAssertTrue(output != nil, "The sun should rise in London on this day")
        
        let outputDateComponents = self.calendar!.dateComponents([ .calendar, .timeZone, .day, .month, .year, .hour, .minute ], from: output!)
        
        //Test everything but hour and minute are equal from input to output
        XCTAssertEqual(inputDateComponents.calendar!, outputDateComponents.calendar!, "Calendar should match between input and output date")
        XCTAssertEqual(inputDateComponents.day!, outputDateComponents.day!, "Day should match between input and output date")
        XCTAssertEqual(inputDateComponents.month!, outputDateComponents.month!, "Month should match between input and output date")
        XCTAssertEqual(inputDateComponents.year!, outputDateComponents.year!, "Year should match between input and output date")
        
        //Test output is UTC timezone
        XCTAssertEqual(outputDateComponents.timeZone!.identifier, "Etc/UTC", "Time zone should be UTC")
        
        //Test that date/time is as expected. 7:04 on 3rd Nov 2016
        XCTAssertEqual(outputDateComponents.year, 2016, "Year should be 2016")
        XCTAssertEqual(outputDateComponents.month, 11, "Month should be 11")
        XCTAssertEqual(outputDateComponents.day, 3, "Day should be the 3rd")
        XCTAssertEqual(outputDateComponents.hour, 7, "Hour should be 7am")
        XCTAssertEqual(outputDateComponents.minute, 4, "Minute should be 4")
        
        //Formatting time in UTC should equal "07:04am"
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(identifier: "Etc/UTC")!
        dateFormatter.dateFormat = "HH:mm"
        XCTAssertEqual(dateFormatter.string(from: output!), "07:04", "Time should be 7:04 in UTC")
        
    }
    
    func testLondonSunriseTimeForAllPhaseTypes() {
        
        let inputDate = Date(timeIntervalSince1970: 1478194901) //3rd Nov 2016
        
        let officialOutput = SwiftySunrise.sunPhaseTime(forPhase: .sunrise, withTwilightType: .official, onDay: inputDate, atLatitude: 51.527383, andLongitude: -0.0881353)
        let officialOutputDateComponents = self.calendar!.dateComponents([ .calendar, .timeZone, .day, .month, .year, .hour, .minute ], from: officialOutput!)
        XCTAssertEqual(officialOutputDateComponents.hour, 7, "Hour should be 7am")
        XCTAssertEqual(officialOutputDateComponents.minute, 4, "Minute should be 4")
        
        let civilOutput = SwiftySunrise.sunPhaseTime(forPhase: .sunrise, withTwilightType: .civil, onDay: inputDate, atLatitude: 51.527383, andLongitude: -0.0881353)
        let civilOutputDateComponents = self.calendar!.dateComponents([ .calendar, .timeZone, .day, .month, .year, .hour, .minute ], from: civilOutput!)
        XCTAssertEqual(civilOutputDateComponents.hour, 6, "Hour should be 6am")
        XCTAssertEqual(civilOutputDateComponents.minute, 23, "Minute should be 23")
        
        let nauticalOutput = SwiftySunrise.sunPhaseTime(forPhase: .sunrise, withTwilightType: .nautical, onDay: inputDate, atLatitude: 51.527383, andLongitude: -0.0881353)
        let nauticalOutputDateComponents = self.calendar!.dateComponents([ .calendar, .timeZone, .day, .month, .year, .hour, .minute ], from: nauticalOutput!)
        XCTAssertEqual(nauticalOutputDateComponents.hour, 5, "Hour should be 5am")
        XCTAssertEqual(nauticalOutputDateComponents.minute, 43, "Minute should be 43")
        
        let astronomicalOutput = SwiftySunrise.sunPhaseTime(forPhase: .sunrise, withTwilightType: .astronomical, onDay: inputDate, atLatitude: 51.527383, andLongitude: -0.0881353)
        let astronomicalOutputDateComponents = self.calendar!.dateComponents([ .calendar, .timeZone, .day, .month, .year, .hour, .minute ], from: astronomicalOutput!)
        XCTAssertEqual(astronomicalOutputDateComponents.hour, 5, "Hour should be 5am")
        XCTAssertEqual(astronomicalOutputDateComponents.minute, 4, "Minute should be 4")
        
    }
    
    func testLondonSunsetTime() {
        
        let inputDate = Date(timeIntervalSince1970: 1478194901) //3rd Nov 2016
        let inputDateComponents = self.calendar!.dateComponents([ .calendar, .day, .month, .year ], from: inputDate)
        
        let output = SwiftySunrise.sunPhaseTime(forPhase: .sunset, withTwilightType: .official, onDay: inputDate, atLatitude: 51.527383, andLongitude: -0.0881353)
        XCTAssertTrue(output != nil, "The sun should set in London on this day")
        
        let outputDateComponents = self.calendar!.dateComponents([ .calendar, .timeZone, .day, .month, .year, .hour, .minute ], from: output!)
        
        //Test everything but hour and minute are equal from input to output
        XCTAssertEqual(inputDateComponents.calendar!, outputDateComponents.calendar!, "Calendar should match between input and output date")
        XCTAssertEqual(inputDateComponents.day!, outputDateComponents.day!, "Day should match between input and output date")
        XCTAssertEqual(inputDateComponents.month!, outputDateComponents.month!, "Month should match between input and output date")
        XCTAssertEqual(inputDateComponents.year!, outputDateComponents.year!, "Year should match between input and output date")
        
        //Test output is UTC timezone
        XCTAssertEqual(outputDateComponents.timeZone!.identifier, "Etc/UTC", "Time zone should be UTC")
        
        //Test that date/time is as expected. 16:22 on 3rd Nov 2016
        XCTAssertEqual(outputDateComponents.year, 2016, "Year should be 2016")
        XCTAssertEqual(outputDateComponents.month, 11, "Month should be 11")
        XCTAssertEqual(outputDateComponents.day, 3, "Day should be the 3rd")
        XCTAssertEqual(outputDateComponents.hour, 16, "Hour should be 4apm")
        XCTAssertEqual(outputDateComponents.minute, 22, "Minute should be 2")
        
        //Formatting time in UTC should equal ""07:04am"
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(identifier: "Etc/UTC")!
        dateFormatter.dateFormat = "HH:mm"
        XCTAssertEqual(dateFormatter.string(from: output!), "16:22", "Time should be 16:22 in UTC")
        
    }
    
    func testSanFranciscoSunriseTime() {
        
        let inputDate = Date(timeIntervalSince1970: 1478194901) //3rd Nov 2016
        let inputDateComponents = self.calendar!.dateComponents([ .calendar, .day, .month, .year ], from: inputDate)
        
        let output = SwiftySunrise.sunPhaseTime(forPhase: .sunrise, withTwilightType: .official, onDay: inputDate, atLatitude: 37.7576171, andLongitude: -122.5776844)
        XCTAssertTrue(output != nil, "The sun should rise in San Francisco on this day")
        
        let outputDateComponents = self.calendar!.dateComponents([ .calendar, .timeZone, .day, .month, .year, .hour, .minute ], from: output!)
        
        //Test everything but hour and minute are equal from input to output
        XCTAssertEqual(inputDateComponents.calendar!, outputDateComponents.calendar!, "Calendar should match between input and output date")
        XCTAssertEqual(inputDateComponents.day!, outputDateComponents.day!, "Day should match between input and output date")
        XCTAssertEqual(inputDateComponents.month!, outputDateComponents.month!, "Month should match between input and output date")
        XCTAssertEqual(inputDateComponents.year!, outputDateComponents.year!, "Year should match between input and output date")
        
        //Test output is UTC timezone
        XCTAssertEqual(outputDateComponents.timeZone!.identifier, "Etc/UTC", "Time zone should be UTC")
        
        //Test that date/time is as expected
        XCTAssertEqual(outputDateComponents.year, 2016, "Year should be 2016")
        XCTAssertEqual(outputDateComponents.month, 11, "Month should be 11")
        XCTAssertEqual(outputDateComponents.day, 3, "Day should be the 3rd")
        XCTAssertEqual(outputDateComponents.hour, 14, "Hour should be 14 UTC")
        XCTAssertEqual(outputDateComponents.minute, 43, "Minute should be 43")
        
        //Formatting time in SF time should equal 6:43am
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(secondsFromGMT: -(8 * 60 * 60)) //- 8 hours
        dateFormatter.dateFormat = "HH:mm"
        XCTAssertEqual(dateFormatter.string(from: output!), "06:43", "Time should be 6:43 in GMT - 8")
        
    }
    
    func testSanFranciscoSunsetTime() {
        
        let inputDate = Date(timeIntervalSince1970: 1478194901) //3rd Nov 2016
        let inputDateComponents = self.calendar!.dateComponents([ .calendar, .day, .month, .year ], from: inputDate)
        
        let output = SwiftySunrise.sunPhaseTime(forPhase: .sunset, withTwilightType: .official, onDay: inputDate, atLatitude: 37.7576171, andLongitude: -122.5776844)
        XCTAssertTrue(output != nil, "The sun should rise in San Francisco on this day")
        
        let outputDateComponents = self.calendar!.dateComponents([ .calendar, .timeZone, .day, .month, .year, .hour, .minute ], from: output!)
        
        //Test everything but hour and minute are equal from input to output
        XCTAssertEqual(inputDateComponents.calendar!, outputDateComponents.calendar!, "Calendar should match between input and output date")
        XCTAssertEqual(inputDateComponents.day!, outputDateComponents.day!, "Day should match between input and output date")
        XCTAssertEqual(inputDateComponents.month!, outputDateComponents.month!, "Month should match between input and output date")
        XCTAssertEqual(inputDateComponents.year!, outputDateComponents.year!, "Year should match between input and output date")
        
        //Test output is UTC timezone
        XCTAssertEqual(outputDateComponents.timeZone!.identifier, "Etc/UTC", "Time zone should be UTC")
        
        //Test that date/time is as expected
        XCTAssertEqual(outputDateComponents.year, 2016, "Year should be 2016")
        XCTAssertEqual(outputDateComponents.month, 11, "Month should be 11")
        XCTAssertEqual(outputDateComponents.day, 3, "Day should be the 3rd")
        XCTAssertEqual(outputDateComponents.hour, 1, "Hour should be 1 UTC")
        XCTAssertEqual(outputDateComponents.minute, 4, "Minute should be 4")
        
        //Formatting time in SF time should equal 6:43am
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(secondsFromGMT: -(8 * 60 * 60)) //- 8 hours
        dateFormatter.dateFormat = "HH:mm"
        XCTAssertEqual(dateFormatter.string(from: output!), "17:04", "Time should be 17:04 in GMT - 8")
        
    }
    
    func testFullYearSunriseForLondon() {
        
        let startOf2016: TimeInterval = 1451606400
        let startOf2017: TimeInterval = 1483228800
        let dayInSeconds: TimeInterval = 60 * 60 * 24
        
        for startOfDayTimeInterval in stride(from: startOf2016, to: startOf2017, by: dayInSeconds) {
            
            let startOfDay = Date(timeIntervalSince1970: startOfDayTimeInterval)
            
            let output = SwiftySunrise.sunPhaseTime(forPhase: .sunrise, withTwilightType: .official, onDay: startOfDay, atLatitude: 51.527383, andLongitude: -0.0881353)
            XCTAssertTrue(output != nil, "The sun should rise in London on this day")
            
            //Between 4 and 8am
            let outputDateComponents = self.calendar!.dateComponents([ .hour ], from: output!)
            XCTAssertGreaterThanOrEqual(outputDateComponents.hour!, 3)
            XCTAssertLessThanOrEqual(outputDateComponents.hour!, 8)
            
        }
        
    }
    
    func testFullYearSunsetForLondon() {
        
        let startOf2016: TimeInterval = 1451606400
        let startOf2017: TimeInterval = 1483228800
        let dayInSeconds: TimeInterval = 60 * 60 * 24
        
        for startOfDayTimeInterval in stride(from: startOf2016, to: startOf2017, by: dayInSeconds) {
            
            let startOfDay = Date(timeIntervalSince1970: startOfDayTimeInterval)
            
            let output = SwiftySunrise.sunPhaseTime(forPhase: .sunset, withTwilightType: .official, onDay: startOfDay, atLatitude: 51.527383, andLongitude: -0.0881353)
            XCTAssertTrue(output != nil, "The sun should set in London on this day")
            
            //Between 3pm and 9pm
            let outputDateComponents = self.calendar!.dateComponents([ .hour ], from: output!)
            XCTAssertGreaterThanOrEqual(outputDateComponents.hour!, 15)
            XCTAssertLessThanOrEqual(outputDateComponents.hour!, 21)
            
        }
        
    }
    
    func testFullYearSunriseForSanFrancisco() {
        
        let startOf2016: TimeInterval = 1451606400
        let startOf2017: TimeInterval = 1483228800
        let dayInSeconds: TimeInterval = 60 * 60 * 24
        
        for startOfDayTimeInterval in stride(from: startOf2016, to: startOf2017, by: dayInSeconds) {
            
            let startOfDay = Date(timeIntervalSince1970: startOfDayTimeInterval)
            
            let output = SwiftySunrise.sunPhaseTime(forPhase: .sunrise, withTwilightType: .official, onDay: startOfDay, atLatitude: 37.7576171, andLongitude: -122.5776844)
            XCTAssertTrue(output != nil, "The sun should rise in San Francisco on this day")
            
            let outputDateComponents = self.calendar!.dateComponents([ .hour ], from: output!)
            XCTAssertGreaterThanOrEqual(outputDateComponents.hour!, 12) //in UTC
            XCTAssertLessThanOrEqual(outputDateComponents.hour!, 15) //in UTC
            
        }
        
    }
    
    func testFullYearSunsetForSanFrancisco() {
        
        let startOf2016: TimeInterval = 1451606400
        let startOf2017: TimeInterval = 1483228800
        let dayInSeconds: TimeInterval = 60 * 60 * 24
        
        for startOfDayTimeInterval in stride(from: startOf2016, to: startOf2017, by: dayInSeconds) {
            
            let startOfDay = Date(timeIntervalSince1970: startOfDayTimeInterval)
            
            let output = SwiftySunrise.sunPhaseTime(forPhase: .sunset, withTwilightType: .official, onDay: startOfDay, atLatitude: 37.7576171, andLongitude: -122.5776844)
            XCTAssertTrue(output != nil, "The sun should set in San Francisco on this day")
            
            //Between 4 and 8am
            let outputDateComponents = self.calendar!.dateComponents([ .hour ], from: output!)
            XCTAssertGreaterThanOrEqual(outputDateComponents.hour!, 0) //UTC
            XCTAssertLessThanOrEqual(outputDateComponents.hour!, 4) //UTC
            
        }
        
    }
    
    func testDateExtension() {
        
        let inputDate = Date(timeIntervalSince1970: 1478194901) //3rd Nov 2016
        
        let normalOutput = SwiftySunrise.sunPhaseTime(forPhase: .sunrise, withTwilightType: .official, onDay: inputDate, atLatitude: 51.527383, andLongitude: -0.0881353)
        let extensionOutput = inputDate.toSunPhase(forPhase: .sunrise, withTwilightType: .official, atLatitude: 51.527383, andLongitude: -0.0881353)
        
        XCTAssertTrue(normalOutput != nil, "The sun should rise in London on this day")
        XCTAssertTrue(extensionOutput != nil, "The sun should rise in London on this day")
        
        XCTAssertEqual(normalOutput, extensionOutput, "The two outputs should be equal")
        
    }
    
    func testDateExtensionInitialiser() {
        
        let normalOutput = SwiftySunrise.sunPhaseTime(forPhase: .sunrise, withTwilightType: .official, onDay: Date(), atLatitude: 51.527383, andLongitude: -0.0881353)
        let extensionOutput = Date(sunPhaseToday: .sunrise, latitude: 51.527383, longitude: -0.0881353)
        
        XCTAssertTrue(normalOutput != nil, "The sun should rise in London on this day")
        XCTAssertTrue(extensionOutput != nil, "The sun should rise in London on this day")
        
        XCTAssertEqual(normalOutput, extensionOutput, "The two outputs should be equal")
        
    }
    
    func testTwilightTypes() {
        
        //Not an exhaustive test, but for now just checking they're in the correct order time wise
        
        let inputDate = Date(timeIntervalSince1970: 1478194901) //3rd Nov 2016
        
        let officialSunset = SwiftySunrise.sunPhaseTime(forPhase: .sunset, withTwilightType: .official, onDay: inputDate, atLatitude: 51.527383, andLongitude: -0.0881353)
        let civilSunset = SwiftySunrise.sunPhaseTime(forPhase: .sunset, withTwilightType: .civil, onDay: inputDate, atLatitude: 51.527383, andLongitude: -0.0881353)
        let nauticalSunset = SwiftySunrise.sunPhaseTime(forPhase: .sunset, withTwilightType: .nautical, onDay: inputDate, atLatitude: 51.527383, andLongitude: -0.0881353)
        let astronomicalSunset = SwiftySunrise.sunPhaseTime(forPhase: .sunset, withTwilightType: .astronomical, onDay: inputDate, atLatitude: 51.527383, andLongitude: -0.0881353)
        
        XCTAssertNotNil(officialSunset)
        XCTAssertNotNil(civilSunset)
        XCTAssertNotNil(nauticalSunset)
        XCTAssertNotNil(astronomicalSunset)
        
        XCTAssertGreaterThan(astronomicalSunset!.timeIntervalSince1970, nauticalSunset!.timeIntervalSince1970, "Astronomical sunset should be after nautical")
        XCTAssertGreaterThan(nauticalSunset!.timeIntervalSince1970, civilSunset!.timeIntervalSince1970, "Nautical sunset should be after civil")
        XCTAssertGreaterThan(civilSunset!.timeIntervalSince1970, officialSunset!.timeIntervalSince1970, "Civil sunset should be after official")
        
    }
    
    func testMidnightSun() {
        
        //No sunrise/sunset in Iceland at this time
        let inputDate = Date(timeIntervalSince1970: 1466380800) //20th June 2016
        
        let icelandSunrise = SwiftySunrise.sunPhaseTime(forPhase: .sunrise, withTwilightType: .astronomical, onDay: inputDate, atLatitude: 64.9631, andLongitude: 19.0208)
        XCTAssertNil(icelandSunrise, "The sun does not rise in Iceland on this date!")
        
        let icelandSunset = SwiftySunrise.sunPhaseTime(forPhase: .sunset, withTwilightType: .astronomical, onDay: inputDate, atLatitude: 64.9631, andLongitude: 19.0208)
        XCTAssertNil(icelandSunset, "The sun does not set in Iceland on this date!")
        
        //But normally it does, just to make sure...
        let inputDateB = Date(timeIntervalSince1970: 1478194901) //20th June 2016
        let icelandSunriseB = SwiftySunrise.sunPhaseTime(forPhase: .sunrise, withTwilightType: .astronomical, onDay: inputDateB, atLatitude: 64.9631, andLongitude: 19.0208)
        XCTAssertNotNil(icelandSunriseB, "The sun does not rise in Iceland on this date!")
        
    }
    
}
