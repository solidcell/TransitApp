import SwiftyJSON

class BusinessAreaCoordinateParser {

    func parse(json: JSON) -> [BusinessAreaCoordinate] {
        let coordinates = json.array!
        return coordinates.map(jsonToCoordinate)
    }

    private func jsonToCoordinate(json: JSON) -> BusinessAreaCoordinate {
        let coordinate = json.array!
        let longitude = coordinate[0].double!
        let latitude = coordinate[1].double!
        return BusinessAreaCoordinate(latitude: latitude, longitude: longitude)
    }
    
}
