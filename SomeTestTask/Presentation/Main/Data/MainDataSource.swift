import Foundation
import UIKit

protocol MainDataSourceDelegate: AnyObject {
    func tapCancelButton()
}

class MainDataSource {

    // MARK: - properties
    private weak var collectionView: UICollectionView?

    weak var delegate: MainDataSourceDelegate?
    var sections: [MainSection] = MainSection.allSections()
    lazy var dataSource = makeDataSource()

    // MARK: - Value Types
    typealias DataSource = UICollectionViewDiffableDataSource<MainSection, CellModel>
    typealias Snapshot = NSDiffableDataSourceSnapshot<MainSection, CellModel>

    // MARK: - Init
    init(collectionView: UICollectionView) {
        self.collectionView = collectionView
    }

    // MARK: - makeDataSource
    private func makeDataSource() -> DataSource {
        guard let collectionView = collectionView else { fatalError() }
        let dataSource = DataSource(
            collectionView: collectionView,
            cellProvider: { (collectionView, indexPath, item) ->
                UICollectionViewCell? in
                let sectionType = MainViewSection(rawValue: indexPath.section)
                switch sectionType {
                case .profile:
                    let cell = TopMainCollectionCell.getCell(collectionView, for: indexPath)
                    cell.configureCell(item)
                    cell.delegate = self
                    return cell
                case .children:
                    let cell = ChildrenCollectionCell.getCell(collectionView, for: indexPath)
                    cell.configureCell(item)
                    cell.tag = indexPath.row
                    cell.delegate = self
                    return cell
                case .none: return UICollectionViewCell()
                }
            })
        return supplementaryViewProvide(for: dataSource)
    }

    func supplementaryViewProvide(for dataSource: DataSource) -> DataSource {
        dataSource.supplementaryViewProvider = { [weak self] (collectionView, kind, indexPath) in
            let sectionType = MainViewSection(rawValue: indexPath.section)
            switch sectionType {
            case .profile:
                guard kind == UICollectionView.elementKindSectionHeader,
                      let self = self else {
                    return UICollectionReusableView()
                }
                let view = ProfileHeaderReusableView.getView(collectionView, for: indexPath)
                let section = self.dataSource.snapshot().sectionIdentifiers[indexPath.section]
                view.setTitle(section.title)
                return view
            case .children:
                guard let self = self else {
                    return UICollectionReusableView()
                }
                switch kind {
                case UICollectionView.elementKindSectionHeader:
                    let view = ChildrenHeaderView.getView(collectionView, for: indexPath)
                    view.delegate = self
                    let section = self.dataSource.snapshot().sectionIdentifiers[indexPath.section]
                    if self.sections[MainViewSection.children.rawValue].items.count < 5 {
                        view.setTitle(section.title, isHiddenAddButton: false)
                    } else {
                        view.setTitle(section.title, isHiddenAddButton: true)
                    }
                    return view
                case UICollectionView.elementKindSectionFooter:
                    let view = ChildrenFooterView.getView(collectionView, for: indexPath)
                    view.delegate = self
                    return view
                default: return nil
                }
            default: return UICollectionReusableView()
            }
        }
        return dataSource
    }
}

// MARK: - Snapshots

extension MainDataSource {
    func applySnapshot(animatingDifferences: Bool = true) {
        var snapshot = Snapshot()
        snapshot.appendSections(sections)
        sections.forEach { section in
            snapshot.appendItems(section.items, toSection: section)
        }
        dataSource.apply(snapshot, animatingDifferences: animatingDifferences)
    }

    func addChildren() {
        sections[1].items.append(CellModel(name: "", age: ""))
        applySnapshot()
    }

    func deleteChildren(id: UUID) {
        sections[MainViewSection.children.rawValue].items.removeAll {$0.id == id}
        applySnapshot()
    }

    func clearAll() {
        sections = MainSection.allSections()
        applySnapshot()
    }
}

// MARK: - Delegats
extension MainDataSource: ChildrenHeaderViewDelegate, ChildrenFooterViewDelegate {
    func tapClearButton() {
        delegate?.tapCancelButton()
    }

    func tapAddButton() {
        if sections[MainViewSection.children.rawValue].items.count == 4 {
            DispatchQueue.main.async { [self] in
                collectionView?.reloadData()
            }
        }
        addChildren()
    }
}

extension MainDataSource: TopMainCollectionCellDelegate, ChildrenCollectionCellDelegate {

    func editNameProfile(_ text: String) {
        sections[MainViewSection.profile.rawValue].items[0].name = text
    }

    func editAgeProfile(_ text: String) {
        sections[MainViewSection.profile.rawValue].items[0].age = text
    }

    func tapDeleteButton(_ id: UUID) {
        if sections[MainViewSection.children.rawValue].items.count == 5 {
            DispatchQueue.main.async { [self] in
                collectionView?.reloadData()
            }
        }
        deleteChildren(id: id)
    }

    func editName(_ text: String, id: UUID) {
        let index = sections[MainViewSection.children.rawValue].items.firstIndex { $0.id == id }
        sections[MainViewSection.children.rawValue].items[index ?? 0].name = text
    }

    func editAge(_ text: String, id: UUID) {
        let index = sections[MainViewSection.children.rawValue].items.firstIndex { $0.id == id }
        sections[MainViewSection.children.rawValue].items[index ?? 0].age = text
    }
}

