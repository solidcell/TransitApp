import SwiftyJSON

class ScooterParser {

    func parse(json: JSON) -> [Scooter] {
        let data = json["data"].dictionary!
        let scooterJsons = data["scooters"]!.array!
        return scooterJsons.map(scooter)
    }

    private func scooter(json: JSON) -> Scooter {
        let location = json["location"].dictionary!
        return Scooter(latitude: location["lat"]!.double!,
                       longitude: location["lng"]!.double!)
    }
    
}
