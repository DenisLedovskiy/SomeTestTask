import UIKit

protocol ChildrenFooterViewDelegate: AnyObject {
    func tapClearButton()
}

class ChildrenFooterView: PCollectionReusableView {

    // MARK: - properties

    weak var delegate: ChildrenFooterViewDelegate?

    // MARK: - views

    lazy var clearButton: UIButton = {
        let button = UIButton()
        button.layer.borderWidth = 2
        button.layer.borderColor = Design.Color.red.cgColor
        button.layer.cornerRadius = 22
        let attributedString = NSAttributedString(string: "Очистить",
                                                        attributes: [NSAttributedString.Key.foregroundColor : Design.Color.red,
                                                                     NSAttributedString.Key.font : Design.Font.button1])
        button.setAttributedTitle(attributedString, for: .normal)
        button.addTarget(self, action: #selector(tapClear), for: .touchUpInside)
        return button
    }()

    // MARK: - overrides
    override class var elementKind: String {
        return UICollectionView.elementKindSectionFooter
    }

    override func setup() {
        // MARK: - Add Subviews
        addSubview(clearButton)

        // MARK: - Add Constraints
        configureConstraints()
    }

    // MARK: - methods

    @objc
    private func tapClear() {
        delegate?.tapClearButton()
    }

    private func configureConstraints() {
        clearButton.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(makeSize(eightLow: 200, tenUp: 200))
            make.height.equalTo(makeSize(eightLow: 44, tenUp: 44))
        }
    }
}
