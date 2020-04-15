//
//  ViewConfigurable.swift
//  MarvelApp
//
//  Created by Thyago on 31/03/20.
//  Copyright © 2020 tcasablancas. All rights reserved.
//

import UIKit

protocol ViewConfigurable {
    
    associatedtype ViewModel
    
    func configure(with viewModel: ViewModel?)
}
