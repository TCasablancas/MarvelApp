//
//  ItemDetailTableViewCell.swift
//  MarvelApp
//
//  Created by Thyago on 24/04/20.
//  Copyright © 2020 tcasablancas. All rights reserved.
//

import UIKit

class ItemDetailTableViewCell: UITableViewCell {
    
    @IBOutlet weak var dataContainer: UIView!
    @IBOutlet weak var dataTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureCell(with items: Comics) {
        self.dataTitle.text = items.collectionURI
    
        Theme.default.listItem(self.dataTitle)
        Theme.default.listDetail(self.dataContainer)
    }
}
