import UIKit
import MapKit

protocol MapViewFactory {

    func createAndAttachToWindow(window: UIWindow, viewModel: MapViewModel)

}

class MapViewControllerFactory : MapViewFactory {
    
    func createAndAttachToWindow(window: UIWindow, viewModel: MapViewModel) {
        let vc = MapViewController.createFromStoryboard(viewModel: viewModel)
        window.rootViewController = vc
    }
    
}
