import Foundation
import MapKit

class CoupMapAnnotation: NSObject, MKAnnotation {
    
    let title: String?
    var energyLevel = 0
    var coordinate = CLLocationCoordinate2D()

    init(title: String) {
        self.title = title
    }

    var subtitle: String? {
        return "\(energyLevel)%"
    }

    func configure(for scooter: Scooter) {
        coordinate = scooter.coordinate
        energyLevel = scooter.energyLevel
    }
    
}
