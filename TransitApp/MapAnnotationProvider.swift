import RealmSwift
import MapKit

class MapAnnotationProvider {

    weak var delegate: MapAnnotationReceiving? {
        didSet {
            notifyDelegate()
        }
    }
    private let mapAnnotationCreator = MapAnnotationCreator()
    private let dataSource: MapAnnotationDataSourcing

    init(dataSource: MapAnnotationDataSourcing) {
        self.dataSource = dataSource
        self.dataSource.delegate = self
    }

    func dataUpdated() {
        notifyDelegate()
    }

    private func notifyDelegate() {
        delegate?.newAnnotations(annotations)
    }

    var annotations: [MKAnnotation] {
        let scooters = self.dataSource.results
        return self.mapAnnotationCreator.annotations(scooters: scooters)
    }

}

protocol MapAnnotationReceiving: class {

    func newAnnotations(_ annotations: [MKAnnotation])
    
}
