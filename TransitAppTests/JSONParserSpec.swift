import Quick
import Nimble
import SwiftyJSON
@testable import TransitApp

class JSONParserSpec: TransitAppSpec {
    
    func testParsingJSONFromAJSONFile() {
        let subject = JSONParser()
        let result = subject.parse(filename: "TestRandomJSON")
        XCTAssertEqual(result["key1"], ["item1", "item2"])
        XCTAssertEqual(result["key2"], ["key3": "item3"])
    }
}
