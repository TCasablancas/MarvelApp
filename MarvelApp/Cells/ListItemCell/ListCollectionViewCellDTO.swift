//
//  ListCollectionViewCellDTO.swift
//  MarvelApp
//
//  Created by Thyago on 31/03/20.
//  Copyright © 2020 tcasablancas. All rights reserved.
//

import Foundation

struct ListCollectionViewCellDTO {
    let title: String?
    let imageUrl: URL?
    let favorited: Bool
}

extension ListCollectionViewCellDTO {
    init(character: Character, favorited: Bool) {
        self.title = character.name
        self.imageUrl = character.thumbnail?.url
        self.favorited = favorited
    }
}
