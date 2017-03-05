import SwiftyJSON
import CoreLocation

class BusinessAreaCoordinateParser {

    func parse(json: JSON) -> [CLLocationCoordinate2D] {
        let coordinates = json.array!
        return coordinates.map(jsonToCoordinate)
    }

    private func jsonToCoordinate(json: JSON) -> CLLocationCoordinate2D {
        let coordinate = json.array!
        let longitude = coordinate[0].double!
        let latitude = coordinate[1].double!
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}
