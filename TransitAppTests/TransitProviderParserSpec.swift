import Quick
import Nimble
import RealmSwift
@testable import TransitApp

class TransitProviderParserSpec: TransitAppSpec {
    override func spec() {
        super.spec()
        
        describe("parse") {
            it("parses TransitProviders from JSON") {
                let subject = TransitProviderParser()
                let json = JSONParser().parse(filename: "TestTransitProviderJSON")
                let result = subject.parse(json: json)
                
                expect(result.count).to(equal(2))
                
                let first = result.first!
                expect(first.name).to(equal("vbb"))
                expect(first.iconURL).to(equal("vbb icon URL"))
                expect(first.disclaimer).to(equal("vbb disclaimer"))
                expect(first.iOSiTunesURL).to(beNil())
                expect(first.iOSappURL).to(beNil())
                expect(first.androidPackageName).to(beNil())
                expect(first.displayName).to(beNil())
                
                let second = result[1]
                expect(second.name).to(equal("drivenow"))
                expect(second.iconURL).to(equal("drivenow icon URL"))
                expect(second.disclaimer).to(equal("drivenow disclaimer"))
                expect(second.iOSiTunesURL).to(equal("drivenow iOS iTunes URL"))
                expect(second.iOSappURL).to(equal("drivenow iOS app URL"))
                expect(second.androidPackageName).to(equal("drivenow Android name"))
                expect(second.displayName).to(equal("drivenow display name"))
            }
        }
        
    }
}
