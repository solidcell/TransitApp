import Quick
import Nimble
import RealmSwift
@testable import TransitApp

class ScooterParserSpec: TransitAppSpec {
    override func spec() {
        super.spec()
        
        describe("parse") {
            it("parses Scooters from JSON") {
                let subject = ScooterParser()
                let json = JSONParser().parse(filename: "TestScooterJSON")
                let result = subject.parse(json: json)
                
                expect(result.count).to(equal(2))
                
                let first = result.first!
                expect(first.longitude).to(equal(13.415355))
                expect(first.latitude).to(equal(52.517223))
                expect(first.energyLevel).to(equal(70))
                expect(first.licensePlate).to(equal("198FCE"))

                let second = result[1]
                expect(second.longitude).to(equal(13.360313))
                expect(second.latitude).to(equal(52.494534))
                expect(second.energyLevel).to(equal(53))
                expect(second.licensePlate).to(equal("201FCE"))
            }
        }
        
    }
}
