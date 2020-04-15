//
//  ListLogic.swift
//  MarvelApp
//
//  Created by Thyago on 31/03/20.
//  Copyright © 2020 tcasablancas. All rights reserved.
//

import Foundation
import UITestHelper

protocol ListRouter: class {
    func detail(for character: Character)
    func showOptions(_ options: [CharacterOption], for character: Character, onSelectedOption: @escaping ((CharacterOption) -> Void))
    func showAlert(with title: String, message: String, retry: (()->Void)?, onDismiss: (()->Void)?)
}

protocol ListServable: class {
    func character(_ name: String?, page: Int, completion: @escaping CharacterDataWrapperCompletionResult)
    func isFavorited(_ character: Character) -> Bool
    func favorite(_ character: Character) -> Bool
    func unfavorite(_ character: Character) -> Bool
}

extension MarvelService: ListServable {}
class ListLogic {
    
    private weak var router: ListRouter?
    private let service: ListServable
    
    init(service: ListServable, router: ListRouter?) {
        self.service = service
        self.router = router
    }
    
    convenience init(router: ListRouter?) {
        if isLaunchedWith(LaunchArguments.mockNetworkResponses) {
            self.init(service: MarvelMockService.shared, router: router)
        } else {
            self.init(service: MarvelAPI.shared.characterService, router: router)
        }
    }
    
    func character(with name: String?, at page: Int, completion: @escaping CharacterDataWrapperCompletionResult) {
        service.character(name, page: page, completion: completion)
    }
    
    func showDetail(of character: Character) {
        router?.detail(for: character)
    }

    func showOptionsFor(character: Character, completion: @escaping CharacterOptionsCompletionResult) {
        
        guard let router = router else {
            completion(.failure(NSError(domain: "", code: 001, userInfo: ["message": "Can't show options"])))
            return
        }
        
        let options = CharacterOption.allCases.filter { (option) -> Bool in
            switch option {
            case .favorite:
                return !self.service.isFavorited(character)
            case .unfavorite:
                return self.service.isFavorited(character)
            }
        }
        
        router.showOptions(options, for: character) { (option) in
            completion(.success(option))
        }
    }
    
    func showAlert(with title: String, message: String, retry: (()->Void)?, onDismiss: (()->Void)?) {
        router?.showAlert(with: title, message: message, retry: retry, onDismiss: onDismiss)
    }
    
    func showError(error: NSError, retry: (()->Void)?, onDismiss: (()->Void)?) {
        showAlert(with: "Error", message: error.localizedDescription, retry: retry, onDismiss: onDismiss)
    }
    
}

extension ListLogic {
    
    func isFavorite(character: Character) -> Bool {
        return service.isFavorited(character)
    }
    
    func favorite(_ character: Character, completion: @escaping BooleanCompletionResult) {
        completion(.success(self.service.favorite(character)))
    }
    
    func unfavorite(_ character: Character, completion: @escaping BooleanCompletionResult) {
        completion(.success(self.service.unfavorite(character)))
    }
    
}
