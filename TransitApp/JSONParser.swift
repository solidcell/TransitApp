import SwiftyJSON

class JSONParser {
    
    func parse(filename: String) -> JSON {
        let jsonString = loadJSONString(filename: filename)
        let data = convertToData(jsonString: jsonString)
        return JSON(data: data)
    }
    
    private func convertToData(jsonString: String) -> Data {
        return jsonString.data(using: .utf8, allowLossyConversion: false)!
    }
    
    private func loadJSONString(filename: String) -> String {
        let path = Bundle.main.path(forResource: filename, ofType: "json")
        return try! String(contentsOfFile:path!, encoding: String.Encoding.utf8)
    }
    
}
