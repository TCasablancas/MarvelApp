//
//  ViewController.swift
//  MarvelApp
//
//  Created by Thyago on 14/04/20.
//  Copyright © 2020 tcasablancas. All rights reserved.
//

import UIKit
import ObjectMapper

class ViewController: UIBaseViewController, UISearchBarDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    let requestCharacter = RequestCharacter()
    var character = [Character]()
    var searchCharacter = [Character]()
    var loadingCharacters = false
    var currentPage = 0
    var total = 0
    var selectedCharacter: Character? = nil
    var nameSearch = ""
    
    let searchController = UISearchController(searchResultsController: nil)
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    var isSearchBarEmpty: Bool {
      return searchController.searchBar.text?.isEmpty ?? true
    }
    
    var isFiltering: Bool {
        return searchController.isActive && !isSearchBarEmpty
    }
    
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
        self.loadData()
        self.registerNib()
        //self.resetButton
        
        character = searchCharacter
        
        self.navigationItem.searchController = searchController
        searchController.searchBar.delegate = self
        
        if character.count < 1 {
            self.resetButton.isEnabled = false
            self.navigationItem.rightBarButtonItem = nil
        } else {
            self.resetButton.isEnabled = true
            self.navigationItem.rightBarButtonItem = self.resetButton
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        dismiss(animated: true, completion: nil)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchCharacter = self.character.filter({ (character: Character) -> Bool in
            return character.name!.lowercased().contains(searchText.lowercased())
        })
        self.tableView.reloadData()
    }
    
    private lazy var resetButton: UIBarButtonItem = {
        let navigationItem = UINavigationItem()
        return UIBarButtonItem(
            title: "Reset",
            style: .plain,
            target: self,
            action: #selector(reloadData)
        )
    }()
}

extension ViewController: UISearchResultsUpdating {
    
    @objc func reloadData() {
        self.tableView.reloadData()
    }
    
    fileprivate func registerNib() {
        let nibName = UINib(nibName: "CharactersTableViewCell", bundle: nil)
        self.tableView.register(nibName, forCellReuseIdentifier: "Cell")
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 140
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
        self.searchController.searchBar.placeholder = "buscar herói"
        
        let txtSearchBar = self.searchController.searchBar.value(forKey: "searchField") as? UITextField
        txtSearchBar?.textColor = Theme.default.white
        txtSearchBar?.font = UIFont(name: Font.avenirBold.rawValue, size: 16)
    }
    
    func filterContentSearch(_ searchText: String) {
        searchCharacter = character.filter({ (hero: Character) -> Bool in
            return hero.name!.lowercased().contains(searchText.lowercased())
        })
        
        self.tableView.reloadData()
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = self.searchController.searchBar
        self.filterContentSearch(searchBar.text!)
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
//    func resetButton() {
//        let navigationItem = UINavigationItem()
//        navigationItem.rightBarButtonItem = UIBarButtonItem(
//            title: "Reset", style: .done, target: self, action: #selector(reloadData)
//        )
//    }
//
    /// Setting the TableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return self.searchCharacter.count
        }
        return character.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CharactersTableViewCell
        let char: Character
        let index = indexPath.row
        let item = self.character[index]
        
        if isFiltering {
            char = searchCharacter[index]
        } else {
            char = item
        }
        
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
