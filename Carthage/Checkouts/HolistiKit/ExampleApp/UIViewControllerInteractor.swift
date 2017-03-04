import Foundation

class UIViewControllerInteractor {

    private let presenter: UIViewControllerPresenter
    fileprivate let errorLogger: ErrorLogging

    init(presenter: UIViewControllerPresenter,
         errorLogger: ErrorLogging) {
        self.presenter = presenter
        self.errorLogger = errorLogger
    }

    func viewDidLoad() {
        presenter.set(title: "UIViewController")
    }
    
    func didTap(rowAt indexPath: IndexPath) {
        switch indexPath {
        case IndexPath(row: 0, section: 0):
            presenter.presentUIViewController()
        default:
            errorLogger.log("Tapping on a row (section: \(indexPath.section), row: \(indexPath.row)) that is not handled")
        }
    }
}
