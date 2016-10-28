import Quick
import Nimble
import RealmSwift
@testable import TransitApp

class SeedDataParserSpec: TransitAppSpec {
    override func spec() {
        super.spec()

        var subject: SeedDataParser!

        beforeEach {
            subject = SeedDataParser(realm: self.realm)
        }

        describe("seedIfNeeded") {
            it("saves the seed data if the app currently has none") {
                expect(self.realm.transitProviders.count).to(equal(0))
                expect(self.realm.routes.count).to(equal(0))

                subject.seedIfNeeded()

                expect(self.realm.transitProviders.count).to(equal(6))
                expect(self.realm.routes.count).to(equal(9))
            }

            it("does nothing if data already exists") {
                subject.seedIfNeeded()

                expect(self.realm.transitProviders.count).to(equal(6))
                expect(self.realm.routes.count).to(equal(9))
                
                subject.seedIfNeeded()

                expect(self.realm.transitProviders.count).to(equal(6))
                expect(self.realm.routes.count).to(equal(9))
            }
        }
    }
}
