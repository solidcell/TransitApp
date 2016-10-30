// taken from https://www.ralfebert.de/snippets/ios/swift-uicolor-rgb-extension/

import UIKit

extension UIColor {

    // UIColor(rgb: 0x8046A2, alpha: 0.5)
    // UIColor(rgb: 0x8046A2)
    convenience init(rgb: Int, alpha: CGFloat = 1.0) {
        let r = CGFloat((rgb & 0xff0000) >> 16) / 255
        let g = CGFloat((rgb & 0x00ff00) >>  8) / 255
        let b = CGFloat((rgb & 0x0000ff)      ) / 255

        self.init(red: r, green: g, blue: b, alpha: alpha)
    }

}
