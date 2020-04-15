//
//  Fonts.swift
//  MarvelApp
//
//  Created by Thyago on 14/04/20.
//  Copyright © 2020 tcasablancas. All rights reserved.
//

import UIKit

enum SizeFont {
    
    case size12
    case size18
    case size24
    case size36
    
    var size: CGFloat {
        
        switch self {
        case .size12:
            return CGFloat(12)
        case .size18:
            return CGFloat(18)
        case .size24:
            return CGFloat(24)
        case .size36:
            return CGFloat(36)
        }
    }
}

public enum Font: String{
    
    case avenirBlack    = "AvenirLTStd-Black"
    case avenirBold     = "AvenirLTStd-Heavy"
    case avenirLight    = "AvenirLTStd-Light"
    case avenirMedium   = "AvenirLTStd-Medium"
    
    private func scaledFont(font: UIFont) -> UIFont {
        
        if #available(iOS 11.0, *) {
            return UIFontMetrics.default.scaledFont(for: font)
        } else {
            return font
        }
    }
    
    public func font(_ size: CGFloat = 15.0) -> UIFont
    {
        let value = size * UIScreen.main.bounds.percentFontSize()
        
        switch self {
            
        case .avenirLight:
            return self.scaledFont(font: UIFont.systemFont(ofSize: value, weight: .light))
        case .avenirBold:
            return self.scaledFont(font: UIFont.systemFont(ofSize: value, weight: .bold))
        case .avenirBlack:
            return self.scaledFont(font: UIFont.systemFont(ofSize: value, weight: .black))
        case .avenirMedium:
            return self.scaledFont(font: UIFont.systemFont(ofSize: value, weight: .medium))
        }
    }
}

extension CGRect {
    
    func percentFontSize() -> CGFloat {
        
        switch self.height {
        case 480.0: //Iphone 3,4,SE => 3.5 inch
            return CGFloat(0.7)
        case 568.0: //iphone 5, 5s => 4 inch
            return CGFloat(0.8)
        case 667.0: //iphone 6, 6s => 4.7 inch
            return CGFloat(0.9)
        case 736.0: //iphone 6s+ 6+ => 5.5 inch
            return CGFloat(1.0)
        default:
            return CGFloat(1.0)
        }
        
    }
}
