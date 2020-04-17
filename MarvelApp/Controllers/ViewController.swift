//
//  ViewController.swift
//  MarvelApp
//
//  Created by Thyago on 14/04/20.
//  Copyright © 2020 tcasablancas. All rights reserved.
//

import UIKit
import ObjectMapper

class ViewController: UIBaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBarView: UIView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    let requestCharacter = RequestCharacter()
    var character = [Character]()
    var loadingCharacters = false
    var currentPage = 0
    var total = 0
    var selectedCharacter: Character? = nil
    var nameSearch = ""
    
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.navigationBar.barStyle = .black
    }
    
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
        self.setupSearchBar()
    }
    
}

extension ViewController: UISearchResultsUpdating, UISearchBarDelegate {

    fileprivate func registerNib() {
        let nibName = UINib(nibName: "CharactersTableViewCell", bundle: nil)
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
        self.searchBarView.backgroundColor = Theme.default.mainBlack
        self.searchBar.barTintColor = Theme.default.mainBlack
        self.searchBar.placeholder = "buscar herói"
        
        let txtSearchBar = searchBar.value(forKey: "searchField") as? UITextField
        txtSearchBar?.textColor = Theme.default.white
        txtSearchBar?.font = UIFont(name: Font.avenirBold.rawValue, size: 16)
    }
    
    func setupSearchBar() {
        self.searchBar.delegate = self
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        let query = searchBar.text ?? ""
        if !query.isEmpty {
            
        }
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchText: searchController.searchBar.text!)
    }
    
    func filterContentForSearchText(searchText: String, scope: String = "All") {
       
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
        return 160
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedCharacter = self.character[indexPath.row]
        self.performSegue(withIdentifier: "CharacterView", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == (character.count - 10) && !loadingCharacters && character.count != total {
            self.currentPage += 1
            self.loadData()
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        self.selectedCharacter = self.character[indexPath.row]
        self.performSegue(withIdentifier: "CharacterView", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "CharacterView" {
            let view = segue.destination as! CharacterViewController
            view.selectedCharacter = self.selectedCharacter
        }
    }
    
    /// TableView Layout setting
    func layouTableView() {
        
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