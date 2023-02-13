//
//  AppDelegate.swift
//  MoviX
//
//  Created by Muhammad Ewaily on 12/02/2023.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setIntialViewController()
        return true
    }
}

extension AppDelegate {
    private func setIntialViewController() {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let viewController = MoviesListViewController()
        let presenter = MoviesListPresenter(delegate: viewController)
        viewController.presenter = presenter
        let navigationController = UINavigationController(rootViewController: viewController)
        self.window?.rootViewController = navigationController
        self.window?.makeKeyAndVisible()
    }
}
