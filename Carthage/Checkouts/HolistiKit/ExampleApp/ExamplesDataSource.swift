import UIKit

class ExamplesDataSource {

    private let data = [
        ExamplesCellConfig(title: "Date", accessoryType: .disclosureIndicator),
        ExamplesCellConfig(title: "Timer", accessoryType: .disclosureIndicator),
        ExamplesCellConfig(title: "URLSession", accessoryType: .disclosureIndicator),
        ExamplesCellConfig(title: "UIViewController", accessoryType: .disclosureIndicator),
        ExamplesCellConfig(title: "CLLocationManager", accessoryType: .disclosureIndicator)
    ]
    
    func cellConfiguration(for indexPath: IndexPath) -> ExamplesCellConfig {
        let row = indexPath.row
        return data[row]
    }

    var numberOfRows: Int {
        return data.count
    }
}

struct ExamplesCellConfig {
    
    let title: String
    let accessoryType: UITableViewCellAccessoryType
}
