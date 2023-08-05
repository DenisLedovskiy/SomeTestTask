import Foundation

protocol MainInteractor {
    func screenDidReady()
}

final class MainInteraction {}

extension MainInteraction: MainInteractor {
    func screenDidReady() {
        // make request
    }
}
