import RealmSwift

// NOTE: This class is untested!
//
// It's a slim wrapper around async Realm code.
// Be sure to manually test any changes you make.

class MapAnnotationDataSource: MapAnnotationDataSourcing, RealmNotifierDelegate {

    weak var delegate: MapAnnotationProvider? {
        willSet {
            if delegate != nil {
                fatalError("There is already a delegate set. Create a new instance instead, otherwise the current delegate would stop receiving notifications.")
            }
        }
        didSet {
            start()
        }
    }
    private let scooterWriter: ScooterWriter

    init(scooterWriter: ScooterWriter) {
        self.scooterWriter = scooterWriter
        self.scooterWriter.delegate = self
    }

    private func start() {
        scooterWriter.start()
    }

    func didReceiveRealmNotification(changes: RealmCollectionChange<Results<Scooter>>) {
        switch changes {
        case .initial(let results):
            handleInitial(results: results)
        case .update(let results,
                     deletions: let deletions,
                     insertions: let insertions,
                     modifications: let modifications):
            handleUpdate(results: results,
                               deletions: deletions,
                               insertions: insertions,
                               modifications: modifications)
        case .error:
            fatalError("Realm Notification error isn't expected/supported")
        }
    }

    private func handleInitial(results: Results<Scooter>) {
        let scooters = Array(results)
        self.delegate?.initialData(scooters: scooters)
    }

    private func handleUpdate(results: Results<Scooter>,
                              deletions: [Int],
                              insertions: [Int],
                              modifications: [Int]) {
        let inserted = insertions.map(scooterForIndexIn(results))
        let modified = modifications.map(scooterForIndexIn(results))
        self.delegate?.dataUpdated(deletions: [], insertions: inserted, modifications: modified)
    }

    private func scooterForIndexIn(_ results: Results<Scooter>) -> ((Int) -> Scooter) {
        return { (index: Int) -> Scooter in
            return results[index]
        }
    }

}

protocol MapAnnotationDataSourcing {

    weak var delegate: MapAnnotationProvider? { get set }

}
