//
//  CharacterBuilder.swift
//  MarvelApp
//
//  Created by Thyago on 31/03/20.
//  Copyright © 2020 tcasablancas. All rights reserved.
//

import Foundation

class ListBuilder {
    
    private weak var router: ListRouter?
    
    init(router: ListRouter) {
        self.router = router
    }
    
    func build() -> ListViewController {
        let logic = ListLogic(router: router)
        let viewModel = ListViewModel(logic: logic)
        return ListViewController(viewModel: viewModel)
    }
    
}

