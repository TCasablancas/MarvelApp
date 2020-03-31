//
//  ListCollectionViewCell.swift
//  MarvelApp
//
//  Created by Thyago on 31/03/20.
//  Copyright © 2020 tcasablancas. All rights reserved.
//

import UIKit
import PureLayout

protocol ListCollectionViewCellDelegate: class {
    func longPressCell(at indexPath: IndexPath)
}

class ListCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var itemImageView: NetworkImageLoader!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var gradientView: UIView!
    
    private var favorited: Bool = false
    private var gradientLayer: CAGradientLayer = CAGradientLayer()
    weak var delegate: ListCollectionViewCellDelegate?
    var indexPath: IndexPath? = nil
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView.newAutoLayout()
        indicator.style = UIActivityIndicatorView.Style.large
        return indicator
    }()
    
    private lazy var longPressGesture: UILongPressGestureRecognizer = {
        let gesture = UILongPressGestureRecognizer(target: self, action: #selector(didLongPressCell))
        gesture.minimumPressDuration = 0.5
        gesture.cancelsTouchesInView = true
        return gesture
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupAccessibilityIdentifiers()
        self.gradientView.addGestureRecognizer(longPressGesture)
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        self.setupGradient()
        self.setupCellLayout()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func configure(with dto: ListCollectionViewCellDTO?) {
        favorited = dto?.favorited ?? false
        titleLabel.text = dto?.title
        
        guard let url = dto?.imageUrl else {
            return
        }
        
        self.setupActivityIndicator()
        
        self.itemImageView.loadImage(from: url) { _ in
            DispatchQueue.main.async {
                self.removeActivityIndicator()
            }
        }
    }
}

private extension ListCollectionViewCell {
    
    private func setupAccessibilityIdentifiers() {
        accessibilityIdentifier = "catalog_item_cell"
        itemImageView.accessibilityIdentifier = "catalog_item_cell_image_view"
        titleLabel.accessibilityIdentifier = "catalog_item_cell_title_label"
    }
    
    private func setupGradient() {
        gradientLayer.frame = gradientView.bounds
        gradientLayer.colors = [UIColor(white: 1.0, alpha: 0), UIColor.black.cgColor, UIColor.black.cgColor]
        gradientLayer.locations = [0.0, 0.9, 1.0]
        gradientView.layer.addSublayer(gradientLayer)
    }
    
    private func setupCellLayout() {
        self.clipsToBounds = true
        self.layer.cornerRadius = 8.0
        self.layer.backgroundColor = UIColor.clear.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 4.0)
        self.layer.shadowRadius = 8.0
        self.layer.shadowOpacity = 0.4
        self.layer.masksToBounds = false
        self.layer.borderColor = favorited ? UIColor.yellow.cgColor : UIColor.clear.cgColor
        self.layer.borderWidth = favorited ? 8.0 : 0.0
        
        self.contentView.clipsToBounds = true
        self.contentView.layer.cornerRadius = 8.0
        self.contentView.layer.masksToBounds = true
    }
    
    @objc func didLongPressCell() {
        if (longPressGesture.state != UIGestureRecognizer.State.began) {
            return
        }
        if let indexPath = indexPath {
            delegate?.longPressCell(at: indexPath)
        }
    }
    
    private func setupActivityIndicator() {
        addSubview(activityIndicator)
        bringSubviewToFront(activityIndicator)
        
        self.activityIndicator.autoCenterInSuperview()
        self.activityIndicator.autoSetDimensions(to: CGSize(width: 22.0, height: 22.0))
        self.activityIndicator.startAnimating()
    }
    
    private func removeActivityIndicator() {
        self.activityIndicator.stopAnimating()
        self.activityIndicator.removeFromSuperview()
    }
}
