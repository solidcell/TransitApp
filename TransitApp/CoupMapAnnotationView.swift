import MapKit

class CoupMapAnnotationView: MKPinAnnotationView {

    func configure(annotation: CoupMapAnnotation) {
        configurePinColor(annotation: annotation)
        configureCallout()
    }
    
    private func configureCallout() {
        canShowCallout = true
    }

    private func configurePinColor(annotation: CoupMapAnnotation) {
        let color: UIColor
        switch annotation.energyLevel {
        case 0...30:
            color = UIColor.red
        case 31...50:
            color = UIColor.yellow
        case 51...100:
            color = UIColor.green
        default:
            fatalError()
        }
        pinTintColor = color
    }
    
}
