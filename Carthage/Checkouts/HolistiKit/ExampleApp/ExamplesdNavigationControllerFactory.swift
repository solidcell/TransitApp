class ExamplesNavigationControllerFactory: ExamplesNavigationControllerFactoryProtocol {
    
    func create() -> ExamplesNavigationControlling {
        return ExamplesNavigationController()
    }
}

protocol ExamplesNavigationControllerFactoryProtocol {
    
    func create() -> ExamplesNavigationControlling
}
