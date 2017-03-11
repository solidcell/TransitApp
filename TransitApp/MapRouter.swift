import UIKit
import CoreLocation
import UIKitFringes

class MapRouter {
    
    private let mapModuleFactory: MapModuleFactory

    init(mapModuleFactory: MapModuleFactory) {
        self.mapModuleFactory = mapModuleFactory
    }

    func start(window: Windowing) {
        let viewController = mapModuleFactory.create()
        window.set(rootViewController: viewController)
    }
}

class MapRouterFactory {
    
    private let mapModuleFactory: MapModuleFactory

    init(mapModuleFactory: MapModuleFactory) {
        self.mapModuleFactory = mapModuleFactory
    }

    func create() -> MapRouter {
        return MapRouter(mapModuleFactory: mapModuleFactory)
    }
}
