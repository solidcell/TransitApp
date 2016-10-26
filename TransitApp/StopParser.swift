import SwiftyJSON

class StopParser {

    func parse(json: JSON) -> Stop {
        let name = json["name"].string
        let longitude = json["lng"].double!
        let latitude = json["lat"].double!
        return Stop(name: name,
                    longitude: longitude,
                    latitude: latitude)
    }
    
}
