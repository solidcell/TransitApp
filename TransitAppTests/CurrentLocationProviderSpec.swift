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

        context("when user has never been asked for location authorization before") {

            beforeEach {
                expect(locationManager.authorizationStatus()).to(equal(CLAuthorizationStatus.notDetermined))
            }

            describe("getCurrentLocation") {

                beforeEach {
                    subject.getCurrentLocation()
                }

                it("will prompt the user for access") {
                    expect(locationManager.dialog).to(equal(SpecLocationManager.Dialog.requestAccessWhileInUse))
                }

                context("when the user allows access") {
                    beforeEach {
                        locationManager.allowAccess()
                    }

                    it("will update the delegate with the current location") {
                        expect(delegate.receivedCurrentLocation).to(beAnInstanceOf(CLLocation.self))
                    }

                    it("will set the authorization status to authorizedWhenInUse") {
                        expect(locationManager.authorizationStatus()).to(equal(CLAuthorizationStatus.authorizedWhenInUse))
                    }
                }
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
