//
//  ListTests.swift
//  MarvelAppTests
//
//  Created by Thyago on 01/04/20.
//  Copyright © 2020 tcasablancas. All rights reserved.
//

import Quick
import Nimble
@testable import MarvelApp

class ListTetsts: QuickSpec {
    
    override func spec() {
        var service: ListServable?
        var logic: ListLogic?
        var viewModel: ListViewModel?
        
        describe("Componente: Lista de Personagens") {
            
            context("withouth load data", {
                beforeEach {
                    service = MarvelService.shared
                    logic = ListLogic(service: service!, router: self)
                    viewModel = ListViewModel(logic: logic!)
                }
                
                it("static data is correct", closure: {
                    expect(viewModel!.title).to(equal("Characters"))
                })
                
                it("initial data is correct", closure: {
                    expect(viewModel?.numberOfCharacters).to(equal(0))
                    expect(viewModel?.isFirstLoad).to(equal(true))
                })
            })
            
            context("with data loaded", {
              
                beforeEach {
                    service = MarvelService.shared
                    logic = ListLogic(service: service!, router: self)
                    viewModel = ListViewModel(logic: logic!)
                    viewModel!.loadCharacters()
                }
                
                it("has correct state after first load", closure: {
                    expect(viewModel!.numberOfCharacters).to(equal(20))
                    expect(viewModel!.isFirstLoad).to(equal(false))
                })
                
                it("can load more content", closure: {
                    viewModel!.loadNextPage()
                    expect(viewModel!.numberOfCharacters).to(equal(40))
                    expect(viewModel!.isFirstLoad).to(equal(false))
                })
                
                it("can reset catalog data", closure: {
                    viewModel?.reset()
                    expect(viewModel!.numberOfCharacters).to(equal(0))
                    expect(viewModel!.isFirstLoad).to(equal(true))
                })
            })
            
            context("can create DTOs", {
                
                beforeEach {
                    service = MarvelService.shared
                    logic = ListLogic(service: service!, router: self)
                    viewModel = ListViewModel(logic: logic!)
                    viewModel!.loadCharacters()
                }
                
                it("can load DTO for catalog item", closure: {
                    
                    let dto = viewModel?.viewModel(at: IndexPath(item: 0, section: 0)) as? CatalogItemCollectionViewCellDTO
                    expect(dto).notTo(beNil())
                    expect(dto!.title!).to(equal("3-D Man"))
                    expect(dto!.imageURL!.absoluteString).to(equal("http://i.annihil.us/u/prod/marvel/i/mg/c/e0/535fecbbb9784.jpg"))
                })
            })
        }
    }
}

extension ListTetsts: ListRouter {
    func detail(for character: Character) {}
    func showOptions(_ options: [CharacterOption], for character: Character, onSelectedOption: @escaping ((CharacterOption) -> Void)) {}
    func showAlert(with title: String, message: String, retry: (() -> Void)?, onDismiss: (() -> Void)?) {}
}
