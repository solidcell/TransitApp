import MapKit

protocol ScooterUpdaterDelegate: class {

    func received(scooters: [Scooter])
}

class MapAnnotationProvider: ScooterUpdaterDelegate {

    weak var delegate: MapAnnotationReceiving?
    private let scooterUpdater: ScooterUpdater

    init(scooterUpdater: ScooterUpdater) {
        self.scooterUpdater = scooterUpdater
        scooterUpdater.delegate = self
    }

    func start() {
        scooterUpdater.start()
    }

    private var dataSource = [String : CoupMapAnnotation]()

    private func getOrAddAnnotation(forLicensePlate licensePlate: String) -> CoupMapAnnotation {
        if let annotation = dataSource[licensePlate] {
            return annotation
        }
        let annotation = CoupMapAnnotation(title: licensePlate)
        dataSource[licensePlate] = annotation
        return annotation
    }

    private func addOrUpdateAnnotation(forScooter scooter: Scooter) {
        let annotation = getOrAddAnnotation(forLicensePlate: scooter.licensePlate)
        annotation.configure(for: scooter)
    }

    func received(scooters: [Scooter]) {
        scooters.forEach(addOrUpdateAnnotation)
        delegate?.set(annotations: Array(dataSource.values))
    }
}
