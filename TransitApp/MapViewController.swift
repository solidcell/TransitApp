import UIKit
import MapKit

class MapViewController: UIViewController, CLLocationManagerDelegate {

    var mapAnnotationProvider: MapAnnotationProvider!
    var mapOverlayProvider: MapOverlayProvider!
    var initialCoordinateRegion: MKCoordinateRegion!
    var mapViewDelegate: MKMapViewDelegate!
    var scooterUpdater: ScooterUpdater!

    @IBOutlet weak var mapView: MKMapView!

    let locationManager = CLLocationManager()
    override func viewDidLoad() {
        super.viewDidLoad()

        mapView.delegate = mapViewDelegate
        mapView.setRegion(initialCoordinateRegion, animated: true)
        configureMapOverlays()
        mapAnnotationProvider.delegate = self

        // If this method (or `requestAlwaysAuthorization`) is not called, 
        // then calling other CLLocationManager methods will have no effect.
        //
        // it will pop up a dialog:
        //
        // This dialog will only ever show up twice, so use it wisely.
        // It only counts if the user responds. So, for instance, you could dismiss
        // the dialog without it counting by doing one of the following:
        //
        // If not enabled, it's probably best to use a manual dialog at first
        // to confirm with the user what's going on and to be sure we should use an attempt.
        // I've not investigated how to know when the dialog is being shown,
        // if there are remaining attempts left, how many, etc.
        //
        //
        // If Location Services are enabled,
        // It will pop up a dialog (message is specific to `WhenInUse`, not `Always`):
        //
        // This dialog will only ever show up once. The same notes about the dialog
        // for Location Services being turned off also apply here (dismiss without counting,
        // using it wisely, etc.).
        // If the user allows access and then later revokes access in Settings, calling
        // this will still have no effect.
        print("-------")
        locationManager.delegate = self
        print(CLLocationManager.authorizationStatus().rawValue)
        locationManager.requestWhenInUseAuthorization()
        print("-------")
//        locationManager.requestWhenInUseAuthorization()
//
//        if CLLocationManager.locationServicesEnabled() {
//            locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
//            locationManager.requestLocation()
//            locationManager.startUpdatingLocation()
//            mapView.showsUserLocation = true
//        }
    }

    private func configureMapOverlays() {
        mapOverlayProvider.overlays.forEach(mapView.add)
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("*****************")
        print(locations)
        mapView.setCenter(locations.first!.coordinate, animated: true)
        print("*****************")
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("*****************")
        print(error)
        print("*****************")
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print("++++++++++++++++++++++++++++++++")
        print(status.rawValue)
        print("++++++++++++++++++++++++++++++++")
    }
}

extension MapViewController: MapAnnotationReceiving {

    func newAnnotations(_ annotations: [MKAnnotation]) {
        annotations.forEach(mapView.addAnnotation)
    }

    func annotationsReadyForUpdate(update: @escaping () -> Void) {
        UIView.animate(withDuration: 1.0) {
            update()
        }
    }
    
}

// MARK: Creation
extension MapViewController {
    
    private static var storyboardName = "MapViewController"

    // Using a Storyboard, rather than a NIB, allows us access
    // to top/bottom layout guides in Interface Builder
    class func createFromStoryboard(mapAnnotationProvider: MapAnnotationProvider,
                                    mapOverlayProvider: MapOverlayProvider,
                                    initialCoordinateRegion: MKCoordinateRegion,
                                    mapViewDelegate: MKMapViewDelegate,
                                    scooterUpdater: ScooterUpdater) -> MapViewController {
        let vc = UIStoryboard(name: storyboardName, bundle: nil)
            .instantiateInitialViewController() as! MapViewController
        vc.mapAnnotationProvider = mapAnnotationProvider
        vc.mapOverlayProvider = mapOverlayProvider
        vc.initialCoordinateRegion = initialCoordinateRegion
        vc.mapViewDelegate = mapViewDelegate
        vc.scooterUpdater = scooterUpdater
        return vc
    }
    
}
