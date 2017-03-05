import Foundation
import MapKit

class CoupMapAnnotation: NSObject, MKAnnotation {
    
    let title: String?
    var energyLevel = 0
    var coordinate = CLLocationCoordinate2D()

    init(scooter: Scooter) {
        self.title = scooter.licensePlate
        super.init()
        configure(for: scooter)
    }

    var subtitle: String? {
        return "\(self.energyLevel)%"
    }

    func configure(for scooter: Scooter) {
        coordinate = scooter.coordinate
        energyLevel = scooter.energyLevel
    }
    
}
