import Quick
import RealmSwift
@testable import TransitApp

class TransitAppSpec: QuickSpec {
    
    var realm: Realm {
        if let _realm = _realm { return _realm }

        Realm.Configuration.defaultConfiguration.inMemoryIdentifier = NSUUID().uuidString
        let newRealm = try! Realm()
        _realm = newRealm
        return newRealm
    }

    private func newRealm() {
        _realm = nil
    }

    private var _realm: Realm?
    
    override func spec() {
        beforeEach {
            self.newRealm()
        }
    }
}
