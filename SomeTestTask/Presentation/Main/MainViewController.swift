import UIKit

protocol MainViewInput: AnyObject {
    func showActionSheet()
}

class MainViewController: UIViewController {

    // MARK: - properties

    private var presenter: MainPresenter!
    private lazy var dataSource = MainDataSource(collectionView: contentView.collectionView)

    // MARK: - Dependency Injection

    func bind(presenter: MainPresenter) {
        self.presenter = presenter
    }

    // MARK: - views

    private var contentView = MainView()

    // MARK: - lifecycle

    override func loadView() {
        super.loadView()
        view = contentView
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        contentView.delegate = self
        dataSource.delegate = self
        dataSource.applySnapshot()
        presenter.screenDidReady()
    }

    // MARK: - methods

    func setupTargets() {
        
    }
}

extension MainViewController: MainViewInput {
    func showActionSheet() {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Сбросить данные", style: .destructive , handler:{ (UIAlertAction)in
            self.dataSource.clearAll()
        }))
        alert.addAction(UIAlertAction(title: "Отмена", style: .default))
        self.present(alert, animated: true)
    }
}

extension MainViewController: MainViewDelegate {
 
}

extension MainViewController: MainDataSourceDelegate {
    func tapCancelButton() {
        presenter.selectCancelButton()
    }
}
