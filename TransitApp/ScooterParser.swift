import SwiftyJSON
import CoreLocation

class ScooterParser {

    func parse(json: JSON) -> [Scooter] {
        let data = json["data"].dictionary!
        let scooterJsons = data["scooters"]!.array!
        return scooterJsons.map(scooter)
    }

    private func scooter(json: JSON) -> Scooter {
        let location = json["location"].dictionary!
        
        let coordinate = CLLocationCoordinate2D(latitude: location["lat"]!.double!,
                                                longitude: location["lng"]!.double!)
        return Scooter(coordinate: coordinate,
                       energyLevel: json["energy_level"].int!,
                       licensePlate: json["license_plate"].string!)
    }
    
}
