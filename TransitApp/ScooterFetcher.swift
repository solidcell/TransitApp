import SwiftyJSON

class ScooterFetcher: ScooterFetching {

    weak var delegate: ScooterFetcherDelegate?
    private let jsonFetcher: JSONFetching
    private let fetchTimer: FetchTiming
    private let scooterParser = ScooterParser()

    init(jsonFetcher: JSONFetching, fetchTimer: FetchTiming) {
        self.jsonFetcher = jsonFetcher
        self.fetchTimer = fetchTimer
    }

    func start() {
        // fetch once immediately
        fetchJSON()
        // fetch subsequently by some interval
        fetchTimer.start { [weak self] in
            self?.fetchJSON()
        }
    }

    private func fetchJSON() {
        jsonFetcher.fetch(url: "awefsdfffeafe") { [weak self] json in
            guard let strongSelf = self else { return }
            let scooters = strongSelf.scooterParser.parse(json: JSON(json))
            strongSelf.delegate?.fetchedScooters(scooters: scooters)
        }
    }
    
}

protocol ScooterFetching {
    
    weak var delegate: ScooterFetcherDelegate? { get set }
    func start()
    
}

protocol ScooterFetcherDelegate: class {

    func fetchedScooters(scooters: [Scooter])

}
