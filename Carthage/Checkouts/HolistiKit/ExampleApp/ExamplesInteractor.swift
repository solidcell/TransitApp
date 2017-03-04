import Foundation

class ExamplesInteractor {

    private let presenter: ExamplesPresenter
    fileprivate let errorLogger: ErrorLogging
    fileprivate let dataSource = ExamplesDataSource()

    init(presenter: ExamplesPresenter,
         errorLogger: ErrorLogging) {
        self.presenter = presenter
        self.errorLogger = errorLogger
    }
    
    func cellConfiguration(for indexPath: IndexPath) -> ExamplesCellConfig {
        return dataSource.cellConfiguration(for: indexPath)
    }

    var numberOfRows: Int {
        return dataSource.numberOfRows
    }

    func viewDidLoad() {
        presenter.set(title: "Examples")
    }

    func tap(rowAt indexPath: IndexPath) {
        switch indexPath {
        case IndexPath(row: 0, section: 0): presenter.push(.date)
        case IndexPath(row: 1, section: 0): presenter.push(.timer)
        case IndexPath(row: 2, section: 0): presenter.push(.urlSession)
        case IndexPath(row: 3, section: 0): presenter.push(.uiViewController)
        case IndexPath(row: 4, section: 0): presenter.push(.clLocationManager)
        default:
            errorLogger.log("Tapping on a row (section: \(indexPath.section), row: \(indexPath.row)) that is not handled")
        }
    }
}
