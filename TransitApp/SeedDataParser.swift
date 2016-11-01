import SwiftyJSON
import RealmSwift

class SeedDataParser {
    
    private static let seedBusinessAreaJSONfilename = "CoupBusinessAreasData"
    private let realm: Realm
    private let jsonParser = JSONParser()
    private let businessAreaParser = BusinessAreaParser()

    init(realm: Realm) {
        self.realm = realm
    }
    
    func seedIfNeeded() {
        seedBusinessAreasIfNeeded()
    }

    private func seedBusinessAreasIfNeeded() {
        if realm.businessAreas.count > 0 { return }
        
        let seedJSON = jsonParser.parse(filename: SeedDataParser.seedBusinessAreaJSONfilename)
        seedBusinessAreas(json: seedJSON)
    }

    private func seedBusinessAreas(json: JSON) {
        let businessAreas = businessAreaParser.parse(json: json)
        try! realm.write {
            realm.add(businessAreas)
        }
    }
    
}
