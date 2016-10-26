import SwiftyJSON

class SegmentParser {

    fileprivate let stopParser = StopParser()

    func parse(json: JSON) -> Segment {
        let attributes = json.dictionary!
        let name = attributes["name"]!.string
        let stops = parseStops(json: json)
        return Segment(name: name,
                       stops: stops)
    }
    
}

fileprivate extension SegmentParser {

    func parseStops(json: JSON) -> [Stop] {
        let stops = json["stops"].array!
        return stops.map(stopParser.parse)
    }
    
}
