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

                    it("will dismiss the dialog") {
                        expect(locationManager.dialog).to(beNil())
                    }

                    it("will update the delegate with the current location") {
                        expect(delegate.receivedCurrentLocation).to(beAnInstanceOf(CLLocation.self))
                    }

                    it("will set the authorization status to authorizedWhenInUse") {
                        expect(locationManager.authorizationStatus()).to(equal(CLAuthorizationStatus.authorizedWhenInUse))
                    }
                }

                context("when the user does not allow access") {
                    
                    beforeEach {
                        locationManager.doNotAllowAccess()
                    }

                    it("will dismiss the dialog") {
                        expect(locationManager.dialog).to(beNil())
                    }

                    it("will not update the delegate with the current location") {
                        expect(delegate.receivedCurrentLocation).to(beNil())
                    }

                    it("will set the authorization status to authorizedWhenInUse") {
                        expect(locationManager.authorizationStatus()).to(equal(CLAuthorizationStatus.denied))
                    }
                }
            }
        }

        context("when the user has already denied access") {

            beforeEach {
                locationManager.setAuthorizationStatus(.denied)
            }

            describe("getCurrentLocation") {

                beforeEach {
                    subject.getCurrentLocation()
                }

                it("will not prompt the user for access") {
                    expect(locationManager.dialog).to(beNil())
                }

                it("will not update the delegate with the current location") {
                    expect(delegate.receivedCurrentLocation).to(beNil())
                }
            }
        }

        context("when the user has already permitted access") {

            beforeEach {
                locationManager.setAuthorizationStatus(.authorizedWhenInUse)
            }

            describe("getCurrentLocation") {

                beforeEach {
                    subject.getCurrentLocation()
                }

                it("will not prompt the user for access") {
                    expect(locationManager.dialog).to(beNil())
                }

                it("will update the delegate with the current location") {
                    expect(delegate.receivedCurrentLocation).to(beAnInstanceOf(CLLocation.self))
                }
            }
        }

        context("when Location Services is disabled") {

            beforeEach {
                locationManager.setLocationServicesEnabled(false)
            }

            describe("getCurrentLocation") {

                beforeEach {
                    subject.getCurrentLocation()
                }

                it("will prompt the user to turn on Location Services") {
                    expect(locationManager.dialog).to(equal(SpecLocationManager.Dialog.requestJumpToLocationServicesSettings))
                }

                context("when the user taps any response") {
                    
                    beforeEach {
                        locationManager.tapAnyLocationServicesResponse()
                    }

                    it("will dismiss the dialog") {
                        expect(locationManager.dialog).to(beNil())
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
