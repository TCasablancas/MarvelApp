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
        static let softGray     = UIColor(hexString: Constants.Colors.Hex.softGray)
        static let secondRed    = UIColor(hexString: Constants.Colors.Hex.secondRed)
        static let secondBlue   = UIColor(hexString: Constants.Colors.Hex.secondBlue)
        static let secondGreen  = UIColor(hexString: Constants.Colors.Hex.secondGreen)
    
        // MARK:- Background View
        static func viewBackground(_ viewController: UIViewController) {
            viewController.view.backgroundColor = Theme.default.softGray
        }
        
        // MARK:- Texts
        static func labelBlackBg(_ label: UILabel) {
            label.textColor = Theme.default.white
            label.font = UIFont(name: Font.avenirBlack.rawValue, size: 16)
            label.adjustsFontForContentSizeCategory = true
        }
        
        static func labelWhiteBg(_ label: UILabel) {
            label.textColor = Theme.default.mainBlack
            label.font = UIFont(name: Font.avenirBlack.rawValue, size: 16)
            label.adjustsFontForContentSizeCategory = true
        }
        
        static func nameCharacter(_ label: UILabel) {
            label.textColor = Theme.default.mainBlue
            label.font = UIFont(name: Font.avenirBlack.rawValue, size: 20)
            label.adjustsFontForContentSizeCategory = true
        }
        
        static func descriptionCharacter(_ label: UILabel) {
            label.textColor = Theme.default.mainBlack
            label.font = UIFont(name: Font.avenirLight.rawValue, size: 16)
            label.textAlignment = .justified
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
        
        static func characterLabel(_ view: UIView) {
            view.backgroundColor = Theme.default.white
            view.layer.opacity = 0.9
            view.layer.cornerRadius = 8
        }
    }
}
