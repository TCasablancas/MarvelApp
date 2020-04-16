//
//  SceneDelegate.swift
//  MarvelApp
//
//  Created by Thyago on 30/03/20.
//  Copyright © 2020 tcasablancas. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    //private let appCoordinator = AppCoordinator()
    //private let catalogCoordinator = CatalogCoordinator()
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        let rootViewController = ViewController()
        
        let navigationBar = UINavigationBar.appearance()
        let searchController = UISearchController(searchResultsController: nil)
        let searchBar = searchController.searchBar
        let navigationItem = UINavigationItem()
        
        let attrs = [
            NSAttributedString.Key.foregroundColor: Theme.default.mainBlack,
            NSAttributedString.Key.font: UIFont.init(name: Font.avenirBlack.rawValue, size: 28),
            NSAttributedString.Key.kern: 0
        ] as [ NSAttributedString.Key : Any ]
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        
        searchController.searchBar.placeholder = "buscar"
        searchController.searchBar.tintColor = Theme.default.black
        
        navigationBar.largeTitleTextAttributes = attrs
        navigationBar.prefersLargeTitles = false
        navigationBar.barTintColor = Theme.default.mainBlack
        navigationBar.tintColor = .white
        navigationBar.isTranslucent = false
        
        searchBar.backgroundColor = .red
        searchBar.tintColor = .white
//
//        window = UIWindow(frame: UIScreen.main.bounds)
//        window?.backgroundColor = .white
//        window?.rootViewController = rootViewController
//        window?.makeKeyAndVisible()
        
        
        guard let _ = (scene as? UIWindowScene) else { return }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        
    }

    func sceneWillResignActive(_ scene: UIScene) {
        
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        
    }


}

