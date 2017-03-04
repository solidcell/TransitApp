import UIKitFringes

class RootRouter {

    private let examplesRouterFactory: ExamplesRouterFactory

    init(examplesRouterFactory: ExamplesRouterFactory) {
        self.examplesRouterFactory = examplesRouterFactory
    }

    func present(onWindow window: Windowing) {
        let examplesRouter = examplesRouterFactory.create()
        examplesRouter.present(onWindow: window)
    }
}
