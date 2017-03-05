

class ScooterUpdater {

    private let scooterFetcher: ScooterFetching
    weak var delegate: ScooterUpdaterDelegate?

    init(scooterFetcher: ScooterFetching) {
        self.scooterFetcher = scooterFetcher
        self.scooterFetcher.delegate = self
    }

    func start() {
        scooterFetcher.start()
    }
    
}

extension ScooterUpdater: ScooterFetcherDelegate {

    func fetchedScooters(scooters: [Scooter]) {
        delegate?.received(scooters: scooters)
    }
}
