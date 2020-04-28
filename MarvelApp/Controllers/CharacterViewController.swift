//
//  CharacterViewController.swift
//  MarvelApp
//
//  Created by Thyago on 15/04/20.
//  Copyright © 2020 tcasablancas. All rights reserved.
//

import UIKit

class CharacterViewController: UIBaseViewController {
    
    @IBOutlet weak var hqTableView: UITableView!
    @IBOutlet weak var imageContainer: UIView!
    @IBOutlet weak var imageCharacter: UIImageView!
    @IBOutlet weak var nameContainer: UIView!
    @IBOutlet weak var nameCharacter: UILabel!
    @IBOutlet weak var descCharacter: UILabel!
    @IBOutlet weak var titleHq: UILabel!
    
    var selectedCharacter: Character?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.characterData()
        self.setupLayout()
        self.logoHeader()
        self.registerNib()
        
        self.hqTableView.delegate = self
        self.hqTableView.dataSource = self
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        dismiss(animated: true, completion: nil)
    }

    override func updateViewConstraints() {
        super.updateViewConstraints()
        self.imageContainer.updateConstraintsIfNeeded()
    }
}

extension CharacterViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (selectedCharacter?.comics?.items.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ItemDetailTableViewCell
        let index = indexPath.row
        let comics = selectedCharacter?.comics
        let item = comics!.items[index]
        
        cell.dataTitle.text = item.name
        cell.configureCell(with: item)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //self.selectedCharacter = self.comics[indexPath.row]
        var selChar : Int? = selectedCharacter?.id
        let convert = selChar.map(String.init) ?? ""
        
        self.performSegue(withIdentifier: "COMIC_DATA", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "COMIC_DATA" {
            let view = segue.destination as! ComicDataViewController
            view.selectedCharacter = self.selectedCharacter
        }
    }
}

extension CharacterViewController {
    
    @IBAction func cancel(_ unwindsegue: UIStoryboardSegue) {
        self.navigationController!.popViewController(animated: true)
    }
    
    fileprivate func registerNib() {
        let nibName = UINib(nibName: "ItemDetailTableViewCell", bundle: nil)
        self.hqTableView.register(nibName, forCellReuseIdentifier: "Cell")
        self.hqTableView.rowHeight = UITableView.automaticDimension
        self.hqTableView.estimatedRowHeight = 70
    }
    
    func characterData() {
        if let character = selectedCharacter {
            self.nameCharacter.text = character.name
            
            if character.description.count > 0 {
                self.nameContainer.isHidden = false
                self.descCharacter.text = character.description
            } else {
                self.nameContainer.isHidden = true
            }
            
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
