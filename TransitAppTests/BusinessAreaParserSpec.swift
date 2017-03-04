import XCTest
import RealmSwift
@testable import TransitApp

class BusinessAreaParserSpec: TransitAppSpec {

    func testParsingBusinessAreasFromJSON() {
        let subject = BusinessAreaParser()
        let json = JSONParser().parse(filename: "TestBusinessAreaJSON")
        let result = subject.parse(json: json)

        XCTAssertEqual(result.count, 1)

        let businessArea = result.first!
        let coordinates = businessArea.coordinates

        XCTAssertEqual(coordinates.count, 5)

        let first = coordinates.first!
        XCTAssertEqual(first.longitude, 13.354353904724121)
        XCTAssertEqual(first.latitude, 52.4982496804861)

        let second = coordinates[1]
        XCTAssertEqual(second.longitude, 13.353924751281738)
        XCTAssertEqual(second.latitude, 52.49465717485156)
    }
}
