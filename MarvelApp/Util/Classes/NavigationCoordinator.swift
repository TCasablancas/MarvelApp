//
//  NavigationCoordinator.swift
//  MarvelApp
//
//  Created by Thyago on 31/03/20.
//  Copyright © 2020 tcasablancas. All rights reserved.
//

import UIKit

class NavigationCoordinator: Coordinatable {
    var childCoordinators = [Coordinatable]()
    var viewController = UINavigationController()
}

extension NavigationCoordinator: AlertControllerPresentable {}

extension Coordinatable where Self: NavigationCoordinator {
    
    var rootViewController: UIViewController {
        return viewController
    }
    
    func start() {
        fatalError("Implement in child")
    }
    
    func stop() {
        fatalError("Implement in child")
    }
}
