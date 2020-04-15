//
//  ListItemCollectionViewCell.swift
//  MarvelApp
//
//  Created by Thyago on 14/04/20.
//  Copyright © 2020 tcasablancas. All rights reserved.
//

import UIKit
import Kingfisher

class ListItemCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var viewMain: UIView!
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var lbTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    var item: Character! {
        didSet {
            self.lbTitle.text = item.name
            if let url = URL(string: item.thumb.getUrl()) {
                self.mainImage.kf.indicatorType = .activity
                self.mainImage.kf.setImage(with: url)
            } else {
                self.mainImage.image = UIImage(named: "no-pic")
            }
            
            self.mainImage.layer.cornerRadius = mainImage.frame.size.height / 2
            self.mainImage.layer.borderColor = UIColor(hexString: "#545263").cgColor
        }
    }

}
