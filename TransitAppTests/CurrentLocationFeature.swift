import Quick
import Nimble

class CurrentLocationFeature: TransitAppFeature { override func spec() {
    super.spec()

    describe("tapping on the Current Location Arrow") {

        beforeEach {
            self.mapView.tapCurrentLocationButton()
        }

        it("will present an authorization dialog") {
            // it will not fatalError if there is a dialog to tap
            // TODO add a way to just check for presence of dialog type
            self.locationManager.tapAllowInDialog()
        }

        describe("accepting location permission") {

            beforeEach {
                self.locationManager.tapAllowInDialog()
            }

            it("will center the map on the current location") {
                expect(self.mapView.mapCenteredOn).to(beNil())
                self.locationManager.locationRequestSuccess()
                expect(self.mapView.mapCenteredOn).toNot(beNil())
            }
        }
    }
    }
}
