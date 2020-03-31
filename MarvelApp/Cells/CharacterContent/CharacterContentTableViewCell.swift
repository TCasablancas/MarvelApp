//
//  CharacterContentTableViewCell.swift
//  MarvelApp
//
//  Created by Thyago on 31/03/20.
//  Copyright © 2020 tcasablancas. All rights reserved.
//

import UIKit

class CharacterContentTableViewCell: UITableViewCell {
    @IBOutlet weak var contentImageView: NetworkImageLoader!
    @IBOutlet weak var titleLabel: UILabel!
}

extension CharacterContentTableViewCell: ViewConfigurable {
    
    typealias ViewModel = CharacterContentTableViewCellDTO
    
    func configure(with viewModel: CharacterContentTableViewCellDTO?) {
        titleLabel.text = viewModel?.title
        if let url = viewModel?.imageURL {
           contentImageView.loadImage(from: url)
        }
    }
}
