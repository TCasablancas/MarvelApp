//
//  CatalogCoordinator.swift
//  MarvelApp
//
//  Created by Thyago on 31/03/20.
//  Copyright © 2020 tcasablancas. All rights reserved.
//

import UIKit

class CatalogCoordinator: NavigationCoordinator {
    
    private lazy var listBuilder: ListBuilder = {
        return ListBuilder(router: self)
    }()
  
    func start() {
        viewController.setViewControllers([listBuilder.build()], animated: true)
    }
    
}

extension CatalogCoordinator: ListRouter {
    
    func detail(for character: Character) {
        viewController.pushViewController(CharacterBuilder(router: self, character: character).build(), animated: true)
    }
    
    func showOptions(_ options: [CharacterOption], for character: Character, onSelectedOption: @escaping ((CharacterOption) -> Void)) {
        
        presentAlertController { () -> UIAlertController in
            
            let alertController = UIAlertController(
                title: "\(character.name ?? "No name")",
                message: "This are the options for this character",
                preferredStyle: UIAlertController.Style.actionSheet
            )
            
            options.forEach { (option) in
                alertController.addAction(UIAlertAction(title: option.title, style: UIAlertAction.Style.default, handler: { (action) in
                    onSelectedOption(option)
                }))
            }
            
            alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            return alertController
        }
    }
    
    func showAlert(with title: String, message: String, retry: (()->Void)?, onDismiss: (()->Void)?) {
        presentAlertController { () -> UIAlertController in
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { _ in
                onDismiss?()
            }))
            
            if let retry = retry {
                alertController.addAction(UIAlertAction(title: "Try again", style: .default, handler: { _ in
                    retry()
                }))
            }
            
            return alertController
        }
    }
}

extension CatalogCoordinator: CharacterRouter {
    
    
}
