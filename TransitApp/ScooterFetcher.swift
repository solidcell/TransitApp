import SwiftyJSON
import UIKitFringes

class ScooterFetcher {

    static let scooterURL = "https://app.joincoup.com/api/v1/scooters.json"
    
    weak var delegate: ScooterFetcherDelegate?
    private let jsonFetcher: JSONFetcher
    private let timer: Timing
    private let scooterParser = ScooterParser()

    init(jsonFetcher: JSONFetcher, timer: Timing) {
        self.jsonFetcher = jsonFetcher
        self.timer = timer
    }

    func start() {
        // fetch once immediately
        fetchJSON()
        // fetch subsequently by some interval
        timer.start(interval: 15.0, repeats: true) { [weak self] in
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
