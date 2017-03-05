import SwiftyJSON
import RealmSwift

class SeedDataParser {
    
    private static let seedBusinessAreaJSONfilename = "CoupBusinessAreasData"
    private let jsonParser = JSONParser()
    private let businessAreaParser = BusinessAreaParser()
    
    var businessAreas: [BusinessArea] {
        let json = jsonParser.parse(filename: SeedDataParser.seedBusinessAreaJSONfilename)
        return businessAreaParser.parse(json: json)
    }
}
