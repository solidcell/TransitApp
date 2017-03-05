import XCTest
import MapKit
import SpecUIKitFringes
@testable import TransitApp

class CurrentLocationFeature: TransitAppFeature {

    func testInitialState() {
        XCTAssertEqual(mapView.currentLocationButtonState, .nonHighlighted)
        XCTAssertNil(mapView.showCurrentLocation)
    }

    func testTappingOnTheArrow() {
        mapView.tapCurrentLocationButton()
        XCTAssertEqual(mapView.currentLocationButtonState, .highlighted)
        XCTAssertNil(mapView.showCurrentLocation)
        XCTAssertEqual(dialogManager.visibleDialog, SpecDialogManager.DialogIdentifier.locationManager(.requestAccessWhileInUse))
    }

    func testAcceptingLocationPermission() {
        mapView.tapCurrentLocationButton()
        XCTAssertEqual(mapView.userTrackingMode, MKUserTrackingMode.none)
        dialogManager.tap(.allow)

        XCTAssertEqual(mapView.currentLocationButtonState, .highlighted)
        XCTAssertEqual(mapView.userTrackingMode, MKUserTrackingMode.follow)
        XCTAssertTrue(mapView.showCurrentLocation!)
    }

    func testDecliningLocationPermission() {
        mapView.tapCurrentLocationButton()
        dialogManager.tap(.dontAllow)

        XCTAssertEqual(mapView.currentLocationButtonState, .nonHighlighted)
    }

    func testTappingOnTheArrowWhenPermissionWasAlreadyAuthorized() {
        mapView.tapCurrentLocationButton()
        dialogManager.tap(.allow)
        mapView.tapCurrentLocationButton()

        XCTAssertEqual(mapView.currentLocationButtonState, .nonHighlighted)
        mapView.tapCurrentLocationButton()
        XCTAssertEqual(mapView.currentLocationButtonState, .highlighted)
    }

    func testTappingOnTheArrowWhenPermissionWasAlreadyDenied() {

        mapView.tapCurrentLocationButton()
        dialogManager.tap(.dontAllow)
        mapView.tapCurrentLocationButton()

        XCTAssertEqual(mapView.currentLocationButtonState, .nonHighlighted)

        let alert = mapView.shownAlert
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

        mapView.tapCurrentLocationButton()
        dialogManager.tap(.allow)
        XCTAssertEqual(mapView.currentLocationButtonState, .highlighted)
        XCTAssertEqual(mapView.userTrackingMode, MKUserTrackingMode.follow)
        mapView.tapCurrentLocationButton()

        XCTAssertEqual(mapView.currentLocationButtonState, .nonHighlighted)
        XCTAssertEqual(mapView.userTrackingMode, MKUserTrackingMode.none)
    }

    func testDraggingTheMapWhenFollowingCurrentLocation() {

        mapView.tapCurrentLocationButton()
        dialogManager.tap(.allow)
        XCTAssertEqual(mapView.currentLocationButtonState, .highlighted)
        XCTAssertEqual(mapView.userTrackingMode, MKUserTrackingMode.follow)
        mapView.drag()

        XCTAssertEqual(mapView.currentLocationButtonState, .nonHighlighted)
        XCTAssertEqual(mapView.userTrackingMode, MKUserTrackingMode.none)
    }

    func testTappingOnTheArrowWhenLocationServicesAreOff() {
        settingsApp.set(locationServicesEnabled: false)
        mapView.tapCurrentLocationButton()

        XCTAssertEqual(dialogManager.visibleDialog, SpecDialogManager.DialogIdentifier.locationManager(.requestJumpToLocationServicesSettings))

    }
}
