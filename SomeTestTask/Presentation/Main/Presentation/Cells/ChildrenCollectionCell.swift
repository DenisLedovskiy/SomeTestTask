import Foundation
import UIKit

protocol ChildrenCollectionCellDelegate: AnyObject {
    func tapDeleteButton(_ id: UUID)
    func editName(_ text: String, id: UUID)
    func editAge(_ text: String, id: UUID)
}

class ChildrenCollectionCell: PUICollectionViewCell {

    // MARK: - properties

    weak var delegate: ChildrenCollectionCellDelegate?
    private var idModel = UUID()

    private let minValue = 1
    private let maxValue = 150
    private lazy var valuesRange = minValue...maxValue

    // MARK: - views

    private lazy var nameTextField: CustomTextField = {
        let textField = CustomTextField()
        textField.configure(title: "Имя")
        textField.keyboardType = .default
        textField.autocapitalizationType = .sentences
        textField.spellCheckingType = .no
        textField.autocorrectionType = .no
        textField.addTarget(self, action: #selector(editName), for: .editingChanged)
        return textField
    }()

    private lazy var ageTextField: CustomTextField = {
        let textField = CustomTextField()
        textField.configure(title: "Возраст")
        textField.keyboardType = .numberPad
        textField.addTarget(self, action: #selector(editAge), for: .editingChanged)
        textField.delegate = self
        return textField
    }()

    lazy var deleteButton: UIButton = {
        let button = UIButton()
        let attributedString = NSAttributedString(string: "Удалить",
                                                        attributes: [NSAttributedString.Key.foregroundColor : Design.Color.blue,
                                                                     NSAttributedString.Key.font : Design.Font.button1])
        button.setAttributedTitle(attributedString, for: .normal)
        button.addTarget(self, action: #selector(tapDelete), for: .touchUpInside)
        return button
    }()

    private lazy var lineView: UIView = {
        let view = UIView()
        view.backgroundColor = Design.Color.grayLight
        return view
    }()

    // MARK: - overrides

    override class var size: CGSize {
        let width = UIScreen.main.bounds.width
        if UIScreen.main.bounds.height < 850 {
            return CGSize(
                width: width,
                height: 148
            )
        } else {
            return CGSize(
                width: width,
                height: 162
            )
        }
    }

    override func setup() {
        backgroundColor = Design.Color.white

        // MARK: - Add Subviews

        addSubview(nameTextField)
        addSubview(ageTextField)
        addSubview(deleteButton)
        addSubview(lineView)

        // MARK: - Add Constraints
        setupConstraintsForNameTextField()
        setupConstraintsForAgeTextField()
        setupConstraintsForDeleteButton()
        setupConstraintsForLineView()
    }

    // MARK: - methods

    @objc
    private func tapDelete() {
        delegate?.tapDeleteButton(idModel)
    }

    @objc
    private func editName() {
        delegate?.editName(nameTextField.text ?? "", id: idModel)
    }

    @objc
    private func editAge() {
        delegate?.editAge(ageTextField.text ?? "", id: idModel)
    }

    func configureCell(_ data: CellModel) {
        nameTextField.text = data.name
        ageTextField.text = data.age
        idModel = data.id
    }
}

// MARK: - constraits extensions

extension ChildrenCollectionCell {

    private func setupConstraintsForNameTextField() {
        nameTextField.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview().offset(makeSize(eightLow: 16, tenUp: 16))
            make.width.equalTo(makeSize(eightLow: ((UIScreen.main.bounds.width - 32) * 0.5),
                                        tenUp: ((UIScreen.main.bounds.width - 32) * 0.5)))
        }
    }

    private func setupConstraintsForAgeTextField() {
        ageTextField.snp.makeConstraints { make in
            make.top.equalTo(nameTextField.snp.bottom).offset(makeSize(eightLow: 10, tenUp: 10))
            make.left.equalToSuperview().offset(makeSize(eightLow: 16, tenUp: 16))
            make.width.equalTo(makeSize(eightLow: ((UIScreen.main.bounds.width - 32) * 0.5),
                                        tenUp: ((UIScreen.main.bounds.width - 32) * 0.5)))
        }
    }

    private func setupConstraintsForDeleteButton() {
        deleteButton.snp.makeConstraints { make in
            make.centerY.equalTo(nameTextField.snp.centerY)
            make.left.equalTo(nameTextField.snp.right).offset(makeSize(eightLow: 20, tenUp: 20))
            make.height.equalTo(makeSize(eightLow: 44, tenUp: 44))
            make.width.equalTo(makeSize(eightLow: 90, tenUp: 90))
        }
    }

    private func setupConstraintsForLineView() {
        lineView.snp.makeConstraints { make in
            make.top.equalTo(ageTextField.snp.bottom).offset(makeSize(eightLow: 10, tenUp: 10))
            make.left.equalToSuperview().offset(makeSize(eightLow: 16, tenUp: 16))
            make.height.equalTo(makeSize(eightLow: 2, tenUp: 2))
            make.right.equalToSuperview().inset(makeSize(eightLow: 16, tenUp: 16))
        }
    }
}

// MARK: - textfield delegate

extension ChildrenCollectionCell: UITextFieldDelegate {

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == ageTextField {
            let newText = NSString(string: textField.text!).replacingCharacters(in: range, with: string)
            if newText.isEmpty {
                return true
            }
            return valuesRange.contains(Int(newText) ?? minValue - 1)
        }
        return true
    }
}
