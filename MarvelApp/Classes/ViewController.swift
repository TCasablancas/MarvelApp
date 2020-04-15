//
//  ViewController.swift
//  MarvelApp
//
//  Created by Thyago on 14/04/20.
//  Copyright © 2020 tcasablancas. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var character = [Character]()
    var collection: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupUI()
        self.logoHeader()
        
        print(character)
    }
    
    fileprivate func setupUI() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.backgroundColor = .clear
        collection.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collection)
        
        collection.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
        collection.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collection.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        collection.heightAnchor.constraint(equalToConstant: view.bounds.height).isActive = true
        
        self.collection.delegate = self
        self.collection.dataSource = self
        self.collection.register(ListItemCollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return character.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! ListItemCollectionViewCell
        let index = indexPath.row
        let item = self.character[index]
        
        cell.item = item
        
        return cell
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
