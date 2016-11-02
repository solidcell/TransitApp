import SwiftyJSON

// When iOS backgrounds the app, it will not fire the timer.
// When the app foregrounds, the timer will continue to fire
// (immediately if it "should have" while backgrounded).
// Consider stopping and restarting the timer instead of relying
// on this iOS behavior.

class ScooterFetcher: ScooterFetching {

    static let scooterURL = "https://app.joincoup.com/api/v1/scooters.json"
    
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
        jsonFetcher.fetch(url: ScooterFetcher.scooterURL) { [weak self] json in
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
