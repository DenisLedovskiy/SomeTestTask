import Foundation
import UIKit

protocol TopMainCollectionCellDelegate: AnyObject {
    func editNameProfile(_ text: String)
    func editAgeProfile(_ text: String)
}

class TopMainCollectionCell: PUICollectionViewCell {

    // MARK: - properties
    weak var delegate: TopMainCollectionCellDelegate?
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

    // MARK: - overrides

    override class var size: CGSize {
        let width = UIScreen.main.bounds.width
        return CGSize(
            width: width,
            height: 136
        )
    }

    override func setup() {
        backgroundColor = .clear

        // MARK: - Add Subviews

        addSubview(nameTextField)
        addSubview(ageTextField)

        // MARK: - Add Constraints
        setupConstraintsForNameTextField()
        setupConstraintsForAgeTextField()
    }

    // MARK: - methods

    func configureCell(_ data: CellModel) {
        nameTextField.text = data.name
        ageTextField.text = data.age
    }

    @objc
    private func editName() {
        delegate?.editNameProfile(nameTextField.text ?? "")
    }

    @objc
    private func editAge() {
        delegate?.editAgeProfile(ageTextField.text ?? "")
    }
}

// MARK: - constraits extensions

extension TopMainCollectionCell {

    private func setupConstraintsForNameTextField() {
        nameTextField.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview().offset(makeSize(eightLow: 16, tenUp: 16))
            make.right.equalToSuperview().inset(makeSize(eightLow: 16, tenUp: 16))
        }
    }

    private func setupConstraintsForAgeTextField() {
        ageTextField.snp.makeConstraints { make in
            make.top.equalTo(nameTextField.snp.bottom).offset(makeSize(eightLow: 10, tenUp: 10))
            make.left.equalToSuperview().offset(makeSize(eightLow: 16, tenUp: 16))
            make.right.equalToSuperview().inset(makeSize(eightLow: 16, tenUp: 16))
        }
    }
}

// MARK: - textfield delegate

extension TopMainCollectionCell: UITextFieldDelegate {

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

