class ScooterUpdater: ScooterFetcherDelegate {

    private let scooterFetcher: ScooterFetcher
    weak var delegate: ScooterUpdaterDelegate?

    init(scooterFetcher: ScooterFetcher) {
        self.scooterFetcher = scooterFetcher
        self.scooterFetcher.delegate = self
    }

    func start() {
        scooterFetcher.start()
    }

    func fetchedScooters(scooters: [Scooter]) {
        delegate?.received(scooters: scooters)
    }
}

protocol ScooterFetcherDelegate: class {

    func fetchedScooters(scooters: [Scooter])
}
