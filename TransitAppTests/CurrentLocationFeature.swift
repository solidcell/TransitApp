import Quick
import Nimble
import MapKit
import FakeLocationManager
@testable import TransitApp

class CurrentLocationFeature: TransitAppFeature { override func spec() {
    super.spec()

    context("without having given or denied permission before") {

        it("the arrow will not be highlighted") {
            self.expectCurrentLocationButtonState(.nonHighlighted)
        }

        it("will not be trying to show the current location") {
            expect(self.mapView.showCurrentLocation).to(beNil())
        }

        context("tapping on the arrow") {

            beforeEach {
                self.mapView.tapCurrentLocationButton()
            }

            it("will highlight the arrow") {
                self.expectCurrentLocationButtonState(.highlighted)
            }

            it("will still not be trying to show the current location") {
                expect(self.mapView.showCurrentLocation).to(beNil())
            }

            it("will present an authorization dialog") {
                expect(self.locationManager.dialog).to(equal(FakeLocationManager.Dialog.requestAccessWhileInUse))
            }

            context("accepting location permission") {

                beforeEach {
                    expect(self.mapView.userTrackingMode).to(equal(MKUserTrackingMode.none))
                    self.locationManager.tapAllowInDialog()
                }

                it("the arrow will still be highlighted") {
                    self.expectCurrentLocationButtonState(.highlighted)
                }

                it("will turn on user tracking") {
                    expect(self.mapView.userTrackingMode).to(equal(MKUserTrackingMode.follow))
                }

                it("will show the current location") {
                    expect(self.mapView.showCurrentLocation).to(beTrue())
                }
            }

            context("declining location permission") {

                beforeEach {
                    self.locationManager.tapDoNotAllowAccessInDialog()
                }

                it("the arrow will no longer be highlighted") {
                    self.expectCurrentLocationButtonState(.nonHighlighted)
                }
            }
        }
    }

    context("when permission was already authorized") {
        
        beforeEach {
            self.mapView.tapCurrentLocationButton()
            self.locationManager.tapAllowInDialog()
            self.mapView.tapCurrentLocationButton()
        }

        context("tapping on the arrow") {

            beforeEach {
                self.expectCurrentLocationButtonState(.nonHighlighted)
                self.mapView.tapCurrentLocationButton()
            }

            it("the arrow will be highlighted") {
                self.expectCurrentLocationButtonState(.highlighted)
            }

        }
        
    }

    context("when permission was already denied") {

        beforeEach {
            self.mapView.tapCurrentLocationButton()
            self.locationManager.tapDoNotAllowAccessInDialog()
        }

        context("tapping on the arrow") {

            beforeEach {
                self.mapView.tapCurrentLocationButton()
            }

            it("the arrow will not be highlighted") {
                self.expectCurrentLocationButtonState(.nonHighlighted)
            }

            it("will display an alert explaining the issue") {
                let alert = self.mapView.shownAlert
                expect(alert).toNot(beNil())
                if let alert = alert {
                    expect(alert.title).to(equal("Please give permission"))
                    expect(alert.message).to(equal("You have previously declined permission to use your location."))

                    expect(alert.actions).to(haveCount(2))

                    let firstAction = alert.actions[0]
                    expect(firstAction.title).to(equal("OK"))
                    expect(firstAction.style).to(equal(UIAlertActionStyle.default))
                    let settingsURL = URL(string:UIApplicationOpenSettingsURLString)!
                    expect(firstAction.handler).to(equal(MapViewModel.Alert.Action.Handler.url(settingsURL)))

                    let secondAction = alert.actions[1]
                    expect(secondAction.title).to(equal("Cancel"))
                    expect(secondAction.style).to(equal(UIAlertActionStyle.cancel))
                    expect(secondAction.handler).to(equal(MapViewModel.Alert.Action.Handler.noop))
                }
            }
        }
    }

    context("when following current location") {

        beforeEach {
            self.mapView.tapCurrentLocationButton()
            self.locationManager.tapAllowInDialog()
            self.expectCurrentLocationButtonState(.highlighted)
            expect(self.mapView.userTrackingMode).to(equal(MKUserTrackingMode.follow))
        }

        context("tapping on the arrow") {

            beforeEach {
                self.mapView.tapCurrentLocationButton()
            }

            it("will un-highlight the arrow") {
                self.expectCurrentLocationButtonState(.nonHighlighted)
            }

            it("will turn off user tracking") {
                expect(self.mapView.userTrackingMode).to(equal(MKUserTrackingMode.none))
            }
        }

        context("dragging the map") {

            beforeEach {
                self.mapView.drag()
            }

            it("will un-highlight the arrow") {
                self.expectCurrentLocationButtonState(.nonHighlighted)
            }

            it("will turn off user tracking") {
                expect(self.mapView.userTrackingMode).to(equal(MKUserTrackingMode.none))
            }
        }
    }

    context("when location services are off") {

        beforeEach {
            self.locationManager.setLocationServicesEnabledInSettingsApp(false)
        }

        context("tapping on the arrow") {

            beforeEach {
                self.mapView.tapCurrentLocationButton()
            }

            it("will show a prompt to turn on location services") {
                expect(self.locationManager.dialog).to(equal(FakeLocationManager.Dialog.requestJumpToLocationServicesSettings))
            }
        }
    }
    
    }
}

extension CurrentLocationFeature {

    func expectCurrentLocationButtonState(_ state: CurrentLocationViewModel.ButtonState,
                                          f: String = #file, _ l: UInt = #line) {
        NMB_expect({self.mapView.currentLocationButtonState}, f, l).to(equal(state))
    }
}
