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
    func getRecentSearches() -> [String]?
    func deleteRecentSearch(at index: Int)
}


class HomePresenter {
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
        router.navigate(.splash)
    }
    
    func didSelectRowAt(_ indexPath: IndexPath) {
        let word = recentSearches[indexPath.row]
        router.navigate(.detail(word: word))
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
    
    func getRecentSearches() -> [String]? {
        return recentSearches
    }
    
    func deleteRecentSearch(at index: Int) {
        interactor.deleteRecentSearch(at: index)
    }
}

extension HomePresenter: HomeInteractorOutputProtocol {
    func fetchRecentSearchesOutput(_ searches: [String]) {
        self.recentSearches = searches
        view.reloadData()
    }
    
    func searchWordOutput(_ word: String) {
        router.navigate(.detail(word: word))
    }
}
