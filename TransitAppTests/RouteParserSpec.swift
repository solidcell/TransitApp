import Quick
import Nimble
import RealmSwift
@testable import TransitApp

class RouteParserSpec: QuickSpec {
    override func spec() {
        describe("parse") {

            var realm: Realm!
            var vbbProvider: TransitApp.Provider! // TODO rename to `TransitProvider` and remove module prefix
            var googleProvider: TransitApp.Provider!
            
            beforeEach {
                Realm.Configuration.defaultConfiguration.inMemoryIdentifier = self.name
                realm = try! Realm()
                
                vbbProvider = Provider(name: "vbb", iconURL: "", disclaimer: "")
                googleProvider = Provider(name: "google", iconURL: "", disclaimer: "")
                try! realm.write {
                    realm.add([vbbProvider, googleProvider])
                }
            }

            it("parses Routes from JSON") {
                let subject = RouteParser(realm: realm)
                let json = JSONParser().parse(filename: "TestRouteJSON")
                let result = subject.parse(json: json)
                
                expect(result.count).to(equal(2))

                let first = result.first!
                expect(first.provider.name).to(equal("vbb"))
                expect(first.type).to(equal("public_transport"))

                let second = result[1]
                expect(second.provider.name).to(equal("google"))
                expect(second.type).to(equal("private_bike"))
            }

        }
    }
}
