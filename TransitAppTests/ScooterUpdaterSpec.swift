import Quick
import Nimble
import RealmSwift
@testable import TransitApp

class ScooterUpdaterSpec: TransitAppSpec {
    override func spec() {
        super.spec()

        var subject: ScooterUpdater!
        var scooterFetcher: SpecScooterFetcher!
        var scooterWriter: ScooterWriter!

        beforeEach {
            scooterFetcher = SpecScooterFetcher()
            scooterWriter = ScooterWriter(realm: self.realm)
            subject = ScooterUpdater(scooterWriter: scooterWriter,
                                     scooterFetcher: scooterFetcher)
        }

        describe("start") {

            beforeEach {
                subject.start()
            }

            context("when there are no Scooters") {
                beforeEach {
                    expect(self.realm.scooters).to(beEmpty())
                }

                context("when the fetcher returns Scooters") {
                    beforeEach {
                        let scooter = Scooter(latitude: 50.0, longitude: 60.0,
                                              energyLevel: 70, licensePlate: "123abc")
                        scooterFetcher.simulateFetchedScooters([scooter])
                    }

                    it("adds Scooters and notifies the delegate") {
                        expect(self.realm.scooters).to(haveCount(1))
                    }
                }
            }


            context("when there are Scooters already") {
                beforeEach {
                    let scooter = Scooter(latitude: 50.0, longitude: 60.0,
                                          energyLevel: 70, licensePlate: "123abc")
                    try! self.realm.write {
                        self.realm.add(scooter)
                    }
                    expect(self.realm.scooters).to(haveCount(1))
                }

                context("when the fetcher returns Scooters") {
                    beforeEach {
                        let scooter = Scooter(latitude: 50.1, longitude: 60.5,
                                              energyLevel: 59, licensePlate: "123abc")
                        scooterFetcher.simulateFetchedScooters([scooter])
                    }

                    it("updates Scooters") {
                        expect(self.realm.scooters).to(haveCount(1))
                        expect(self.realm.scooters.first!.energyLevel).to(equal(59))
                    }
                }
            }
        }
    }
}

private class SpecScooterFetcher: ScooterFetching {

    weak var delegate: ScooterFetcherDelegate?
    
    func start() { }

    func simulateFetchedScooters(_ scooters: [Scooter]) {
        delegate?.fetchedScooters(scooters: scooters)
    }
    
}
