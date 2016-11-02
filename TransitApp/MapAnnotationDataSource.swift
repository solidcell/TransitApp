import RealmSwift

// NOTE: This class is untested!
//
// It's a slim wrapper around async Realm code.
// Be sure to manually test any changes you make.

class MapAnnotationDataSource: MapAnnotationDataSourcing {
    
    weak var delegate: MapAnnotationProvider? {
        willSet {
            if delegate != nil {
                fatalError("There is already a delegate set. Create a new instance instead, otherwise the current delegate would stop receiving notifications.")
            }
        }
    }
    private var token: NotificationToken?

    init(results: Results<Scooter>) {
        self.token = results.addNotificationBlock { [weak self] changes in
            switch changes {
            case .update(let results,
                         deletions: let deletions,
                         insertions: let insertions,
                         modifications: let modifications):
                self?.handleUpdate(results: results,
                                   deletions: deletions,
                                   insertions: insertions,
                                   modifications: modifications)
            default:
                fatalError("The other cases aren't supported yet")
            }
        }
    }

    private func handleUpdate(results: Results<Scooter>,
                              deletions: [Int],
                              insertions: [Int],
                              modifications: [Int]) {
        let inserted = insertions.map(scooterForIndexIn(results))
        self.delegate?.dataUpdated(deletions: [], insertions: inserted, modifications: [])
    }

    private func scooterForIndexIn(_ results: Results<Scooter>) -> ((Int) -> Scooter) {
        return { (index: Int) -> Scooter in
            return results[index]
        }
    }

    deinit {
        self.token?.stop()
    }

}

protocol MapAnnotationDataSourcing {

    weak var delegate: MapAnnotationProvider? { get set }

}
