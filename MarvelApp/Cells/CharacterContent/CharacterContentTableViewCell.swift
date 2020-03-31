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
    
    typealias viewModel = CharacterContentTableViewCellDTO
    
    func configure(with viewModel: CharacterContentTableViewCellDTO?) {
        self.titleLabel.text = viewModel?.title
        
        if let url = viewModel?.imageURL {
            self.contentImageView.loadImage(from: url)
        }
    }
}
