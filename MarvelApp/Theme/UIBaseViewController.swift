//
//  UIBaseViewController.swift
//  MarvelApp
//
//  Created by Thyago on 17/04/20.
//  Copyright © 2020 tcasablancas. All rights reserved.
//

import UIKit

class UIBaseViewController: UIViewController {
    
    
    @IBAction func dismissPage(_ sender: Any) {
        //self.view.endEditing(true)
        self.dismiss(animated: true, completion: nil)
    }
}
