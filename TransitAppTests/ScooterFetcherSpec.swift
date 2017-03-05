import XCTest
@testable import TransitApp
/*
class ScooterFetcherSpec: TransitAppSpec {

    var subject: ScooterFetcher!
    var jsonFetcher: SpecJSONFetcher!
    var fetchTimer: SpecFetchTimer!
    private var delegate: SpecDelegate!

    override func setUp() {
        super.setUp()
        jsonFetcher = SpecJSONFetcher()
        fetchTimer = SpecFetchTimer()
        subject = ScooterFetcher(jsonFetcher: jsonFetcher, fetchTimer: fetchTimer)
        delegate = SpecDelegate()
        subject.delegate = delegate
    }

    func testStartUpdatesTheDelegateWithScootersFetchedFromTheNetworkAtSomeInterval() {
        let response1 = ["data": ["scooters": [
            ["id":"05ba8757-c7d3-42ad-b225-242d85c63aa2","vin":"RHMGRSAN0GT1R0112","model":"Gogoro 1st edition","license_plate":"198FCE","energy_level":70,"location":["lng":13.415355,"lat":52.517223]],
            ["id":"05bdd9ae-af0c-49af-9ee5-815614f3fcdd","vin":"RHMGRSAN0GT1R0115","model":"Gogoro 1st edition","license_plate":"201FCE","energy_level":53,"location":["lng":13.360313,"lat":52.494534]]
            ]]]
        let response2 = ["data": ["scooters": [
            // this one changed
            ["id":"05ba8757-c7d3-42ad-b225-242d85c63aa2","vin":"RHMGRSAN0GT1R0112","model":"Gogoro 1st edition","license_plate":"198FCE","energy_level":68,"location":["lng":13.41667,"lat":52.518101]],
            // this one did not
            ["id":"05bdd9ae-af0c-49af-9ee5-815614f3fcdd","vin":"RHMGRSAN0GT1R0115","model":"Gogoro 1st edition","license_plate":"201FCE","energy_level":53,"location":["lng":13.360313,"lat":52.494534]]
            ]]]

        subject.start()
        XCTAssertNil(delegate.fetchedScootersCalledWith)
        // fetches Scooters immediately
        jsonFetcher.fetchSuccess(response1)
        XCTAssertEqual(delegate.fetchedScootersCalledWith?.count, 2)
        let firstResponseFirstScooter = delegate.fetchedScootersCalledWith!.first!
        XCTAssertEqual(firstResponseFirstScooter.energyLevel, 70)
        // when the timer fires, it fetches again
        fetchTimer.fire()
        jsonFetcher.fetchSuccess(response2)
        XCTAssertEqual(delegate.fetchedScootersCalledWith?.count, 2)
        let secondResponseFirstScooter = delegate.fetchedScootersCalledWith!.first!
        XCTAssertEqual(secondResponseFirstScooter.energyLevel, 68)
    }
}

private class SpecDelegate: ScooterFetcherDelegate {

    var fetchedScootersCalledWith: [Scooter]?

    func fetchedScooters(scooters: [Scooter]) {
        fetchedScootersCalledWith = scooters
    }

}
*/
