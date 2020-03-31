//
//  CharacterHeaderTableViewCell.swift
//  MarvelApp
//
//  Created by Thyago on 31/03/20.
//  Copyright © 2020 tcasablancas. All rights reserved.
//

import UIKit

class CharacterHeaderTableViewCell: UITableViewCell {
    
    @IBOutlet weak var headerImageView: NetworkImageLoader!
    @IBOutlet weak var gradientView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    private let gradientLayer: CAGradientLayer = CAGradientLayer()
    private var favorited: Bool =  false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        accessibilityIdentifier = "character_detail_header_cell"
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        self.setupGradient()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
}

extension CharacterHeaderTableViewCell {
    
    typealias viewModel = CharacterHeaderTableViewCellDTO
    
    private func setupGradient() {
        self.gradientLayer.frame = self.gradientView.bounds
        self.gradientLayer.colors = [UIColor(white: 1.0, alpha: 0), UIColor.black.cgColor, UIColor.black.cgColor]
        self.gradientLayer.locations = [0.0, 0.9, 1.0]
        self.gradientLayer.addSublayer(gradientLayer)
    }
    
    func configure(with viewModel: CharacterHeaderTableViewCellDTO?) {
        favorited = viewModel?.favorited ?? false
        self.titleLabel.text = viewModel?.title
        
        if !(viewModel?.description?.isEmpty ?? true) {
            self.descriptionLabel.text = viewModel?.description ?? "Personagem sem descrição"
        } else {
            self.descriptionLabel.text = "Personagem sem descrição"
        }
        
        if let url = viewModel?.imageURL {
            self.headerImageView.loadImage(from: url)
        }
    }
}
