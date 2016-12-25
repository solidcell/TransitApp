import Quick
import Nimble
import RealmSwift
import MapKit
import FakeLocationManager
@testable import TransitApp

class BlahSpec: TransitAppSpec {
    
    override func spec() {
        super.spec()

        var subject: MainCoordinator!
        var scooterRealmNotifier: SpecScooterRealmNotifier!
        var jsonFetcher: SpecJSONFetcher!
        var fetchTimer: SpecFetchTimer!
        var locationManager: FakeLocationManager!
        var mapView: SpecMapView!

        beforeEach {
            scooterRealmNotifier = SpecScooterRealmNotifier(realm: self.realm)
            jsonFetcher = SpecJSONFetcher()
            fetchTimer = SpecFetchTimer()
            locationManager = FakeLocationManager()
            let mapViewFactory = SpecMapViewFactory()
            subject = MainCoordinator()
            subject.start(window: UIWindow(),
                          mapViewFactory: mapViewFactory,
                          realm: self.realm,
                          scooterRealmNotifier: scooterRealmNotifier,
                          jsonFetcher: jsonFetcher,
                          fetchTimer: fetchTimer,
                          locationManager: locationManager)
            mapView = mapViewFactory.mapView
        }

        describe("the map region") {

            it("starts at an initial value") {
                expect(mapView.mapRegion).toNot(beNil())
            }
            
        }

        describe("tapping on the Current Location Arrow") {

            beforeEach {
                mapView.tapCurrentLocationButton()
            }

            it("will present an authorization dialog") {
                // it will not fatalError if there is a dialog to tap
                // TODO add a way to just check for presence of dialog type
                locationManager.tapAllowInDialog()
            }

            describe("accepting location permission") {

                beforeEach {
                    locationManager.tapAllowInDialog()
                }

                it("will center the map on the current location") {
                    expect(mapView.mapCenteredOn).to(beNil())
                    locationManager.locationRequestSuccess()
                    expect(mapView.mapCenteredOn).toNot(beNil())
                }
            }
            
        }
    }
    
}
