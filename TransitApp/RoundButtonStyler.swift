import UIKit

class RoundButtonStyler {

    class func style(button: UIButton) {
        addCircleBackground(toButton: button)
        positionImageWithinCircle(forButton: button)
        addShadow(toButton: button)
    }

    class private func addShadow(toButton button: UIButton) {
        button.layer.shadowRadius = 5.0
        button.layer.shadowOffset = CGSize(width: 0, height: 0)
        button.layer.shadowOpacity = 0.2
    }

    class private func addCircleBackground(toButton button: UIButton) {
        button.backgroundColor = UIColor(rgb: 0xeff5f4)
        button.layer.borderColor = UIColor(rgb: 0x7c8082).cgColor
        button.layer.borderWidth = 0.25
        button.layer.cornerRadius =  button.frame.height/2
    }
    
    class private func positionImageWithinCircle(forButton button: UIButton) {
        button.imageEdgeInsets = imageInsets(forButton: button)
    }

    class private func imageInsets(forButton button: UIButton) -> UIEdgeInsets {
        let buttonHeight = button.frame.height
        let imageSizePercentage: CGFloat = 0.6
        let imageInset: CGFloat = buttonHeight/2 * (1 - imageSizePercentage)
        let irregularSideExtra: CGFloat = buttonHeight * imageSizePercentage * 0.15
        return UIEdgeInsetsMake(imageInset+irregularSideExtra,
                                imageInset,
                                imageInset,
                                imageInset+irregularSideExtra)
    }

}
