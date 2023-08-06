import UIKit

final class MainBuilder {

    static func buildMainScreen() -> UIViewController {
        let vc = MainViewController()
        let navigator = MainNavigation(viewController: vc)
        let interaction = MainInteraction()
        let presentation = MainPresentation(viewInput: vc, navigator: navigator, interactor: interaction)
        vc.bind(presenter: presentation)
        return vc
    }
}

