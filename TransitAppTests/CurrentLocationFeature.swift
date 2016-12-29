import Quick
import Nimble
@testable import TransitApp

class CurrentLocationFeature: TransitAppFeature { override func spec() {
    super.spec()

    context("without having given or denied permission before") {

        it("the arrow will not be highlighted") {
            self.expectCurrentLocationButtonState(.nonHighlighted)
        }

        context("tapping on the arrow") {

            beforeEach {
                self.mapView.tapCurrentLocationButton()
            }

            it("will highlight the arrow") {
                self.expectCurrentLocationButtonState(.highlighted)
            }

            it("will present an authorization dialog") {
                // it will not fatalError if there is a dialog to tap
                // TODO add a way to just check for presence of dialog type
                self.locationManager.tapAllowInDialog()
            }

            context("accepting location permission") {

                beforeEach {
                    self.locationManager.tapAllowInDialog()
                }

                it("the arrow will still be highlighted") {
                    self.expectCurrentLocationButtonState(.highlighted)
                }

                context("if/when the location is updated") {

                    beforeEach {
                        expect(self.mapView.mapCenteredOn).to(beNil())
                        self.locationManager.locationRequestSuccess()
                    }

                    it("will center the map on the current location") {
                        expect(self.mapView.mapCenteredOn).toNot(beNil())
                    }

                    it("the arrow will still be highlighted") {
                        self.expectCurrentLocationButtonState(.highlighted)
                    }
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

    context("when permission was already denied") {
        
        beforeEach {
            self.mapView.tapCurrentLocationButton()
            self.locationManager.tapDoNotAllowAccessInDialog()
        }

        context("tapping on the arrow") {

            beforeEach {
                self.mapView.tapCurrentLocationButton()
            }

            it("the arrow will still not be highlighted") {
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
                    let secondAction = alert.actions[1]
                    expect(secondAction.title).to(equal("Cancel"))
                    expect(secondAction.style).to(equal(UIAlertActionStyle.cancel))
                }
            }
        }
    }

    context("when already following current location") {

        beforeEach {
            self.mapView.tapCurrentLocationButton()
            self.locationManager.tapAllowInDialog()
            self.expectCurrentLocationButtonState(.highlighted)
        }

        context("tapping on the arrow") {

            beforeEach {
                self.mapView.tapCurrentLocationButton()
            }

            it("will un-highlight the arrow") {
                self.expectCurrentLocationButtonState(.nonHighlighted)
            }
            
            context("if/when the location is updated") {

                beforeEach {
                    expect(self.mapView.mapCenteredOn).to(beNil())
                    self.locationManager.locationRequestSuccess()
                }

                it("will not center the map on the current location") {
                    expect(self.mapView.mapCenteredOn).to(beNil())
                }
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
