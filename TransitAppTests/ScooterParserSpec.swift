import XCTest
import RealmSwift
@testable import TransitApp

class ScooterParserSpec: TransitAppSpec {
    
    func testParsingScootersFromJSON() {
        let subject = ScooterParser()
        let json = JSONParser().parse(filename: "TestScooterJSON")
        let result = subject.parse(json: json)

        XCTAssertEqual(result.count, 2)

        let first = result.first!
        XCTAssertEqual(first.longitude, 13.415355)
        XCTAssertEqual(first.latitude, 52.517223)
        XCTAssertEqual(first.energyLevel, 70)
        XCTAssertEqual(first.licensePlate, "198FCE")

        let second = result[1]
        XCTAssertEqual(second.longitude, 13.360313)
        XCTAssertEqual(second.latitude, 52.494534)
        XCTAssertEqual(second.energyLevel, 53)
        XCTAssertEqual(second.licensePlate, "201FCE")
    }
}
