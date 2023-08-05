import UIKit

class PUITextField: UITextField, PViewSizesProtocol {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    func setup() {
        //object configuration:
    }
}
