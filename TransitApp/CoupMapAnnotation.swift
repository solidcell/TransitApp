import Foundation
import MapKit

class CoupMapAnnotation: NSObject, MKAnnotation {
    
    let title: String?
    let coordinate: CLLocationCoordinate2D
    private let energyLevel: Int

    init(title: String, coordinate: CLLocationCoordinate2D, energyLevel: Int) {
        self.title = title
        self.coordinate = coordinate
        self.energyLevel = energyLevel
    }

    var subtitle: String? {
        return "\(self.energyLevel)%"
    }
    
}
