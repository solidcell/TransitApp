
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

    func received(scooters: [Scooter]) {
        let annotations = scooters.map(CoupMapAnnotation.init)
        delegate?.set(annotations: annotations)
    }
}
