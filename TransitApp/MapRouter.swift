import UIKit

class MapRouter {
    
    private let mapModuleFactory: MapModuleFactory

    init(mapModuleFactory: MapModuleFactory) {
        self.mapModuleFactory = mapModuleFactory
    }

    var viewController: UIViewController {
        return mapModuleFactory.create()
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
