import XCTest

/*
 This is a utility to help encapsulate the behavior of
 updating scooters via the network while in specs.
 */

class SpecScooterUpdater {

    // Don't hold onto these objects. The app's object graph
    // should be holding onto these. If it doesn't, we want it
    // to crash so we know ASAP that there's a retain issue.
    weak var jsonFetcher: SpecJSONFetcher!
    weak var fetchTimer: SpecFetchTimer!

    init(jsonFetcher: SpecJSONFetcher,
         fetchTimer: SpecFetchTimer) {
        self.jsonFetcher = jsonFetcher
        self.fetchTimer = fetchTimer
    }

    func updatesWith(_ response: Any) {
        // The app fires a timer which will lead to a network request
        fetchTimer.fire()
        // The request is a success
        jsonFetcher.fetchSuccess(response)
    }

}
