import Quick
import Nimble
import FakeLocationManager
@testable import TransitApp

class GeneralFeaturesSpec: TransitAppSpec {
    
    override func spec() {
        super.spec()

        var scooterUpdater: SpecScooterUpdater!
        // Let the object graph hold onto this, so as not to
        // mask possible retain issues
        weak var locationManager: FakeLocationManager!
        // Hold onto these, as the AppDelegate and UIKit would
        var subject: MainCoordinator!
        var mapView: SpecMapViewInterating!

        beforeEach {
            let scooterRealmNotifier = SpecScooterRealmNotifier(realm: self.realm)
            let jsonFetcher = SpecJSONFetcher()
            let fetchTimer = SpecFetchTimer()
            scooterUpdater = SpecScooterUpdater(scooterRealmNotifier: scooterRealmNotifier,
                                                jsonFetcher: jsonFetcher,
                                                fetchTimer: fetchTimer)
            let _locationManager = FakeLocationManager()
            locationManager = _locationManager
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

            context("when added over the network") {

                beforeEach {
                    expect(mapView.mapAnnotations).to(haveCount(0))
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
                    scooterUpdater.updatesWith(response)
                }

                it("should add them on the map") {
                    expect(mapView.mapAnnotations).to(haveCount(2))
                }
                
            }
            
            context("when updated over the network") {

                beforeEach {
                    expect(mapView.mapAnnotations).to(haveCount(0))
                    let response = ScooterJSON.create([
                        SpecScooterJSON(id: "05ba8757-c7d3-42ad-b225-242d85c63aa2",
                                        vin: "RHMGRSAN0GT1R0112",
                                        model: "Gogoro 1st edition",
                                        lat: 52.494534,
                                        lng: 13.360313,
                                        energyLevel: 70,
                                        licensePlate: "198FCE")])
                    scooterUpdater.updatesWith(response)
                    expect(mapView.mapAnnotations).to(haveCount(1))
                }

                it("should update them on the map") {
                    let response = ScooterJSON.create([
                        SpecScooterJSON(id: "05ba8757-c7d3-42ad-b225-242d85c63aa2",
                                        vin: "RHMGRSAN0GT1R0112",
                                        model: "Gogoro 1st edition",
                                        lat: 50.222222,
                                        lng: 15.444444,
                                        energyLevel: 43,
                                        licensePlate: "198FCE")])
                    scooterUpdater.updatesWith(response)
                    expect(mapView.mapAnnotations).to(haveCount(1))
                }
                
            }
        }
    }
    
}
