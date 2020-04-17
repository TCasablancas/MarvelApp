//
//  Theme.swift
//  MarvelApp
//
//  Created by Thyago on 14/04/20.
//  Copyright © 2020 tcasablancas. All rights reserved.
//

import UIKit

class Theme {
    struct `default` {
        // MARK:- Colors
        static let white        = UIColor(hexString: Constants.Colors.Hex.white)
        static let black        = UIColor(hexString: Constants.Colors.Hex.black)
        static let mainBlack    = UIColor(hexString: Constants.Colors.Hex.mainBlack)
        static let mainRed      = UIColor(hexString: Constants.Colors.Hex.mainRed)
        static let mainBlue     = UIColor(hexString: Constants.Colors.Hex.mainBlue)
        static let mainGreen    = UIColor(hexString: Constants.Colors.Hex.mainGreen)
        
        static let gray         = UIColor(hexString: Constants.Colors.Hex.gray)
        static let secondRed    = UIColor(hexString: Constants.Colors.Hex.secondRed)
        static let secondBlue   = UIColor(hexString: Constants.Colors.Hex.secondBlue)
        static let secondGreen  = UIColor(hexString: Constants.Colors.Hex.secondGreen)
    
        // MARK:- Texts
        static func labelBlackBg(_ label: UILabel) {
            label.textColor = Theme.default.white
            label.font = UIFont(name: Font.avenirBlack.rawValue, size: 16)
            label.adjustsFontForContentSizeCategory = true
        }
        
        // MARK:= Containers
        static func characterMainContainer(_ view: UIView) {
            view.backgroundColor = Theme.default.mainBlue
            view.layer.cornerRadius = 8
        }
        
        static func mainThumbs(_ imageView: UIImageView) {
            imageView.layer.cornerRadius = 8
            imageView.contentMode = .scaleAspectFill
        }
        
        static func labelBlackContainer(_ view: UIView) {
            view.backgroundColor = Theme.default.mainBlack
            view.layer.cornerRadius = 6
        }
    }
}
