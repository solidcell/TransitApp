import UIKitFringes
import CoreLocation

class CLLocationManagerInteractor: NSObject, CLLocationManagerDelegate {

    private let presenter: CLLocationManagerPresenter
    private let locationManager: LocationManaging
    private let errorLogger: ErrorLogging

    init(presenter: CLLocationManagerPresenter,
         locationManager: LocationManaging,
         errorLogger: ErrorLogging) {
        self.presenter = presenter
        self.locationManager = locationManager
        self.errorLogger = errorLogger
    }

    func viewDidLoad() {
        locationManager.delegate = self
        presenter.set(title: "CLLocationManager")
        presenter.set(authorizationStatus: locationManager.authorizationStatus())
    }

    func didTap(rowAt indexPath: IndexPath) {
        switch indexPath {
        case IndexPath(row: 0, section: 1): locationManager.requestWhenInUseAuthorization()
        default:
            errorLogger.log("Tapping on a row (section: \(indexPath.section), row: \(indexPath.row)) that is not handled")
        }
    }

    func locationManager(_: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        presenter.set(authorizationStatus: status)
    }
}
