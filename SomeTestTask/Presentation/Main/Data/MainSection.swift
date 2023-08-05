import Foundation
import UIKit

class MainSection: Hashable {

    var id: UUID = UUID()
    var title: String
    var items: [CellModel]

    init(title: String, items: [CellModel]) {
        self.title = title
        self.items = items
    }
}

extension MainSection {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    static func == (lhs: MainSection, rhs: MainSection) -> Bool {
        lhs.id == rhs.id
    }
}

extension MainSection {

    static func allSections() -> [MainSection] {
        return [
            .init(title: "Персональные данные", items: [CellModel(name: "", age: "")]),
            .init(title: "Дети (макс. 5)", items: [])
        ]
    }
}
