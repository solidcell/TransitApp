import XCTest
import MapKit
import SpecUIKitFringes
@testable import TransitApp

class CurrentLocationFeature: TransitAppFeature {

    func testInitialState() {
        tapAppIcon()
        XCTAssertEqual(mapViewController.currentLocationButtonState, .nonHighlighted)
        XCTAssertFalse(mapViewController.showCurrentLocation)
    }

    func testTappingOnTheArrow() {
        tapAppIcon()
        mapViewController.tapCurrentLocationButton()
        XCTAssertEqual(mapViewController.currentLocationButtonState, .highlighted)
        XCTAssertFalse(mapViewController.showCurrentLocation)
        XCTAssertEqual(dialogManager.visibleDialog, .locationManager(.requestAccessWhileInUse))
    }

    func testAcceptingLocationPermission() {
        tapAppIcon()
        mapViewController.tapCurrentLocationButton()
        XCTAssertEqual(mapViewController.userTrackingMode, MKUserTrackingMode.none)
        dialogManager.tap(.allow)

        XCTAssertEqual(mapViewController.currentLocationButtonState, .highlighted)
        XCTAssertEqual(mapViewController.userTrackingMode, .follow)
        XCTAssertTrue(mapViewController.showCurrentLocation)
    }

    func testDecliningLocationPermission() {
        tapAppIcon()
        mapViewController.tapCurrentLocationButton()
        dialogManager.tap(.dontAllow)

        XCTAssertEqual(mapViewController.currentLocationButtonState, .nonHighlighted)
    }

    func testTappingOnTheArrowWhenPermissionWasAlreadyAuthorized() {
        tapAppIcon()
        mapViewController.tapCurrentLocationButton()
        dialogManager.tap(.allow)
        mapViewController.tapCurrentLocationButton()

        XCTAssertEqual(mapViewController.currentLocationButtonState, .nonHighlighted)
        mapViewController.tapCurrentLocationButton()
        XCTAssertEqual(mapViewController.currentLocationButtonState, .highlighted)
    }

    func testTappingOnTheArrowWhenPermissionWasAlreadyDenied() {
        tapAppIcon()
        mapViewController.tapCurrentLocationButton()
        dialogManager.tap(.dontAllow)
        mapViewController.tapCurrentLocationButton()

        XCTAssertEqual(mapViewController.currentLocationButtonState, .nonHighlighted)

        let alert = mapViewController.shownAlert!
        XCTAssertEqual(alert.title, "Please give permission")
        XCTAssertEqual(alert.message, "You have previously declined permission to use your location.")

        XCTAssertEqual(alert.actions.count, 2)

        let firstAction = alert.actions[0]
        XCTAssertEqual(firstAction.title, "OK")
        XCTAssertEqual(firstAction.style, UIAlertActionStyle.default)
        let settingsURL = URL(string:UIApplicationOpenSettingsURLString)!
        XCTAssertEqual(firstAction.handler, MapPresenter.Alert.Action.Handler.url(settingsURL))

        let secondAction = alert.actions[1]
        XCTAssertEqual(secondAction.title, "Cancel")
        XCTAssertEqual(secondAction.style, UIAlertActionStyle.cancel)
        XCTAssertEqual(secondAction.handler, MapPresenter.Alert.Action.Handler.noop)
    }

    func testTappingOnTheArrowWhenFollowingCurrentLocation() {
        tapAppIcon()
        mapViewController.tapCurrentLocationButton()
        dialogManager.tap(.allow)
        XCTAssertEqual(mapViewController.currentLocationButtonState, .highlighted)
        XCTAssertEqual(mapViewController.userTrackingMode, MKUserTrackingMode.follow)
        mapViewController.tapCurrentLocationButton()

        XCTAssertEqual(mapViewController.currentLocationButtonState, .nonHighlighted)
        XCTAssertEqual(mapViewController.userTrackingMode, MKUserTrackingMode.none)
    }

    func testDraggingTheMapWhenFollowingCurrentLocation() {
        tapAppIcon()
        mapViewController.tapCurrentLocationButton()
        dialogManager.tap(.allow)
        XCTAssertEqual(mapViewController.currentLocationButtonState, .highlighted)
        XCTAssertEqual(mapViewController.userTrackingMode, MKUserTrackingMode.follow)
        mapViewController.drag()

        XCTAssertEqual(mapViewController.currentLocationButtonState, .nonHighlighted)
        XCTAssertEqual(mapViewController.userTrackingMode, MKUserTrackingMode.none)
    }

    func testTappingOnTheArrowWhenLocationServicesAreOff() {
        tapAppIcon()
        settingsApp.set(locationServicesEnabled: false)
        mapViewController.tapCurrentLocationButton()

        XCTAssertEqual(dialogManager.visibleDialog, .locationManager(.requestJumpToLocationServicesSettings))
    }
}
