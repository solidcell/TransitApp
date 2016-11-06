import RealmSwift

class ScooterUpdater {

    fileprivate let scooterWriter: ScooterWriter
    private let scooterFetcher: ScooterFetching

    init(scooterWriter: ScooterWriter, scooterFetcher: ScooterFetching) {
        self.scooterWriter = scooterWriter
        self.scooterFetcher = scooterFetcher
        self.scooterFetcher.delegate = self
    }

    func start() {
        scooterFetcher.start()
    }
    
}

extension ScooterUpdater: ScooterFetcherDelegate {

    func fetchedScooters(scooters: [Scooter]) {
        scooterWriter.addOrUpdate(scooters: scooters)
    }
    
}
