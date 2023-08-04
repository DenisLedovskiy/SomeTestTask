//
//  AppCoordinator.swift
//  SomeTestTask
//
//  Created by Денис Ледовский on 04.08.2023.
//

import Foundation
import UIKit

class AppCoordinator {

    var window: UIWindow?

    func start() {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.overrideUserInterfaceStyle = .light
        let module = MainViewController()
        window?.rootViewController = module
        window?.makeKeyAndVisible()
    }
}
