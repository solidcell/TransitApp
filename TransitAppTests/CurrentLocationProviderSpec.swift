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

        context("when Location Services are disabled") {

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

        context("when the user was prompted to enable Location Services and obliged") {
            
            beforeEach {
                locationManager.setLocationServicesEnabled(false)
                subject.getCurrentLocation()
                locationManager.tapAnyLocationServicesResponse()
                locationManager.setLocationServicesEnabled(true)
            }

            describe("getCurrentLocation") {

                beforeEach {
                    subject.getCurrentLocation()
                }

                it("will prompt the user for access") {
                    expect(locationManager.dialog).to(equal(SpecLocationManager.Dialog.requestAccessWhileInUse))
                }
            }
        }
        
        context("when already authorized, but Location Services are now disabled") {

            beforeEach {
                locationManager.setAuthorizationStatus(.authorizedWhenInUse)
                locationManager.setLocationServicesEnabled(false)
            }

            describe("getCurrentLocation") {

                beforeEach {
                    subject.getCurrentLocation()
                }

                context("when the user dismisses the dialog and thurns it on") {
                    
                    beforeEach {
                        locationManager.tapAnyLocationServicesResponse()
                        locationManager.setLocationServicesEnabled(true)
                    }

                    it("will update the delegate with the current location") {
                        expect(delegate.receivedCurrentLocation).to(beAnInstanceOf(CLLocation.self))
                    }
                }
            }
        }

        context("when the user has already responded to the Location Services dialog twice") {

            beforeEach {
                locationManager.setLocationServicesEnabled(false)
                // first time
                subject.getCurrentLocation()
                expect(locationManager.dialog).to(equal(SpecLocationManager.Dialog.requestJumpToLocationServicesSettings))
                locationManager.tapAnyLocationServicesResponse()
                // second time
                subject.getCurrentLocation()
                expect(locationManager.dialog).to(equal(SpecLocationManager.Dialog.requestJumpToLocationServicesSettings))
                locationManager.tapAnyLocationServicesResponse()
            }

            describe("getCurrentLocation") {

                beforeEach {
                    subject.getCurrentLocation()
                }
                
                it("will not prompt the user anymore to turn on Location Services") {
                    expect(locationManager.dialog).to(beNil())
                }

                // If all attempts have been exhausted, it's still possible to ask the user with a
                // manual dialog and to direct them to the "Settings" page, but not specifically
                // The "Location Services" page, which is of course not great.
                // UIApplication.shared.openURL(URL(string: UIApplicationOpenSettingsURLString)!)
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
