import SwiftyJSON
import RealmSwift

class CoupParser {
    
    private static let seedScooterJSONfilename = "CoupScooterData"
    private static let seedBusinessAreaJSONfilename = "CoupBusinessAreasData"
    private let realm: Realm
    private let jsonParser = JSONParser()
    private let scooterParser = ScooterParser()
    private let businessAreaParser = BusinessAreaParser()

    init(realm: Realm) {
        self.realm = realm
    }
    
    func seedIfNeeded() {
        seedScootersIfNeeded()
        seedBusinessAreasIfNeeded()
    }

    private func seedScootersIfNeeded() {
        if realm.scooters.count > 0 { return }
        
        let seedJSON = jsonParser.parse(filename: CoupParser.seedScooterJSONfilename)
        seedScooters(json: seedJSON)
    }

    private func seedBusinessAreasIfNeeded() {
        if realm.businessAreas.count > 0 { return }
        
        let seedJSON = jsonParser.parse(filename: CoupParser.seedBusinessAreaJSONfilename)
        seedBusinessAreas(json: seedJSON)
    }

    private func seedScooters(json: JSON) {
        let scooters = scooterParser.parse(json: json)
        try! realm.write {
            realm.add(scooters)
        }
    }

    private func seedBusinessAreas(json: JSON) {
        let businessAreas = businessAreaParser.parse(json: json)
        try! realm.write {
            realm.add(businessAreas)
        }
    }
    
}
