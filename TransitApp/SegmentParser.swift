import SwiftyJSON

class SegmentParser {

    func parse(json: JSON) -> Segment {
        let attributes = json.dictionary!
        let name = attributes["name"]!.string
        return Segment(name: name)
    }
    
}
