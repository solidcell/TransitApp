import XCTest
import RealmSwift
@testable import TransitApp

class ScooterUpdaterSpec: TransitAppSpec {

    var subject: ScooterUpdater!
    private var scooterFetcher: SpecScooterFetcher!

    override func setUp() {
        super.setUp()
        scooterFetcher = SpecScooterFetcher()
        subject = ScooterUpdater(realm: self.realm,
                                 scooterFetcher: scooterFetcher)
    }

    func testStartWhenThereAreNoScootersWhenTheFetcherReturnsScooters() {
        subject.start()
        XCTAssertEqual(self.realm.scooters.count, 0)

        let scooter = Scooter(latitude: 50.0, longitude: 60.0,
                              energyLevel: 70, licensePlate: "123abc")
        scooterFetcher.simulateFetchedScooters([scooter])
        XCTAssertEqual(self.realm.scooters.count, 1)
    }


    func testWhenThereAreScootersAlreadyWhenTheFetcherReturnsScooters() {
        subject.start()
        try! self.realm.write {
            let scooter = Scooter(latitude: 50.0, longitude: 60.0,
                                  energyLevel: 70, licensePlate: "123abc")
            self.realm.add(scooter)
        }
        XCTAssertEqual(self.realm.scooters.count, 1)

        let scooter = Scooter(latitude: 50.1, longitude: 60.5,
                              energyLevel: 59, licensePlate: "123abc")
        scooterFetcher.simulateFetchedScooters([scooter])

        XCTAssertEqual(self.realm.scooters.count, 1)
        XCTAssertEqual(self.realm.scooters.first!.energyLevel, 59)
    }
}

private class SpecScooterFetcher: ScooterFetching {

    weak var delegate: ScooterFetcherDelegate?

    func start() { }

    func simulateFetchedScooters(_ scooters: [Scooter]) {
        delegate?.fetchedScooters(scooters: scooters)
    }
    
}
