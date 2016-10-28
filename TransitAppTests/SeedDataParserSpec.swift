import Quick
import Nimble
import RealmSwift
@testable import TransitApp

class SeedDataParserSpec: QuickSpec {
    override func spec() {
            
        var realm: Realm!

        beforeEach {
            Realm.Configuration.defaultConfiguration.inMemoryIdentifier = NSUUID().uuidString
            realm = try! Realm()
        }

        describe("seedIfNeeded") {
            
            it("saves the seed data if the app currently has none") {
                let subject = SeedDataParser(realm: realm)

                expect(realm.transitProviders.count).to(equal(0))

                subject.seedIfNeeded()

                expect(realm.transitProviders.count).to(equal(6))
            }
            
        }
    }
}
