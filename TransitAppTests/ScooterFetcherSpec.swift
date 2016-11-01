import Quick
import Nimble
@testable import TransitApp

class ScooterFetcherSpec: TransitAppSpec {
    override func spec() {
        super.spec()

        var subject: ScooterFetcher!
        var jsonFetcher: SpecJSONFetcher!
        var fetchTimer: SpecFetchTimer!
        var delegate: SpecDelegate!

        beforeEach {
            jsonFetcher = SpecJSONFetcher()
            fetchTimer = SpecFetchTimer()
            subject = ScooterFetcher(jsonFetcher: jsonFetcher, fetchTimer: fetchTimer)
            delegate = SpecDelegate()
            subject.delegate = delegate
        }

        describe("start") {
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

            it("updates the delegate with Scooters fetched from the network at some interval") {
                subject.start()
                expect(delegate.fetchedScootersCalledWith).to(beNil())
                // fetches Scooters immediately
                jsonFetcher.fetchSuccess(response1)
                expect(delegate.fetchedScootersCalledWith).to(haveCount(2))
                let firstResponseFirstScooter = delegate.fetchedScootersCalledWith!.first!
                expect(firstResponseFirstScooter.energyLevel).to(equal(70))
                // when the timer fires, it fetches again
                fetchTimer.fire()
                jsonFetcher.fetchSuccess(response2)
                expect(delegate.fetchedScootersCalledWith).to(haveCount(2))
                let secondResponseFirstScooter = delegate.fetchedScootersCalledWith!.first!
                expect(secondResponseFirstScooter.energyLevel).to(equal(68))
            }
        }
    }
}

private class SpecJSONFetcher: JSONFetching {

    var completion: ((Any) -> Void)?

    func fetch(url: String, completion: @escaping (Any) -> Void) {
        self.completion = completion
    }

    func fetchSuccess(_ responseValue: Any) {
        self.completion?(responseValue)
        self.completion = nil
    }

}

private class SpecFetchTimer: FetchTiming {

    var block: (() -> Void)?

    func start(block: @escaping () -> Void) {
        self.block = block
    }

    func fire() {
        self.block?()
    }

}

private class SpecDelegate: ScooterFetcherDelegate {

    var fetchedScootersCalledWith: [Scooter]?

    func fetchedScooters(scooters: [Scooter]) {
        self.fetchedScootersCalledWith = scooters
    }

}
