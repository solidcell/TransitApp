import Quick
import Nimble
import CoreLocation
@testable import TransitApp

class CurrentLocationProviderSpec: TransitAppSpec {
    override func spec() {
        super.spec()

        var subject: CurrentLocationProvider!
        var locationManager: SpecLocationManager!
        var delegate: SpecDelegate!

        beforeEach {
            locationManager = SpecLocationManager()
            subject = CurrentLocationProvider(locationManager: locationManager)
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

private class SpecLocationManager {
    
    weak var delegate: CLLocationManagerDelegate?
    fileprivate let bsFirstArg = CLLocationManager()
    
}

extension SpecLocationManager: LocationManaging {

    func requestLocation() {
        let fakeCurrentLocation = CLLocation(latitude: 1.0, longitude: 2.0)
        delegate!.locationManager?(bsFirstArg, didUpdateLocations: [fakeCurrentLocation])
    }

}
