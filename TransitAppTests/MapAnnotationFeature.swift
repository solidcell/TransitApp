import XCTest

class MapAnnotationFeature: TransitAppFeature {

    private func respond(with data: Data) {
        dateProvider.progress(seconds: 15)
        let urlString = "https://app.joincoup.com/api/v1/scooters.json"
        let url = URL(string: urlString)!
        let urlResponse = URLResponse(url: url,
                                      mimeType: "application/json",
                                      expectedContentLength: data.count,
                                      textEncodingName: nil)
        urlSession.respond(to: urlString, with: .success(data, urlResponse))
    }

    func testWhenScootersAreAddedOverTheNetwork() {
        XCTAssertEqual(mapView.mapAnnotations.count, 0)
        let data = ScooterJSON.create([
            SpecScooterJSON(id: "05ba8757-c7d3-42ad-b225-242d85c63aa2",
                            vin: "RHMGRSAN0GT1R0112",
                            model: "Gogoro 1st edition",
                            lat: 52.494534,
                            lng: 13.360313,
                            energyLevel: 70,
                            licensePlate: "198FCE"),
            SpecScooterJSON(id: "1211d9ae-af0c-49af-9ee5-815614f3fcdd",
                            vin: "RHMGRSAN0GT1R0115",
                            model: "Gogoro 1st edition",
                            lat: 52.51722,
                            lng: 13.415355,
                            energyLevel: 53,
                            licensePlate: "201FCE")
            ])
        respond(with: data)

        XCTAssertEqual(mapView.mapAnnotations.count, 2)
    }

    func testWhenScootersAreUpdatedOverTheNetwork() {

        XCTAssertEqual(mapView.mapAnnotations.count, 0)
        let existingResponse = ScooterJSON.create([
            SpecScooterJSON(id: "05ba8757-c7d3-42ad-b225-242d85c63aa2",
                            vin: "RHMGRSAN0GT1R0112",
                            model: "Gogoro 1st edition",
                            lat: 52.494534,
                            lng: 13.360313,
                            energyLevel: 70,
                            licensePlate: "198FCE")])
        respond(with: existingResponse)
        XCTAssertEqual(mapView.mapAnnotations.count, 1)

        let response = ScooterJSON.create([
            SpecScooterJSON(id: "05ba8757-c7d3-42ad-b225-242d85c63aa2",
                            vin: "RHMGRSAN0GT1R0112",
                            model: "Gogoro 1st edition",
                            lat: 50.222222,
                            lng: 15.444444,
                            energyLevel: 43,
                            licensePlate: "198FCE")])
        respond(with: response)
        XCTAssertEqual(mapView.mapAnnotations.count, 1)
    }
}
