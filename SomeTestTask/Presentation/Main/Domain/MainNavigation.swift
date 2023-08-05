import UIKit

protocol MainNavigator {
    func dismiss()
}

final class MainNavigation {

    private var baseViewController: UIViewController?

    init(viewController: UIViewController) {
        baseViewController = viewController
    }
}

extension MainNavigation: MainNavigator {

    func dismiss() {
        if baseViewController?.navigationController != nil {
            baseViewController?.navigationController?.popViewController(animated: true)
        } else {
            baseViewController?.dismiss(animated: true)
        }
    }
}
