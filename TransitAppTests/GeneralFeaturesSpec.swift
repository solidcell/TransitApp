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
                    let response = ScooterJSON.create([
                        SpecScooterJSON(id: "05ba8757-c7d3-42ad-b225-242d85c63aa2",
                                        vin: "RHMGRSAN0GT1R0112",
                                        model: "Gogoro 1st edition",
                                        lat: 52.494534,
                                        lng: 13.360313,
                                        energyLevel: 70,
                                        licensePlate: "198FCE"),
                        SpecScooterJSON(id: "1211d9ae-af0c-49af-9ee5-815614f3fcdd",
                                        vin: "RHMGRSAN0GT1R0115",
                                        model: "Gogoro 1st edition",
                                        lat: 52.51722,
                                        lng: 13.415355,
                                        energyLevel: 53,
                                        licensePlate: "201FCE")
                        ])
                    jsonFetcher.fetchSuccess(response)
                    expect(scooterRealmNotifier.callbackExecuted).toEventually(beTrue())
                }

                fit("should update on the map") {
                    expect(mapView.mapAnnotations).to(haveCount(2))
                }
                
            }
        }
    }
    
}
