import Foundation

protocol MainInteractor {
    func screenDidReady()
}

final class MainInteraction {
    private let service = MainService.shared
}

extension MainInteraction: MainInteractor {
    func screenDidReady() {
        // make request
    }
}
