//
//  HomePresenter.swift
//  Word Finder
//
//  Created by Mert Ozseven on 7.06.2024.
//

import Foundation

protocol HomePresenterProtocol {
    func viewDidLoad()
    func didSelectRowAt(_ indexPath: IndexPath)
    func numberOfItems() -> Int
    func recentSearch(at indexPath: IndexPath) -> String?
    func searchWord(_ word: String)
}

final class HomePresenter {
    unowned var view: HomeViewControllerProtocol!
    let router: HomeRouterProtocol
    let interactor: HomeInteractorProtocol
    
    private var recentSearches: [String] = []
    
    init(view: HomeViewControllerProtocol, router: HomeRouterProtocol, interactor: HomeInteractorProtocol) {
        self.view = view
        self.router = router
        self.interactor = interactor
    }
}

extension HomePresenter: HomePresenterProtocol {
    func viewDidLoad() {
        view.setupTableView()
        view.reloadData()
        view.setupTextField()
        interactor.fetchRecentSearches()
    }
    
    func didSelectRowAt(_ indexPath: IndexPath) {
        let word = recentSearches[indexPath.row]
        interactor.searchWord(word)
    }
    
    func numberOfItems() -> Int {
        return recentSearches.count
    }
    
    func recentSearch(at indexPath: IndexPath) -> String? {
        return recentSearches[safe: indexPath.row]
    }
    
    func searchWord(_ word: String) {
        interactor.searchWord(word)
    }
}

extension HomePresenter: HomeInteractorOutputProtocol {
    func fetchRecentSearchesOutput(_ searches: [String]) {
        self.recentSearches = searches
        view.reloadData()
    }
    
    func searchWordOutput(_ result: DictionaryResult) {
        switch result {
        case .success(let response):
//            if let word = response.word {
            recentSearches.append(response.first!.word)
                view.reloadData()
            router.navigate(.detail(word: response.first!))
//            } else {
//                view.showAlert()
//            }
        case .failure(let error):
            view.showAlert()
        }
    }
}
