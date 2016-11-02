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
    private let mapAnnotationCreator = MapAnnotationCreator()
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

    var annotations: [CoupMapAnnotation] {
        return Array(self.annotationDict.values)
    }

    // TODO why does using Scooter as the key not work?
    // It's Hashable and `hashValue` is consistent..
    private var annotationDict = [String : CoupMapAnnotation]()

    private func updateAnnotations(scooters: [Scooter]) {
        delegate?.annotationsReadyForUpdate { [weak self] in
            guard let strongSelf = self else { return }
            scooters.forEach { scooter in
                // TODO DRY this logic with the creation logic by making it a `configure`
                // Also, add `coordinate` as an extension to Scooter
                let annotation = strongSelf.annotationDict[scooter.licensePlate]
                annotation!.coordinate = CLLocationCoordinate2D(latitude: scooter.latitude, longitude: scooter.longitude)
//                annotation!.energyLevel = scooter.energyLevel
            }
        }
    }

    private func addNewAnnotations(scooters: [Scooter]) {
        scooters.forEach { scooter in
            annotationDict[scooter.licensePlate] = mapAnnotationCreator.scooterToAnnotation(scooter: scooter)
        }
        delegate?.newAnnotations(annotations)
    }

}

protocol MapAnnotationReceiving: class {

    func newAnnotations(_ annotations: [MKAnnotation])
    func annotationsReadyForUpdate(update: @escaping () -> Void)
    
}
