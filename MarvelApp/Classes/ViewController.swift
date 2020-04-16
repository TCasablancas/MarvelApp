//
//  ViewController.swift
//  MarvelApp
//
//  Created by Thyago on 14/04/20.
//  Copyright © 2020 tcasablancas. All rights reserved.
//

import UIKit
import ObjectMapper

class ViewController: UIViewController, UISearchControllerDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    let requestCharacter = RequestCharacter()
    let searchController = UISearchController(searchResultsController: nil)
    var character = [Character]()
    var loadingCharacters = false
    var currentPage = 0
    var total = 0
    var selectedCharacter: Character? = nil
    var nameSearch = ""
    
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        if character.count == 0 {
            self.mainActivityIndicator()
        }
        
        self.logoHeader()
        self.layoutSearchBar()
        self.layouTableView()
        self.loadData()
        self.registerNib()
        
    }
}

extension ViewController: UISearchResultsUpdating {
    
    
    
    fileprivate func registerNib() {
        let nibName = UINib(nibName: "CharacterTableViewCell", bundle: nil)
        self.tableView.register(nibName, forCellReuseIdentifier: "Cell")
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 120
    }
    
    /// Activity Indicator
    func mainActivityIndicator() {
        self.activityIndicator.center = self.view.center
        self.activityIndicator.hidesWhenStopped = true
        self.activityIndicator.style = UIActivityIndicatorView.Style.large
        view.addSubview(activityIndicator)
        self.activityIndicator.startAnimating()
    }
    
    /// Loading Data from SearchBar
    private func loadData() {
        self.loadingCharacters = true
        self.requestCharacter.loadCharacters(name: nameSearch, page: currentPage) { (response) in
            switch response {
            case .success(let model):
                self.total = model.data.total
                self.character.append(contentsOf: model.data.results)
                self.tableView.reloadData()
                self.activityIndicator.stopAnimating()
                self.loadingCharacters = false
            case .serverError(let description):
                print("Server error: \(description) \n")
            case .noConnection(let description):
                print("Server error noConnection: \(description) \n")
            case .timeOut(let description):
                print("Server error timeOut: \(description) \n")
            }
            
        }
    }
    
    private func cleanLoadedData() {
        self.character = []
        self.nameSearch = ""
        self.loadData()
    }
    
    /// Setting up SearchBar layout
    func layoutSearchBar() {
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        
        searchController.searchBar.barTintColor = Theme.default.mainBlack
        searchController.searchBar.placeholder = "Buscar Herói"
        searchController.searchBar.layer.cornerRadius = 15
        searchController.searchBar.isHidden = true
        
        self.tableView.tableHeaderView = searchController.searchBar
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchText: searchController.searchBar.text!)
    }
    
    func filterContentForSearchText(searchText: String, scope: String = "All") {
       
    }
    
    @IBAction func openSearch() {
        self.searchController.searchBar.isHidden = false
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    /// Setting the TableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return character.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CharactersTableViewCell
        let index = indexPath.row
        let item = self.character[index]
        
        cell.configureCell(with: item)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedCharacter = self.character[indexPath.row]
        self.performSegue(withIdentifier: "CharacterView", sender: nil)
    }
    
    /// TableView Layout setting
    func layouTableView() {
        self.tableView.layer.backgroundColor = UIColor.white.cgColor
    }
    
    /// Setting up the logo on HeaderBar
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
