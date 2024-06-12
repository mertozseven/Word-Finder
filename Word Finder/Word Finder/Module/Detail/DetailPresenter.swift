//
//  DetailPresenter.swift
//  Word Finder
//
//  Created by Mert Ozseven on 12.06.2024.
//

import Foundation

protocol DetailPresenterProtocol {
    func viewDidLoad()
    func getWordDetail() -> WordEntity?
}

final class DetailPresenter {
    unowned var view: DetailViewControllerProtocol!
    let interactor: DetailInteractorProtocol
    let router: DetailRouterProtocol
    
    init(view: DetailViewControllerProtocol, interactor: DetailInteractorProtocol, router: DetailRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

extension DetailPresenter: DetailPresenterProtocol {
    func viewDidLoad() {
        if let wordDetail = interactor.getWordDetail() {
            view.displayWordDetail(wordDetail)
        }
    }
    
    func getWordDetail() -> WordEntity? {
        return interactor.getWordDetail()
    }
}
