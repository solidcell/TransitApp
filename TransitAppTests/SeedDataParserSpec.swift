import Quick
import Nimble
import RealmSwift
@testable import TransitApp

class SeedDataParserSpec: TransitAppSpec {

    var subject: SeedDataParser!

    override func setUp() {
        super.setUp()
        subject = SeedDataParser(realm: self.realm)
    }

    func testSeedIfNeededSavesSeedDataIfTheAppCurrentlyHasNone() {
        XCTAssertEqual(self.realm.businessAreas.count, 0)

        subject.seedIfNeeded()

        XCTAssertEqual(self.realm.businessAreas.count, 3)
    }

    func testSeedIfNeededDoesNothingIfDataAlreadyExists() {
        subject.seedIfNeeded()

        XCTAssertEqual(self.realm.businessAreas.count, 3)

        subject.seedIfNeeded()

        XCTAssertEqual(self.realm.businessAreas.count, 3)
    }
}
