import Foundation
import UIKit

enum Design {

    enum Image {
        static let plus = UIImage(systemName: "plus")
    }

    enum Color {
        static let black = UIColor.black
        static let white = UIColor.white
        static let blue = UIColor.systemBlue
        static let red = UIColor.systemRed
        static let gray = UIColor.systemGray
        static let grayLight = UIColor.systemGray.withAlphaComponent(0.1)
    }

    enum Font {
        static let h1 = UIFont.systemFont(ofSize: 18, weight: .bold).withSize(PView.makeSizeStatic(eightLow: 18, tenUp: 18))
        static let h2 = UIFont.systemFont(ofSize: 15, weight: .regular).withSize(PView.makeSizeStatic(eightLow: 15, tenUp: 15))
        static let t1 = UIFont.systemFont(ofSize: 14, weight: .regular).withSize(PView.makeSizeStatic(eightLow: 14, tenUp: 14))
        static let button1 = UIFont.systemFont(ofSize: 15, weight: .medium).withSize(PView.makeSizeStatic(eightLow: 15, tenUp: 15))
    }
}

