//
//  CharacterBuilder.swift
//  MarvelApp
//
//  Created by Thyago on 31/03/20.
//  Copyright © 2020 tcasablancas. All rights reserved.
//

import Foundation

class CharacterBuilder {
    
    private weak var router: CharacterRouter?
    
    var character: Character
    
    init(router: CharacterRouter, character: Character) {
        self.router = router
        self.character = character
    }
    
    func build() -> CharacterViewController {
        let logic = CharacterLogic(router: router)
        let viewModel = CharacterViewModel(logic: logic, character: character)
        return CharacterViewController(viewModel: viewModel)
    }
    
}
