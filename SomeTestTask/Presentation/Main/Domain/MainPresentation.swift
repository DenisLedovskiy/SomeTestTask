import Foundation

protocol MainPresenter {
    func screenDidReady()
    func selectCancelButton()
}

final class MainPresentation {

    private weak var view: MainViewInput?
    private let navigator: MainNavigator?
    private let interactor: MainInteractor?
    private let service = MainService.shared

    init(viewInput: MainViewInput, navigator: MainNavigator, interactor: MainInteractor) {
        view = viewInput
        self.navigator = navigator
        self.interactor = interactor
    }
}

extension MainPresentation {

}


extension MainPresentation: MainPresenter {
    func selectCancelButton() {
        view?.showActionSheet()
    }

    func screenDidReady() {
        interactor?.screenDidReady()
    }
}
