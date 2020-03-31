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
    @IBOutlet weak var actionButton: UIButton!
    
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
        self.action?()
    }
    
}

extension ErrorViewController: ViewConfigurable {
    
    typealias viewModel = ErrorViewModel
    
    func configure(with viewModel: ErrorViewModel?) {
        self.titleLabel.text = viewModel?.message
        self.actionButton.setTitle(viewModel?.actionTitle, for: .normal)
        self.actionButton.isHidden = (viewModel?.actionTitle == nil)
        self.action = viewModel?.action
    }
}
