import RealmSwift
import MapKit

// Unfortunately, MKMapView doesn't have a built-in datasource
// for MKAnnotations, so this is a solution to that need.
// Here, we keep a reference to MKAnnotations which, when added,
// updated, or removed, will notify the delegate so the MKMapView
// can be kept in sync.

class MapAnnotationProvider {

    weak var delegate: MapAnnotationReceiving? {
        didSet {
            delegate?.newAnnotations(annotations)
        }
    }
    private let dataSource: MapAnnotationDataSourcing

    init(dataSource: MapAnnotationDataSourcing) {
        self.dataSource = dataSource
        self.dataSource.delegate = self
    }

    func initialData(scooters: [Scooter]) {
        addNewAnnotations(scooters: scooters)
    }

    func dataUpdated(deletions: [Scooter],
                     insertions: [Scooter],
                     modifications: [Scooter]) {
        if !insertions.isEmpty {
            addNewAnnotations(scooters: insertions)
        }
        if !modifications.isEmpty {
            updateAnnotations(scooters: modifications)
        }
    }

    private var annotations: [CoupMapAnnotation] {
        return Array(self.annotationDict.values)
    }

    // TODO why does using Scooter as the key not work?
    // It's Hashable and `hashValue` is consistent..
    private var annotationDict = [String : CoupMapAnnotation]()
    private func keyForScooter(_ scooter: Scooter) -> String {
        return scooter.licensePlate
    }

    private func updateAnnotations(scooters: [Scooter]) {
        delegate?.annotationsReadyForUpdate { [weak self] in
            guard let strongSelf = self else { return }
            scooters.forEach { scooter in
                let annotation = strongSelf.annotationDict[strongSelf.keyForScooter(scooter)]!
                annotation.configure(for: scooter)
            }
        }
    }

    private func addNewAnnotations(scooters: [Scooter]) {
        scooters.forEach { scooter in
            annotationDict[keyForScooter(scooter)] = CoupMapAnnotation(scooter: scooter)
        }
        delegate?.newAnnotations(annotations)
    }

}

protocol MapAnnotationReceiving: class {

    func newAnnotations(_ annotations: [MKAnnotation])
    func annotationsReadyForUpdate(update: @escaping () -> Void)
    
}
