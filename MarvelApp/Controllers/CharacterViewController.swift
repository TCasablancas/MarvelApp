//
//  CharacterViewController.swift
//  MarvelApp
//
//  Created by Thyago on 15/04/20.
//  Copyright © 2020 tcasablancas. All rights reserved.
//

import UIKit

class CharacterViewController: UIBaseViewController {
    
    @IBOutlet weak var imageContainer: UIView!
    @IBOutlet weak var imageCharacter: UIImageView!
    @IBOutlet weak var nameContainer: UIView!
    @IBOutlet weak var nameCharacter: UILabel!
    @IBOutlet weak var descCharacter: UILabel!
    @IBOutlet weak var titleHq: UILabel!
    @IBOutlet weak var titleTv: UILabel!
    
    var selectedCharacter: Character?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.characterData()
        self.setupLayout()
        self.logoHeader()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        dismiss(animated: true, completion: nil)
    }
    
//    override func updateViewConstraints() {
//        self.setupLayout()
//    }
}

extension CharacterViewController {
    
    @IBAction func cancel(_ unwindsegue: UIStoryboardSegue) {
        //self.dismiss(animated: true, completion: nil)
        self.navigationController!.popViewController(animated: true)
        //let main = ViewController()
        //self.navigationController?.popToViewController(main, animated: true)
    }
    
    func characterData() {
        if let character = selectedCharacter {
            self.nameCharacter.text = character.name
            self.descCharacter.text = character.description
            if let url = URL(string: character.thumbnail.imagePath()) {
                self.imageCharacter.kf.indicatorType = .activity
                self.imageCharacter.kf.setImage(with: url)
            } else {
                self.imageCharacter.image = UIImage(named: "no-thumb")
            }
        }
    }
    
    func setupLayout() {
        Theme.default.viewBackground(self)
        Theme.default.characterLabel(self.nameContainer)
        Theme.default.mainThumbs(self.imageCharacter)
        Theme.default.nameCharacter(self.nameCharacter)
        Theme.default.descriptionCharacter(self.descCharacter)
        Theme.default.nameCharacter(self.titleHq)
        Theme.default.nameCharacter(self.titleTv)
        
        self.nameCharacter.textColor = Theme.default.mainRed
    }
    
    func logoHeader() {
        let logo = UIImage(named: "logo.png")
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 38, height: 28))
        imageView.image = logo
        imageView.contentMode = .scaleAspectFit
        self.navigationItem.titleView = imageView
        
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.layoutIfNeeded()
    }
}
