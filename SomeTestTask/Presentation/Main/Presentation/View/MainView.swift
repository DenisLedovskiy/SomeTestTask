import UIKit

enum MainViewSection: Int, CaseIterable {
    case profile = 0
    case children = 1
}

protocol MainViewDelegate: AnyObject {

}

class MainView: PView {

    // MARK: - properties

    weak var delegate: MainViewDelegate?

    // MARK: - views

    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: makeLayout())
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.contentInset.top = 20
        ProfileHeaderReusableView.register(collectionView)
        ChildrenHeaderView.register(collectionView)
        ChildrenFooterView.register(collectionView)
        TopMainCollectionCell.register(collectionView)
        ChildrenCollectionCell.register(collectionView)
        return collectionView
    }()

    // MARK: - overrides

    override func setup() {

        backgroundColor = Design.Color.white
        setTapGestureRecognizer()

        // MARK: - Add Subviews
        addSubview(collectionView)

        // MARK: - Add Constraints
        setupConstraintsForMainCollection()
    }

    // MARK: - methods

}

// MARK: - constraits extensions

extension MainView {

    func setupConstraintsForMainCollection() {
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom)
        }
    }
}

//MARK: - Layout CollectionView

extension MainView {
    private func makeLayout() -> UICollectionViewCompositionalLayout {
        let configuration = UICollectionViewCompositionalLayoutConfiguration()

        return UICollectionViewCompositionalLayout(sectionProvider: { section, _ in
            let sectionType = MainViewSection(rawValue: section)
            switch sectionType {
            case .profile:
                let profileSection = self.makeSection(sizeItem: TopMainCollectionCell.size)
                profileSection.boundarySupplementaryItems = [self.makeSectionHeader(heigth: 20)]
                return profileSection
            case .children:
                let childrenSection = self.makeSection(sizeItem: ChildrenCollectionCell.size)
                childrenSection.boundarySupplementaryItems = [self.makeSectionHeader(heigth: 60),
                                                             self.makeSectionFooter()]
                return childrenSection
            default:
                let profileSection = self.makeSection(sizeItem: TopMainCollectionCell.size)
                return profileSection
            }

        }, configuration: configuration)
    }

    func makeSectionHeader(heigth: CGFloat) -> NSCollectionLayoutBoundarySupplementaryItem {
        let headerFooterSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(heigth)
        )
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerFooterSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
        return sectionHeader
    }

    func makeSectionFooter() -> NSCollectionLayoutBoundarySupplementaryItem {
        let headerFooterSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(60)
        )
        let sectionFooter = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerFooterSize,
            elementKind: UICollectionView.elementKindSectionFooter,
            alignment: .bottom
        )
        return sectionFooter
    }

    private func makeSection(sizeItem: CGSize) -> NSCollectionLayoutSection {
        let size = sizeItem

        let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(size.width),
                                              heightDimension: .absolute(size.height))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let group = NSCollectionLayoutGroup.horizontal(layoutSize: itemSize, subitem: item, count: 1)

        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: makeSize(eightLow: 20, tenUp: 20),
                                      leading: makeSize(eightLow: 0, tenUp: 0),
                                      bottom: makeSize(eightLow: 20, tenUp: 20),
                                      trailing: makeSize(eightLow: 0, tenUp: 0))
        section.interGroupSpacing = makeSize(eightLow: 12, tenUp: 12)
        return section
    }
}

extension MainView {
    private func setTapGestureRecognizer() {
        let tapScreen = UITapGestureRecognizer(target: self, action: #selector(tapFunc))
        tapScreen.cancelsTouchesInView = false
        self.addGestureRecognizer(tapScreen)
    }

    @objc
    private func tapFunc() {
        self.endEditing(true)
    }
}
