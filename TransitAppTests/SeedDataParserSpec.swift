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
                expect(self.realm.scooters).to(beEmpty())
                expect(self.realm.businessAreas).to(beEmpty())

                subject.seedIfNeeded()

                expect(self.realm.scooters).to(haveCount(158))
                expect(self.realm.businessAreas).to(haveCount(3))
            }

            it("does nothing if data already exists") {
                subject.seedIfNeeded()

                expect(self.realm.scooters).to(haveCount(158))
                expect(self.realm.businessAreas).to(haveCount(3))
                
                subject.seedIfNeeded()

                expect(self.realm.scooters).to(haveCount(158))
                expect(self.realm.businessAreas).to(haveCount(3))
            }
        }
    }
}
