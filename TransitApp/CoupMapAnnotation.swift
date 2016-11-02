import Foundation
import MapKit

class CoupMapAnnotation: NSObject, MKAnnotation {
    
    let title: String?
    var energyLevel = 0
    // dynamic is necessary for animation when changing coordinate
    dynamic var coordinate = CLLocationCoordinate2D()

    init(title: String) {
        self.title = title
    }

    var subtitle: String? {
        return "\(self.energyLevel)%"
    }

    func configure(for scooter: Scooter) {
        coordinate = scooter.coordinate
        energyLevel = scooter.energyLevel
    }
    
}
