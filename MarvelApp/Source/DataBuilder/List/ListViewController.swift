//
//  ListViewController.swift
//  MarvelApp
//
//  Created by Thyago on 31/03/20.
//  Copyright © 2020 tcasablancas. All rights reserved.
//

import UIKit
import PureLayout
import CCBottomRefreshControl

class ListViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    private lazy var resetButton: UIBarButtonItem = {
        return UIBarButtonItem(
            title: "Reset",
            style: .done,
            target: self,
            action: #selector(reloadData)
        )
    }()
    
    private lazy var searchController: UISearchController = {
        let controller = UISearchController(searchResultsController: nil)
        controller.obscuresBackgroundDuringPresentation = false
        controller.searchBar.placeholder = "Procurar Personagem"
        controller.searchBar.delegate = self
        return controller
    }()
    
    private lazy var loadingViewController: LoadingViewController = {
        return LoadingViewController.loadXib(from: nil)
    }()
    
    private lazy var errorViewController: ErrorViewController = {
        return ErrorViewController.loadXib(from: nil)
    }()
    
    private lazy var bottomRefreshControl: UIRefreshControl = {
        let control = UIRefreshControl.newAutoLayout()
        control.accessibilityIdentifier = "catalog_refresh_control_bottom"
        control.triggerVerticalOffset = 100
        control.addTarget(self, action: #selector(loadNextPage), for: .valueChanged)
        return control
    }()
    
    private lazy var listCollectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 160.0, height: 200.0)
        layout.minimumInteritemSpacing = 16.0
        layout.minimumLineSpacing = 16.0
        layout.sectionInset = UIEdgeInsets(top: 16.0, left: 16.0, bottom: 16.0, right: 16.0)
        
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.accessibilityIdentifier = "catalog_collection_view"
        collectionView.backgroundColor = .white
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()
    
    private let viewModel: ListViewModel
    
    init(viewModel: ListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        title = viewModel.title
        
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
        registerCells()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        DispatchQueue.main.async {
            self.listCollectionView.reloadData()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.loadCharacters()
    }
    
    override func buildViewHierarchy() {
        view.addSubview(listCollectionView)
    }

    override func setupConstraints() {
        listCollectionView.autoPinEdgesToSuperviewEdges()
    }
    
    override func configureViews() {
        listCollectionView.bottomRefreshControl = bottomRefreshControl
    }
    
    private func registerCells() {
        listCollectionView.registerCell(of: ListCollectionViewCell.self)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfCharacters
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch viewModel.viewModel(at: indexPath) {
        case let dto as ListCollectionViewCellDTO:
            return table(collectionView, catalogCellAt: indexPath, with: dto)
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.detailForCharacter(at: indexPath)
    }
    
    @objc func reloadData() {
        reset()
        viewModel.reload()
    }
    
    @objc func loadNextPage() {
        viewModel.loadNextPage()
    }
}

private extension ListViewController {
    
    func showLoading() {
        add(loadingViewController)
        loadingViewController.view.autoPinEdgesToSuperviewEdges()
    }
    
    func stopLoading() {
        loadingViewController.remove()
        listCollectionView.bottomRefreshControl?.endRefreshing()
    }
    
    func showError(_ viewModel: ErrorViewModel) {
        add(errorViewController)
        errorViewController.configure(with: viewModel)
        errorViewController.view.autoPinEdgesToSuperviewEdges()
    }
    
    func removeError() {
        errorViewController.remove()
    }
    
    func reset() {
        viewModel.reset()
        listCollectionView.reloadData()
    }
    
    func table(_ collectionView: UICollectionView, catalogCellAt indexPath: IndexPath, with viewModel: ListCollectionViewCellDTO?) -> ListCollectionViewCell {
        let cell = collectionView.dequeueReusableCell(ListCollectionViewCell.self, for: indexPath)
        cell.indexPath = indexPath
        cell.delegate = self
        cell.configure(with: viewModel)
        return cell
    }
}

extension ListViewController: ListCollectionViewCellDelegate {
    
    func longPressCell(at indexPath: IndexPath) {
        viewModel.optionsForCharacter(at: indexPath) {
            DispatchQueue.main.async {
                self.listCollectionView.reloadItems(at: [indexPath])
            }
        }
    }
}

extension ListViewController: ListViewModelDelegate {
    
    func willStartLoad() {
        
        guard viewModel.isFirstLoad else {
            return
        }
        
        resetButton.isEnabled = false
        removeError()
        showLoading()
    }
    
    func willFinsihLoad() {
        DispatchQueue.main.async {
            
            if self.viewModel.isSearching {
                self.resetButton.isEnabled = true
                self.navigationItem.rightBarButtonItem = self.resetButton
            } else {
                self.resetButton.isEnabled = false
                self.navigationItem.rightBarButtonItem = nil
            }
            
            self.stopLoading()
        }
    }
    
    func didFinsihLoad() {
        DispatchQueue.main.async {
            self.listCollectionView.reloadData()
        }
    }
    
    func didFinsihLoad(with error: NSError) {
        
        let uiChanges: (() -> Void) = {
            self.showError(ErrorViewModel(error: error, actionTitle: "Tentar novamente") {
                self.viewModel.reload()
            })
        }
        
        DispatchQueue.main.async(execute: uiChanges)
    }
}

extension ListViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {

        guard let text = searchBar.text else {
            return
        }
        
        reset()
        viewModel.searchCharacter(with: text)
    }
}
