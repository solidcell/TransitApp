import Foundation

class ScooterJSON {

    class func create(_ collection: [SpecScooterJSON]) -> Data {
        let mapped = collection.map({$0.asJSON})
        let json = ["data": ["scooters": mapped]]
        return try! JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
    }
}

struct SpecScooterJSON {

    let id: String
    let vin: String
    let model: String
    let lat: Float
    let lng: Float
    let energyLevel: Int
    let licensePlate: String

    var asJSON: [String: Any] {
        return [
            "id" : id,
            "vin" : vin,
            "model" : model,
            "license_plate" : licensePlate,
            "energy_level" : energyLevel,
            "location" : ["lng" : lng, "lat" : lat]
        ]
    }
    
}
