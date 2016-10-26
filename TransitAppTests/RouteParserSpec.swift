import Quick
import Nimble
import RealmSwift
@testable import TransitApp

class RouteParserSpec: QuickSpec {
    override func spec() {
        describe("parse") {
            it("parses Routes from JSON") {
                let subject = RouteParser()
                let json = JSONParser().parse(filename: "TestRouteJSON")
                let result = subject.parse(json: json)
                
                expect(result.count).to(equal(2))

                let first = result.first!
                expect(first.type).to(equal("public_transport"))

                let second = result[1]
                expect(second.type).to(equal("private_bike"))
            }
        }
    }
}
