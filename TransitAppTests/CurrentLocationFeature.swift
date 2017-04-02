import XCTest
import MapKit
import SpecUIKitFringes
@testable import TransitApp

class CurrentLocationFeature: TransitAppFeature {

    func testInitialState() {
        tapAppIconAndSkipToMap()
        XCTAssertEqual(mapUI.currentLocationButtonState, .nonHighlighted)
        XCTAssertFalse(mapUI.showCurrentLocation)
    }

    func testTappingOnTheArrow() {
        tapAppIconAndSkipToMap()
        mapUI.tapCurrentLocationButton()
        XCTAssertEqual(mapUI.currentLocationButtonState, .highlighted)
        XCTAssertFalse(mapUI.showCurrentLocation)
        XCTAssertEqual(dialogManager.visibleDialog, .locationManager(.requestAccessWhileInUse))
    }

    func testAcceptingLocationPermission() {
        tapAppIconAndSkipToMap()
        mapUI.tapCurrentLocationButton()
        XCTAssertEqual(mapUI.userTrackingMode, MKUserTrackingMode.none)
        dialogManager.tap(.allow)

        XCTAssertEqual(mapUI.currentLocationButtonState, .highlighted)
        XCTAssertEqual(mapUI.userTrackingMode, .follow)
        XCTAssertTrue(mapUI.showCurrentLocation)
    }

    func testDecliningLocationPermission() {
        tapAppIconAndSkipToMap()
        mapUI.tapCurrentLocationButton()
        dialogManager.tap(.dontAllow)

        XCTAssertEqual(mapUI.currentLocationButtonState, .nonHighlighted)
    }

    func testTappingOnTheArrowWhenPermissionWasAlreadyAuthorized() {
        tapAppIconAndSkipToMap()
        mapUI.tapCurrentLocationButton()
        dialogManager.tap(.allow)
        mapUI.tapCurrentLocationButton()

        XCTAssertEqual(mapUI.currentLocationButtonState, .nonHighlighted)
        mapUI.tapCurrentLocationButton()
        XCTAssertEqual(mapUI.currentLocationButtonState, .highlighted)
    }

    func testTappingOnTheArrowWhenPermissionWasAlreadyDenied() {
        tapAppIconAndSkipToMap()
        mapUI.tapCurrentLocationButton()
        dialogManager.tap(.dontAllow)
        let mapVC = mapUI!
        mapUI.tapCurrentLocationButton()

        XCTAssertEqual(mapVC.currentLocationButtonState, .highlighted)

        XCTAssertEqual(alertUI.title, "Please give permission")
        XCTAssertEqual(alertUI.message, "You have previously declined permission to use your location.")

        XCTAssertEqual(alertUI.actions.count, 2)

        let firstAction = alertUI.actions[0]
        XCTAssertEqual(firstAction.title, "OK")
        XCTAssertEqual(firstAction.style, .default)

        let secondAction = alertUI.actions[1]
        XCTAssertEqual(secondAction.title, "Cancel")
        XCTAssertEqual(secondAction.style, .cancel)
    }

    func testTappingOnTheArrowWhenPermissionWasAlreadyDeniedAndTappingOK() {
        testTappingOnTheArrowWhenPermissionWasAlreadyDenied()

        let firstAction = alertUI.actions[0]
        XCTAssertEqual(firstAction.title, "OK")
        // TODO remove the above checks and allow a tap to be specified by action title instead of index
        // do the same for the other test below
        alertUI.tapAction(at: 0)
        XCTAssertEqual(mapUI.currentLocationButtonState, .highlighted)
        XCTAssertEqual(location, .settings)
        XCTAssertNotNil(mapUI)
    }

    func testTappingOnTheArrowWhenPermissionWasAlreadyDeniedAndReenablingPermission() {
        testTappingOnTheArrowWhenPermissionWasAlreadyDeniedAndTappingOK()

        // TODO checks to holistikit to ensure user is in settingsApp if trying to interact with it
        settingsApp.set(authorizationStatus: .authorizedWhenInUse)
        switchBackToApp()
        XCTAssertEqual(mapUI.currentLocationButtonState, .highlighted)
        XCTAssertEqual(mapUI.userTrackingMode, MKUserTrackingMode.follow)
    }
    
    func testTappingOnTheArrowWhenPermissionWasAlreadyDeniedAndTappingCancel() {
        testTappingOnTheArrowWhenPermissionWasAlreadyDenied()

        let secondAction = alertUI.actions[1]
        XCTAssertEqual(secondAction.title, "Cancel")
        alertUI.tapAction(at: 1)
        XCTAssertEqual(mapUI.currentLocationButtonState, .nonHighlighted)
        XCTAssertEqual(mapUI.userTrackingMode, MKUserTrackingMode.none)
    }

    func testTappingOnTheArrowWhenFollowingCurrentLocation() {
        tapAppIconAndSkipToMap()
        mapUI.tapCurrentLocationButton()
        dialogManager.tap(.allow)
        XCTAssertEqual(mapUI.currentLocationButtonState, .highlighted)
        XCTAssertEqual(mapUI.userTrackingMode, MKUserTrackingMode.follow)
        mapUI.tapCurrentLocationButton()

        XCTAssertEqual(mapUI.currentLocationButtonState, .nonHighlighted)
        XCTAssertEqual(mapUI.userTrackingMode, MKUserTrackingMode.none)
    }

    func testDraggingTheMapWhenFollowingCurrentLocation() {
        tapAppIconAndSkipToMap()
        mapUI.tapCurrentLocationButton()
        dialogManager.tap(.allow)
        XCTAssertEqual(mapUI.currentLocationButtonState, .highlighted)
        XCTAssertEqual(mapUI.userTrackingMode, MKUserTrackingMode.follow)
        mapUI.drag()

        XCTAssertEqual(mapUI.currentLocationButtonState, .nonHighlighted)
        XCTAssertEqual(mapUI.userTrackingMode, MKUserTrackingMode.none)
    }

    func testTappingOnTheArrowWhenLocationServicesAreOff() {
        tapAppIconAndSkipToMap()
        settingsApp.set(locationServicesEnabled: false)
        mapUI.tapCurrentLocationButton()

        XCTAssertEqual(dialogManager.visibleDialog, .locationManager(.requestJumpToLocationServicesSettings))
    }
}
