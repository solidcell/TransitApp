import RealmSwift
import MapKit

class MapAnnotationProvider {

    weak var delegate: MapAnnotationReceiving? {
        didSet {
            delegate?.newAnnotations(annotations)
        }
    }
    private let mapAnnotationCreator = MapAnnotationCreator()
    private let dataSource: MapAnnotationDataSourcing

    init(dataSource: MapAnnotationDataSourcing) {
        self.dataSource = dataSource
        self.dataSource.delegate = self
    }

    func dataUpdated(deletions: [Scooter],
                     insertions: [Scooter],
                     modifications: [Scooter]) {
        if !insertions.isEmpty {
            addNewAnnotations(scooters: insertions)
        }
    }

    var annotations = [CoupMapAnnotation]()

    private func addNewAnnotations(scooters: [Scooter]) {
        let newAnnotations = self.mapAnnotationCreator.annotations(scooters: scooters)
        self.annotations += newAnnotations
        delegate?.newAnnotations(annotations)
    }

}

protocol MapAnnotationReceiving: class {

    func newAnnotations(_ annotations: [MKAnnotation])
    
}
