import Foundation

struct CellModel {
    var id = UUID()
    var name: String
    var age: String
}

extension CellModel: Hashable {
    func hash(into hasher: inout Hasher) {
      hasher.combine(id)
    }

    static func == (lhs: CellModel, rhs: CellModel) -> Bool {
      lhs.id == rhs.id
    }
}
