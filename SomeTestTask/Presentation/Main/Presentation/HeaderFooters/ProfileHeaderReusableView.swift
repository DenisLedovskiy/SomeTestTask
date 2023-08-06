import UIKit
import SnapKit

class ProfileHeaderReusableView: PCollectionReusableView {

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = Design.Font.h1
        label.textColor = Design.Color.black
        return label
    }()

    // MARK: - overrides
    override func setup() {

        // MARK: - Add Subviews
        addSubview(titleLabel)

        // MARK: - Add Constraints
        configureConstraints()
    }

    func setTitle(_ title: String) {
        self.titleLabel.text = title
    }

    private func configureConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.size.equalToSuperview()
            make.left.equalToSuperview().offset(makeSize(eightLow: 16, tenUp: 16))
        }
    }
}
