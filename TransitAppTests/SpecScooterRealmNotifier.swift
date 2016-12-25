import RealmSwift
@testable import TransitApp

class SpecScooterRealmNotifier: ScooterRealmNotifier {

    var callbackExecuted: Bool {
        defer { _callbackExecuted = false }
        return _callbackExecuted
    }
    private var _callbackExecuted = false

    override func notificationCallback(changes: RealmCollectionChange<Results<Scooter>>) -> Void {
        super.notificationCallback(changes: changes)
        _callbackExecuted = true
    }
}
