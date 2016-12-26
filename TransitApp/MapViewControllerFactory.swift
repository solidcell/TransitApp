import UIKit
import MapKit

protocol MapViewFactory {

    func createAndAttachToWindow(window: UIWindow, viewModel: MapViewModel)

}

class MapViewControllerFactory : MapViewFactory {
    
    private let storyboardName = "MapViewController"
    
    func createAndAttachToWindow(window: UIWindow, viewModel: MapViewModel) {
        // Using a Storyboard, rather than a NIB, allows us access
        // to top/bottom layout guides in Interface Builder
        let vc = UIStoryboard(name: storyboardName, bundle: nil)
            .instantiateInitialViewController() as! MapViewController
        vc.viewModel = viewModel
        window.rootViewController = vc
    }
    
}
