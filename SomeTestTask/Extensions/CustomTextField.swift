import Foundation
import UIKit

class CustomTextField: PUITextField {

    // MARK: - properties

    let padding = UIEdgeInsets(top: 30,
                               left: 16,
                               bottom: 0,
                               right: 16)

    // MARK: - views

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = Design.Font.h2
        label.textColor = Design.Color.gray
        label.textAlignment = .left
        return label
    }()

    // MARK: - overrides

    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override func setup() {

        backgroundColor = Design.Color.white
        layer.borderWidth = makeSize(eightLow: 2, tenUp: 2)
        layer.borderColor = Design.Color.grayLight.cgColor
        layer.cornerRadius = makeSize(eightLow: 10, tenUp: 10)

        // MARK: - Add Subviews
        addSubview(titleLabel)

        // MARK: - Add Constraints
        setupConstraintsForSelf()
        setupConstraintsForTitleLabel()
    }

    func configure(title: String) {
        titleLabel.text = title
        self.placeholder = "Введите \(title.lowercased())"
    }
}

// MARK: - sizes extensions

extension CustomTextField {

    func setupConstraintsForTitleLabel() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(makeSize(eightLow: 10, tenUp: 10))
            make.left.equalToSuperview().offset(makeSize(eightLow: 16, tenUp: 16))
        }
    }

    func setupConstraintsForSelf() {
        snp.makeConstraints { make in
            make.height.equalTo(makeSize(eightLow: 60, tenUp: 60))
        }
    }
}
