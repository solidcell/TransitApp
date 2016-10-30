import Quick
import Nimble
import RealmSwift
@testable import TransitApp

class BusinessAreaParserSpec: TransitAppSpec {
    override func spec() {
        super.spec()
        
        describe("parse") {
            it("parses BusinessAreas from JSON") {
                let subject = BusinessAreaParser()
                let json = JSONParser().parse(filename: "TestBusinessAreaJSON")
                let result = subject.parse(json: json)
                
                expect(result).to(haveCount(1))
                
                let businessArea = result.first!
                let coordinates = businessArea.coordinates

                expect(coordinates).to(haveCount(5))

                let first = coordinates.first!
                expect(first.longitude).to(equal(13.354353904724121))
                expect(first.latitude).to(equal(52.4982496804861))
                
                let second = coordinates[1]
                expect(second.longitude).to(equal(13.353924751281738))
                expect(second.latitude).to(equal(52.49465717485156))
            }
        }
        
    }
}
