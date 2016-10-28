import SwiftyJSON

class StopParser {

    func parse(json: JSON) -> Stop {
        let name = json["name"].string
        let latitude = json["lat"].double!
        let longitude = json["lng"].double!
        return Stop(name: name,
                    latitude: latitude,
                    longitude: longitude)
    }
    
}
