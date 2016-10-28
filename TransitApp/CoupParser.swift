import SwiftyJSON
import RealmSwift

class CoupParser {
    
    private static let seedJSONfilename = "CoupScooterData"
    private let realm: Realm
    private let jsonParser = JSONParser()
    private let scooterParser = ScooterParser()

    init(realm: Realm) {
        self.realm = realm
    }
    
    func seedIfNeeded() {
        if realm.scooters.count > 0 { return }
        
        let seedJSON = jsonParser.parse(filename: CoupParser.seedJSONfilename)
        seedScooters(json: seedJSON)
    }

    private func seedScooters(json: JSON) {
        let scooters = scooterParser.parse(json: json)
        try! realm.write {
            realm.add(scooters)
        }
    }
    
}
