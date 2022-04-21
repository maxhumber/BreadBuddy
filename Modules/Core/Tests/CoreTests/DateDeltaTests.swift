@testable import Core
import XCTest

final class DateDeltaTests: XCTestCase {
    func testDateDelta29Days() {
        let start = Date()
        let end = Calendar.current.date(byAdding: .day, value: 29, to: start)!
        let result = start.delta(to: end)
        XCTAssertEqual(result, "29 days")
    }
    
    func testDateDelta28Days() {
        let start = Date()
        let end = Calendar.current.date(byAdding: .day, value: 4*7, to: start)!
        let result = start.delta(to: end)
        XCTAssertEqual(result, "4 weeks")
    }
    
    func testDateDelta15Days() {
        let start = Date()
        let end = Calendar.current.date(byAdding: .day, value: 15, to: start)!
        let result = start.delta(to: end)
        XCTAssertEqual(result, "15 days")
    }
    
    func testDateDelta14Days() {
        let start = Date()
        let end = Calendar.current.date(byAdding: .day, value: 14, to: start)!
        let result = start.delta(to: end)
        print(result)
        XCTAssertEqual(result, "2 weeks")
    }
    
    func testDateDelta13Days() {
        let start = Date()
        let end = Calendar.current.date(byAdding: .day, value: 13, to: start)!
        let result = start.delta(to: end)
        XCTAssertEqual(result, "13 days")
    }
    
    func testDateDelta7Days() {
        let start = Date()
        let end = Calendar.current.date(byAdding: .day, value: 7, to: start)!
        let result = start.delta(to: end)
        XCTAssertEqual(result, "1 week")
    }
    
    func testDateDelta6Days() {
        let start = Date()
        let end = Calendar.current.date(byAdding: .day, value: 6, to: start)!
        let result = start.delta(to: end)
        XCTAssertEqual(result, "6 days")
    }
    
    func testDateDelta60Hours() {
        let start = Date()
        let end = Calendar.current.date(byAdding: .hour, value: 60, to: start)!
        let result = start.delta(to: end)
        XCTAssertEqual(result, "Over 2 days")
    }
    
    func testDateDelta50Hours() {
        let start = Date()
        let end = Calendar.current.date(byAdding: .hour, value: 50, to: start)!
        let result = start.delta(to: end)
        XCTAssertEqual(result, "2 days")
    }
    
    func testDateDelta2Days() {
        let start = Date()
        let end = Calendar.current.date(byAdding: .day, value: 2, to: start)!
        let result = start.delta(to: end)
        XCTAssertEqual(result, "2 days")
    }
    
    func testDateDelta32hours() {
        let start = Date()
        let end = Calendar.current.date(byAdding: .hour, value: 32, to: start)!
        let result = start.delta(to: end)
        XCTAssertEqual(result, "Over 1 day")
    }
    
    func testDateDelta25hours() {
        let start = Date()
        let end = Calendar.current.date(byAdding: .hour, value: 25, to: start)!
        let result = start.delta(to: end)
        XCTAssertEqual(result, "1 day")
    }
    
    func testDateDelta1Day() {
        let start = Date()
        let end = Calendar.current.date(byAdding: .day, value: 1, to: start)!
        let result = start.delta(to: end)
        XCTAssertEqual(result, "1 day")
    }
    
    func testDateDelta24Hours() {
        let start = Date()
        let end = Calendar.current.date(byAdding: .hour, value: 24, to: start)!
        let result = start.delta(to: end)
        XCTAssertEqual(result, "1 day")
    }
    
    func testDateDelta23Hours() {
        let start = Date()
        let end = Calendar.current.date(byAdding: .hour, value: 23, to: start)!
        let result = start.delta(to: end)
        XCTAssertEqual(result, "23 hours")
    }
    
    func testDateDelta606Minutes() {
        let start = Date()
        let end = Calendar.current.date(byAdding: .minute, value: 606, to: start)!
        let result = start.delta(to: end)
        XCTAssertEqual(result, "Over 10 hours")
    }
    
    func testDateDelta600Minutes() {
        let start = Date()
        let end = Calendar.current.date(byAdding: .minute, value: 600, to: start)!
        let result = start.delta(to: end)
        XCTAssertEqual(result, "10 hours")
    }
    
    func testDateDelta66Minutes() {
        let start = Date()
        let end = Calendar.current.date(byAdding: .minute, value: 66, to: start)!
        let result = start.delta(to: end)
        XCTAssertEqual(result, "Over 1 hour")
    }
    
    func testDateDelta65Minutes() {
        let start = Date()
        let end = Calendar.current.date(byAdding: .minute, value: 65, to: start)!
        let result = start.delta(to: end)
        XCTAssertEqual(result, "1 hour")
    }
    
    func testDateDelta60Minutes() {
        let start = Date()
        let end = Calendar.current.date(byAdding: .minute, value: 60, to: start)!
        let result = start.delta(to: end)
        XCTAssertEqual(result, "1 hour")
    }

    func testDateDelta2Minutes() {
        let start = Date()
        let end = Calendar.current.date(byAdding: .minute, value: 2, to: start)!
        let result = start.delta(to: end)
        XCTAssertEqual(result, "2 mins")
    }
    
    func testDateDelta1Minute() {
        let start = Date()
        let end = Calendar.current.date(byAdding: .minute, value: 1, to: start)!
        let result = start.delta(to: end)
        XCTAssertEqual(result, "1 min")
    }
}
