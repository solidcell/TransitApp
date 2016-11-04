import Quick
import Nimble
import CoreLocation
@testable import TransitApp

class CurrentLocationProviderSpec: TransitAppSpec {
    override func spec() {
        super.spec()

        var subject: CurrentLocationProvider!
        var delegate: SpecDelegate!

        beforeEach {
            subject = CurrentLocationProvider()
            delegate = SpecDelegate()
            subject.delegate = delegate
        }

        describe("getCurrentLocation") {

            beforeEach {
                subject.getCurrentLocation()
            }

            it("receives the current location") {
                expect(delegate.receivedCurrentLocation).to(beAnInstanceOf(CLLocation.self))
            }

        }
    }
}

private class SpecDelegate {

    var receivedCurrentLocation: CLLocation?

}

extension SpecDelegate: CurrentLocationProviderDelegate {

    func currentLocation(_ location: CLLocation) {
        receivedCurrentLocation = location
    }
    
}
