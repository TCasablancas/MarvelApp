//
//  ComicDataViewController.swift
//  MarvelApp
//
//  Created by Thyago on 27/04/20.
//  Copyright © 2020 tcasablancas. All rights reserved.
//

import UIKit

class ComicDataViewController: UIBaseViewController {
    
    @IBOutlet weak var dataContainer: UIView!
    @IBOutlet weak var goBack: UIButton!
    @IBOutlet weak var imgComic: UIImageView!
    @IBOutlet weak var titleComic: UILabel!
    @IBOutlet weak var pricePrint: UILabel!
    @IBOutlet weak var labelPrint: UILabel!
    @IBOutlet weak var priceDigital: UILabel!
    @IBOutlet weak var labelDigital: UILabel!
    @IBOutlet weak var descriptionComic: UILabel!
    
    var requestComic: RequestComic?
    var selectedCharacter: Character?
    var loadingComics = false
    var comicSearch = ""
    var currentPage = 0
    var total = 0
    var comic = [Comics]()
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
        self.setupLayout()
        self.setupData()
        self.loadData()
        
        print(loadData())
    }
}

extension ComicDataViewController {
    
    private func loadData() {
        self.loadingComics = true
        self.requestComic?.loadComic(name: comicSearch, page: currentPage) { (response) in
            switch response {
            case .success(let model):
                self.total = model.data.total
                //self.comic.append(model.data.results)
                self.activityIndicator.stopAnimating()
                self.loadingComics = false
            case .serverError(let description):
                print("Server error: \(description) \n")
            case .noConnection(let description):
                print("Server error noConnection: \(description) \n")
            case .timeOut(let description):
                print("Server error timeOut: \(description) \n")
            }
        }
    }
    
    func setupData() {
        
        var selChar : Int? = selectedCharacter?.comics?.available
        let convert = selChar.map(String.init) ?? ""
        
        if let comic = selectedCharacter {
            self.imgComic.image = UIImage(named: "\(comic.thumbnail.imagePath())")
            self.titleComic.text = comic.comics?.collectionURI
            
            self.pricePrint.text = "$" + convert
            self.priceDigital.text = "$" + convert
            self.labelPrint.text = "Print Price"
            self.labelDigital.text = "Digital Price"
            
            self.descriptionComic.text = comic.description
        }
        
    }
    
    func setupLayout() {
        self.view.backgroundColor = Theme.default.mainBlack
        self.view.layer.opacity = 0.4
        
        self.dataContainer.backgroundColor = .clear
        
        Theme.default.callToActionBottom(self.goBack)
        self.goBack.setTitle("go back", for: .normal)
        
        Theme.default.bigTitle(self.titleComic)
        Theme.default.price(self.pricePrint)
        Theme.default.price(self.priceDigital)
        Theme.default.descriptionCharacter(self.labelPrint)
        Theme.default.descriptionCharacter(self.labelDigital)
        Theme.default.mainTextBlackBg(self.descriptionComic)
    }
    
}
