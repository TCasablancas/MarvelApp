//
//  ViewConfiguration.swift
//  MarvelApp
//
//  Created by Thyago on 31/03/20.
//  Copyright © 2020 tcasablancas. All rights reserved.
//

import Foundation

protocol ViewConfiguration: class {
    func setupConstraints()
    func buildViewHierarchy()
    func configureViews()
}
