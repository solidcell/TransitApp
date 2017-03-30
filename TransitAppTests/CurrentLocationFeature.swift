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
        let mapVC = mapViewController!
        mapViewController.tapCurrentLocationButton()

        XCTAssertEqual(mapVC.currentLocationButtonState, .nonHighlighted)

        XCTAssertEqual(alertController.title, "Please give permission")
        XCTAssertEqual(alertController.message, "You have previously declined permission to use your location.")

        XCTAssertEqual(alertController.actions.count, 2)
    }

    func testTappingOnTheArrowWhenPermissionWasAlreadyDeniedAndTappingOK() {
        testTappingOnTheArrowWhenPermissionWasAlreadyDenied()

        let firstAction = alertController.actions[0]
        XCTAssertEqual(firstAction.title, "OK")
        XCTAssertEqual(firstAction.style, .default)
        alertController.tapAction(at: 0)
        XCTAssertEqual(location, .settings)
        XCTAssertNotNil(mapViewController)
    }
    
    func testTappingOnTheArrowWhenPermissionWasAlreadyDeniedAndTappingCancel() {
        testTappingOnTheArrowWhenPermissionWasAlreadyDenied()

        let secondAction = alertController.actions[1]
        XCTAssertEqual(secondAction.title, "Cancel")
        XCTAssertEqual(secondAction.style, .cancel)
        alertController.tapAction(at: 1)
        XCTAssertNotNil(mapViewController)
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
