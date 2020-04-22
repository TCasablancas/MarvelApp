//
//  CharactersTableViewCell.swift
//  MarvelApp
//
//  Created by Thyago on 15/04/20.
//  Copyright © 2020 tcasablancas. All rights reserved.
//

import UIKit
import Kingfisher

class CharactersTableViewCell: UITableViewCell {

    @IBOutlet weak var mainContainer: UIView!
    @IBOutlet weak var titleContainer: UIView!
    @IBOutlet weak var mainThumb: UIImageView!
    @IBOutlet weak var mainTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureCell(with character: Character) {
        self.mainTitle.text = character.name
        
        self.mainThumb.image = UIImage(named: "\(character.thumbnail)")
        
        if let url = URL(string: character.thumbnail.imagePath()){
            self.mainThumb.kf.indicatorType = .activity
            self.mainThumb.kf.setImage(with: url)
        } else {
            self.mainThumb.image = UIImage(named: "no-thumb")
        }
    
        Theme.default.characterMainContainer(self.mainContainer)
        Theme.default.mainThumbs(self.mainThumb)
        Theme.default.labelBlackContainer(self.titleContainer)
        Theme.default.labelBlackBg(self.mainTitle)
    }
    
}
