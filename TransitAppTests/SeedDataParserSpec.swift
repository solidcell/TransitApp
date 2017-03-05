import XCTest
import RealmSwift
@testable import TransitApp

class SeedDataParserSpec: TransitAppSpec {

    var subject: SeedDataParser!

    override func setUp() {
        super.setUp()
        subject = SeedDataParser(realm: realm)
    }

    func testSeedIfNeededSavesSeedDataIfTheAppCurrentlyHasNone() {
        XCTAssertEqual(realm.businessAreas.count, 0)

        subject.seedIfNeeded()

        XCTAssertEqual(realm.businessAreas.count, 3)
    }

    func testSeedIfNeededDoesNothingIfDataAlreadyExists() {
        subject.seedIfNeeded()

        XCTAssertEqual(realm.businessAreas.count, 3)

        subject.seedIfNeeded()

        XCTAssertEqual(realm.businessAreas.count, 3)
    }
}
