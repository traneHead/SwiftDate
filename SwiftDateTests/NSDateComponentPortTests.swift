//
//  NSDateComponentPortTests.swift
//  NSDate
//
//  Created by Jeroen Houtzager on 07/11/15.
//  Copyright © 2015 CocoaPods. All rights reserved.
//
// https://github.com/Quick/Quick


import Quick
import Nimble
@testable import SwiftDate

class NSDateComponentPortSpec: QuickSpec {
    
    override func spec() {
        
        describe("NSDateComponentPort") {
            
            context("valueForComponentYMD") {
                
                let date = NSDate(era: 1, year: 2002, month: 3, day: 4, hour: 5, minute: 6, second: 7, nanosecond: 87654321)
                
                it("should report a valid date") {
                    expect(date).toNot(beNil())
                }
                
                it("should report a valid era") {
                    expect(date!.era) == 1
                }
                
                it("should report a valid year") {
                    expect(date!.year) == 2002
                }
                
                it("should report a valid month") {
                    expect(date!.month) == 3
                }
                
                it("should report a valid day") {
                    expect(date!.day) == 4
                }
                
                it("should report a valid hour") {
                    expect(date!.hour) == 5
                }
                
                it("should report a valid minute") {
                    expect(date!.minute) == 6
                }
                
                it("should report a valid second") {
                    expect(date!.second) == 7
                }
                
                it("should report a valid nanosecond") {
                    expect(date!.nanosecond).to(beCloseTo(87654321, within: 10))
                }
                
            }
            
            context("valueForComponentYWD") {
                
                let date = NSDate(era: 1, yearForWeekOfYear: 2, weekOfYear: 3, weekday: 4)
                
                it("should report a valid date") {
                    expect(date).toNot(beNil())
                }
                
                it("should report a valid era") {
                    expect(date!.era) == 1
                }
                
                it("should report a valid yearForWeekOfYear") {
                    expect(date!.yearForWeekOfYear) == 2
                }
                
                it("should report a valid weekOfYear") {
                    expect(date!.weekOfYear) == 3
                }
                
                it("should report a valid weekday") {
                    expect(date!.weekday) == 4
                }
                
                it("should report a valid hour") {
                    expect(date!.hour) == 0
                }
                
                it("should report a valid minute") {
                    expect(date!.minute) == 0
                }
                
                it("should report a valid second") {
                    expect(date!.second) == 0
                }
                
                it("should report a valid nanosecond") {
                    expect(date!.nanosecond) == 0
                }
                
            }
            
            context("component initialisation") {
                
                it("should return a midnight date YMD initialisation (summer)") {
                    let date = NSDate(year: 2002, month: 6, day: 23)
                    
                    expect(date).toNot(beNil())
                    let calendar = NSCalendar.currentCalendar()
                    let components = calendar.components([.Year, .Month, .Day], fromDate: date!)
                    expect(components.year) == 2002
                    expect(components.month) == 6
                    expect(components.day) == 23
                    expect(components.hour) == NSDateComponentUndefined
                    expect(components.minute) == NSDateComponentUndefined
                }
                
                it("should return a midnight date YMD initialisation (winter)") {
                    let date = NSDate(year: 2002, month: 12, day: 23)
                    
                    expect(date).toNot(beNil())
                    let calendar = NSCalendar.currentCalendar()
                    let components = calendar.components([.Year, .Month, .Day], fromDate: date!)
                    expect(components.year) == 2002
                    expect(components.month) == 12
                    expect(components.day) == 23
                }
                
                it("should return a midnight date with nil YMD initialisation") {
                    let date = NSDate(year: 1912, month: 6, day: 23)!
                    
                    let calendar = NSCalendar.currentCalendar()
                    let components = calendar.components([.Year, .Month, .Day], fromDate: date)
                    expect(components.year) == 1912
                    expect(components.month) == 6
                    expect(components.day) == 23
                }
                
                
                it("should return a midnight date with nil YWD initialisation") {
                    let newYork = DateRegion(localeID: "en_US")
                    let date = NSDate(yearForWeekOfYear: 1492, weekOfYear: 15, weekday: 4, region: newYork)!
                    let components = NSDateComponents()
                    components.yearForWeekOfYear = 1492
                    components.weekOfYear = 15
                    components.weekday = 4
                    components.calendar = newYork.calendar
                    components.timeZone = newYork.timeZone
                    let expectedDate = newYork.calendar.dateFromComponents(components)!
                    
                    expect(date) == expectedDate
                }
                
                
                it("should return a date of 0001-01-01 00:00:00.000 in the default region for component initialisation") {
                    let components = NSDateComponents()
                    let date = NSDate(components: components)!
                    
                    expect(date).toNot(beNil())
                    let calendar = NSCalendar.currentCalendar()
                    let testComponents = calendar.components([.Year, .Month, .Day, .Hour, .Minute, .Second], fromDate: date)
                    expect(testComponents.year) == 1
                    expect(testComponents.month) == 1
                    expect(testComponents.day) == 1
                    expect(testComponents.hour) == 0
                    expect(testComponents.minute) == 0
                    expect(testComponents.second) == 0
                }
            }
            
            context("special components") {
                
                let date = NSDate(year: 2015, month: 12, day: 16)!
                let newYork = DateRegion(calendarID: NSCalendarIdentifierGregorian, timeZoneID: "America/New York", localeID: "en_US")
                
                it("should report the proper first day of the week") {
                    let firstDay = date.firstDayOfWeek(inRegion: newYork)!
                    expect(firstDay) == 13
                }
                
                it("should report the proper last day of the week") {
                    let firstDay = date.lastDayOfWeek(inRegion: newYork)!
                    expect(firstDay) == 19
                }
                
            }
            
        }
    }
}

