import Quick
import Nimble
import SwiftyJSON
@testable import TransitApp

class JSONParserSpec: QuickSpec {
    override func spec() {
        describe("parse") {
            it("parses JSON from a JSON file") {
                let subject = JSONParser()
                let result = subject.parse(filename: "TestData")
                expect(result["key1"]).to(equal(["item1", "item2"]))
                expect(result["key2"]).to(equal(["key3": "item3"]))
            }
        }
    }
}
