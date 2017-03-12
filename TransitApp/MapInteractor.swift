import Foundation

class MapInteractor {

    private let presenter: MapPresenter
    private let mapViewDelegate: MapViewDelegate
    private let currentLocationViewModel: CurrentLocationViewModel

    init(presenter: MapPresenter,
         mapViewDelegate: MapViewDelegate,
         currentLocationViewModel: CurrentLocationViewModel) {
        self.presenter = presenter
        self.mapViewDelegate = mapViewDelegate
        self.currentLocationViewModel = currentLocationViewModel
    }

    func viewDidLoad(mapViewDelegateHaving: MKMapViewDelegateHaving) {
        mapViewDelegateHaving.delegate = mapViewDelegate
        currentLocationViewModel.delegate = presenter
        presenter.viewDidLoad()
    }

    func tapCurrentLocationButton() {
        currentLocationViewModel.tapCurrentLocationButton()
    }
}
