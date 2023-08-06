import UIKit

protocol ChildrenHeaderViewDelegate: AnyObject {
    func tapAddButton()
}

class ChildrenHeaderView: PCollectionReusableView {

    // MARK: - properties

    weak var delegate: ChildrenHeaderViewDelegate?

    // MARK: - views

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = Design.Font.h1
        label.textColor = Design.Color.black
        return label
    }()

    lazy var addButton: UIButton = {
        let button = UIButton()
        button.layer.borderWidth = 2
        button.layer.borderColor = Design.Color.blue.cgColor
        button.layer.cornerRadius = 22
        button.setImage(Design.Image.plus, for: .normal)
        let attributedString = NSAttributedString(string: " Добавить ребенка",
                                                        attributes: [NSAttributedString.Key.foregroundColor : Design.Color.blue,
                                                                     NSAttributedString.Key.font : Design.Font.button1])
        button.setAttributedTitle(attributedString, for: .normal)
        button.addTarget(self, action: #selector(tapAdd), for: .touchUpInside)
        return button
    }()

    // MARK: - overrides
    override func setup() {
        // MARK: - Add Subviews
        addSubview(titleLabel)
        addSubview(addButton)

        // MARK: - Add Constraints
        configureConstraints()
    }

    // MARK: - methods

    @objc
    private func tapAdd() {
        delegate?.tapAddButton()
    }

    func setTitle(_ title: String, isHiddenAddButton: Bool) {
        self.titleLabel.text = title
        addButton.isHidden = isHiddenAddButton
    }

    private func configureConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(makeSize(eightLow: 16, tenUp: 16))
        }

        addButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().inset(makeSize(eightLow: 16, tenUp: 16))
            make.width.equalTo(makeSize(eightLow: 200, tenUp: 200))
            make.height.equalTo(makeSize(eightLow: 44, tenUp: 44))
        }
    }
}
