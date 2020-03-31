//
//  ErrorViewController.swift
//  MarvelApp
//
//  Created by Thyago on 31/03/20.
//  Copyright © 2020 tcasablancas. All rights reserved.
//

import UIKit

class ErrorViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var actionButtom: UIButton!
    
    private let viewModel: ErrorViewModel? = nil
    private var action: (() -> Void)?
    
    static func with(viewModel: ErrorViewModel) -> ErrorViewController {
        let viewController = ErrorViewController.loadXib(from: nil)
        viewController.configure(with: viewModel)
        return viewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func action(_ sender: Any) {
        action?()
    }
    
}

extension ErrorViewController: ViewConfigurable {

    typealias ViewModel = ErrorViewModel
    
    func configure(with viewModel: ErrorViewModel?) {
        titleLabel.text = viewModel?.message
        actionButtom.setTitle(viewModel?.actionTitle, for: .normal)
        actionButtom.isHidden = (viewModel?.actionTitle == nil)
        action = viewModel?.action
    }
    
}
