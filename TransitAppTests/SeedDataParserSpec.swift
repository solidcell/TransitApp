import Quick
import Nimble
import RealmSwift
@testable import TransitApp

class SeedDataParserSpec: TransitAppSpec {
    override func spec() {
        super.spec()

        describe("seedIfNeeded") {
            it("saves the seed data if the app currently has none") {
                let subject = SeedDataParser(realm: self.realm)

                expect(self.realm.transitProviders.count).to(equal(0))

                subject.seedIfNeeded()

                expect(self.realm.transitProviders.count).to(equal(6))
            }
        }
    }
}
