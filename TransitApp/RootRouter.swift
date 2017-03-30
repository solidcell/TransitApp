import UIKit

class RootRouter {

    private let mapRouterFactory: MapRouterFactory

    init(mapRouterFactory: MapRouterFactory) {
        self.mapRouterFactory = mapRouterFactory
    }

    func start(window: UIWindow) {
        let mapRouter = mapRouterFactory.create()
        mapRouter.start(window: window)
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
