import Quick
import Nimble
import MapKit
import SpecUIKitFringes
@testable import TransitApp

class CurrentLocationFeature: TransitAppFeature {

    func testInitialState() {
        XCTAssertEqual(self.mapView.currentLocationButtonState, .nonHighlighted)
        XCTAssertNil(self.mapView.showCurrentLocation)
    }

    func testTappingOnTheArrow() {
        self.mapView.tapCurrentLocationButton()
        XCTAssertEqual(self.mapView.currentLocationButtonState, .highlighted)
        XCTAssertNil(self.mapView.showCurrentLocation)
        XCTAssertEqual(self.dialogManager.visibleDialog, SpecDialogManager.DialogIdentifier.locationManager(.requestAccessWhileInUse))
    }

    func testAcceptingLocationPermission() {
        self.mapView.tapCurrentLocationButton()
        XCTAssertEqual(self.mapView.userTrackingMode, MKUserTrackingMode.none)
        self.dialogManager.tap(.allow)

        XCTAssertEqual(self.mapView.currentLocationButtonState, .highlighted)
        XCTAssertEqual(self.mapView.userTrackingMode, MKUserTrackingMode.follow)
        XCTAssertTrue(self.mapView.showCurrentLocation!)
    }

    func testDecliningLocationPermission() {
        self.mapView.tapCurrentLocationButton()
        self.dialogManager.tap(.dontAllow)

        XCTAssertEqual(self.mapView.currentLocationButtonState, .nonHighlighted)
    }

    func testTappingOnTheArrowWhenPermissionWasAlreadyAuthorized() {
        self.mapView.tapCurrentLocationButton()
        self.dialogManager.tap(.allow)
        self.mapView.tapCurrentLocationButton()

        XCTAssertEqual(self.mapView.currentLocationButtonState, .nonHighlighted)
        self.mapView.tapCurrentLocationButton()
        XCTAssertEqual(self.mapView.currentLocationButtonState, .highlighted)
    }

    func testTappingOnTheArrowWhenPermissionWasAlreadyDenied() {

        self.mapView.tapCurrentLocationButton()
        self.dialogManager.tap(.dontAllow)
        self.mapView.tapCurrentLocationButton()

        XCTAssertEqual(self.mapView.currentLocationButtonState, .nonHighlighted)

        let alert = self.mapView.shownAlert
        XCTAssertNotNil(alert)
        if let alert = alert {
            XCTAssertEqual(alert.title, "Please give permission")
            XCTAssertEqual(alert.message, "You have previously declined permission to use your location.")

            XCTAssertEqual(alert.actions.count, 2)

            let firstAction = alert.actions[0]
            XCTAssertEqual(firstAction.title, "OK")
            XCTAssertEqual(firstAction.style, UIAlertActionStyle.default)
            let settingsURL = URL(string:UIApplicationOpenSettingsURLString)!
            XCTAssertEqual(firstAction.handler, MapViewModel.Alert.Action.Handler.url(settingsURL))

            let secondAction = alert.actions[1]
            XCTAssertEqual(secondAction.title, "Cancel")
            XCTAssertEqual(secondAction.style, UIAlertActionStyle.cancel)
            XCTAssertEqual(secondAction.handler, MapViewModel.Alert.Action.Handler.noop)
        }
    }

    func testTappingOnTheArrowWhenFollowingCurrentLocation() {

        self.mapView.tapCurrentLocationButton()
        self.dialogManager.tap(.allow)
        XCTAssertEqual(self.mapView.currentLocationButtonState, .highlighted)
        XCTAssertEqual(self.mapView.userTrackingMode, MKUserTrackingMode.follow)
        self.mapView.tapCurrentLocationButton()

        XCTAssertEqual(self.mapView.currentLocationButtonState, .nonHighlighted)
        XCTAssertEqual(self.mapView.userTrackingMode, MKUserTrackingMode.none)
    }

    func testDraggingTheMapWhenFollowingCurrentLocation() {

        self.mapView.tapCurrentLocationButton()
        self.dialogManager.tap(.allow)
        XCTAssertEqual(self.mapView.currentLocationButtonState, .highlighted)
        XCTAssertEqual(self.mapView.userTrackingMode, MKUserTrackingMode.follow)
        self.mapView.drag()

        XCTAssertEqual(self.mapView.currentLocationButtonState, .nonHighlighted)
        XCTAssertEqual(self.mapView.userTrackingMode, MKUserTrackingMode.none)
    }

    func testTappingOnTheArrowWhenLocationServicesAreOff() {
        self.settingsApp.set(locationServicesEnabled: false)
        self.mapView.tapCurrentLocationButton()

        XCTAssertEqual(self.dialogManager.visibleDialog, SpecDialogManager.DialogIdentifier.locationManager(.requestJumpToLocationServicesSettings))

    }
}
