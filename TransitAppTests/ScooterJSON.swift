import SwiftyJSON

class ScooterJSON {

    class func create(_ collection: [SpecScooterJSON]) -> [String : Any] {
        let mapped = collection.map({$0.asJSON})
        return JSON(["data": ["scooters": mapped]]).dictionaryObject!
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

    var asJSON: JSON {
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
