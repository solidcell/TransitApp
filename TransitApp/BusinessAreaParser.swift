import SwiftyJSON

class BusinessAreaParser {
    
    let businessAreaCoordinateParser = BusinessAreaCoordinateParser()

    func parse(json: JSON) -> [BusinessArea] {
        let data = json["data"].dictionary!
        let businessAreas = data["business_areas"]!.array!
        return businessAreas.map(jsonToBusinessArea)
    }

    private func jsonToBusinessArea(json: JSON) -> BusinessArea {
        let coordinatesJSON = json["polygon"].array![0]
        let coordinates = businessAreaCoordinateParser.parse(json: coordinatesJSON)
        return BusinessArea(coordinates: coordinates)
    }
    
}
