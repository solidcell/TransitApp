import UIKit

class RootRouter {

    private let mapRouterFactory: MapRouterFactory

    init(mapRouterFactory: MapRouterFactory) {
        self.mapRouterFactory = mapRouterFactory
    }

    var viewController: UIViewController {
        let mapRouter = mapRouterFactory.create()
        return mapRouter.viewController
    }
}

class RootRouterFactory {
    
    private let mapRouterFactory: MapRouterFactory
    
    init(mapRouterFactory: MapRouterFactory) {
        self.mapRouterFactory = mapRouterFactory
    }

    func create() -> RootRouter {
        return RootRouter(mapRouterFactory: mapRouterFactory)
    }
}
