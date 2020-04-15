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
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(with character: Character) {
        self.mainTitle.text = character.name
        
        if let url = URL(string: character.thumbnail.getUrl()){
            self.mainThumb.kf.indicatorType = .activity
            self.mainThumb.kf.setImage(with: url)
        } else {
            self.mainThumb.image = UIImage(named: "no-thumb")
        }
        
        self.mainContainer.layer.cornerRadius = 8
        self.titleContainer.layer.cornerRadius = 6
    }
    
}
