import RealmSwift

class ScooterWriter {

    weak var delegate: RealmNotifierDelegate?
    private var token: NotificationToken?
    private let results: Results<Scooter>
    private let realm: Realm

    init(realm: Realm) {
        self.realm = realm
        self.results = realm.scooters
    }

    func notificationCallback(changes: RealmCollectionChange<Results<Scooter>>) -> Void {
        delegate?.didReceiveRealmNotification(changes: changes)
    }
    
    func start() {
        if token != nil { fatalError("notification has already been subscribed to.") }
        token = results.addNotificationBlock { [weak self] changes in
            self?.notificationCallback(changes: changes)
        }
    }

    func addOrUpdate(scooters: [Scooter]) {
        try! realm.write {
            realm.add(scooters, update: true)
        }
    }

    deinit {
        token?.stop()
    }
    
}

protocol RealmNotifierDelegate: class {

    func didReceiveRealmNotification(changes: RealmCollectionChange<Results<Scooter>>)

}
