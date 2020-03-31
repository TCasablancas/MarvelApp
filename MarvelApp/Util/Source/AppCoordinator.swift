//
//  AppCoordinator.swift
//  MarvelApp
//
//  Created by Thyago on 30/03/20.
//  Copyright © 2020 tcasablancas. All rights reserved.
//

import Foundation

class AppCoordinator: Coordinator {
    private lazy var catalogCoordinator: CatalogCoordinator = {
        let coordinator = CatalogCoordinator()
        return coordinator
    }()
    
    override init() {
        super.init()
        super.viewController = catalogCoordinator.rootViewController
    }
    
    func start() {
        catalogCoordinator.start()
    }
    
    func stop() {
        
    }
}
