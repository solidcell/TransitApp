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
        var mapView: SpecMapViewInterating!

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

        describe("the map overlays") {

            it("are seeded with 3 business areas") {
                expect(mapView.mapOverlays).to(haveCount(3))
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

        describe("map annotations") {

            context("when updated over the network") {

                beforeEach {
                    expect(mapView.mapAnnotations).to(haveCount(0))
                    fetchTimer.fire()
                    let response = ["data": ["scooters": [
                        ["id":"05ba8757-c7d3-42ad-b225-242d85c63aa2","vin":"RHMGRSAN0GT1R0112","model":"Gogoro 1st edition","license_plate":"198FCE","energy_level":70,"location":["lng":13.415355,"lat":52.517223]],
                        ["id":"05bdd9ae-af0c-49af-9ee5-815614f3fcdd","vin":"RHMGRSAN0GT1R0115","model":"Gogoro 1st edition","license_plate":"201FCE","energy_level":53,"location":["lng":13.360313,"lat":52.494534]]
                        ]]]
                    jsonFetcher.fetchSuccess(response)
                    expect(scooterRealmNotifier.callbackExecuted).toEventually(beTrue())
                }

                it("should update on the map") {
                    expect(mapView.mapAnnotations).to(haveCount(2))
                }
                
            }
        }
    }
    
}
