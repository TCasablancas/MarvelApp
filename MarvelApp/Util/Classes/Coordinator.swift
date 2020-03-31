//
//  Coordinator.swift
//  MarvelApp
//
//  Created by Thyago on 30/03/20.
//  Copyright © 2020 tcasablancas. All rights reserved.
//

import UIKit

class Coordinator: Coordinatable {
    var childCoordinators = [Coordinatable]()
    var viewController = UIViewController()
}

extension Coordinatable where Self: Coordinator {
    
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

