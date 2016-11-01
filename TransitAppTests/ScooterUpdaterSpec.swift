import Quick
import Nimble
import RealmSwift
@testable import TransitApp

class ScooterUpdaterSpec: TransitAppSpec {
    override func spec() {
        super.spec()

        var subject: ScooterUpdater!
        var scooterFetcher: SpecScooterFetcher!
        var delegate: SpecDelegate!

        beforeEach {
            scooterFetcher = SpecScooterFetcher()
            subject = ScooterUpdater(realm: self.realm,
                                     scooterFetcher: scooterFetcher)
            delegate = SpecDelegate()
            subject.delegate = delegate
        }

        describe("start") {

            beforeEach {
                subject.start()
                expect(delegate.updatedScootersCalledSinceLastCheck).to(beFalse())
            }

            context("when there are no Scooters") {
                beforeEach {
                    expect(self.realm.scooters).to(beEmpty())
                }

                context("when the fetcher returns Scooters") {
                    beforeEach {
                        let scooter = Scooter(latitude: 50.0, longitude: 60.0,
                                              energyLevel: 70, licensePlate: "123abc")
                        scooterFetcher.delegate!.fetchedScooters(scooters: [scooter])
                    }

                    it("adds Scooters and notifies the delegate") {
                        expect(self.realm.scooters).to(haveCount(1))
                        expect(delegate.updatedScootersCalledSinceLastCheck).to(beTrue())
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
                        scooterFetcher.delegate!.fetchedScooters(scooters: [scooter])
                    }

                    it("updates Scooters and notifies the delegate") {
                        expect(self.realm.scooters).to(haveCount(1))
                        expect(self.realm.scooters.first!.energyLevel).to(equal(59))
                        expect(delegate.updatedScootersCalledSinceLastCheck).to(beTrue())
                    }
                }
            }
        }
    }
}

private class SpecDelegate: ScooterUpdaterDelegate {

    var updatedScootersCalledSinceLastCheck: Bool {
        defer { updatedScootersCalled = false }
        return updatedScootersCalled
    }

    private var updatedScootersCalled = false

    func updatedScooters() {
        updatedScootersCalled = true
    }
    
}

private class SpecScooterFetcher: ScooterFetching {

    weak var delegate: ScooterFetcherDelegate?
    func start() { }
    
}
