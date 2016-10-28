import Foundation
import SwiftyJSON
import RealmSwift

class SeedDataParser {

    private let door2DoorParser: Door2DoorParser

    init(realm: Realm) {
        self.door2DoorParser = Door2DoorParser(realm: realm)
    }
    
    func seedIfNeeded() {
        door2DoorParser.seedIfNeeded()
    }
    
}
