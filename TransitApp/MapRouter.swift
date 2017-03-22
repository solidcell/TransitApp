import UIKit
import CoreLocation
import UIKitFringes

class MapRouter {
    
    private let mapModuleFactory: MapModuleFactory

    init(mapModuleFactory: MapModuleFactory) {
        self.mapModuleFactory = mapModuleFactory
    }

    func start(window: UIWindow) {
        let viewController = mapModuleFactory.create()
        window.rootViewController = viewController
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
