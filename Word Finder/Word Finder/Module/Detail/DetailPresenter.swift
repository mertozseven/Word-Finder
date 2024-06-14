//
//  DetailPresenter.swift
//  Word Finder
//
//  Created by Mert Ozseven on 12.06.2024.
//

import Foundation

protocol DetailPresenterProtocol {
    func viewDidLoad()
    func didSelectSynonym(_ synonym: String)
}

final class DetailPresenter {
    unowned var view: DetailViewControllerProtocol!
    let router: DetailRouterProtocol
    let interactor: DetailInteractorProtocol
    
    init(view: DetailViewControllerProtocol, interactor: DetailInteractorProtocol, router: DetailRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

extension DetailPresenter: DetailPresenterProtocol {
    func viewDidLoad() {
        view.setupView()
        interactor.fetchWordDetail()
    }
    
    func didSelectSynonym(_ synonym: String) {
        router.navigate(.detail(word: synonym))
    }
}

extension DetailPresenter: DetailInteractorOutputProtocol {
    func fetchWordDetailOutput(_ result: DictionaryResult) {
        DispatchQueue.main.async {
            switch result {
            case .success(let response):
                if let wordDetail = response.first {
                    self.view.displayWordDetail(wordDetail)
                } else {
                    self.router.popVC()
                    self.view.showAlert(alertTitle: "Error", message: "Error while fetching the word details. Please try again later.", buttonTitle: "Okay")
                }
            case .failure:
                self.router.popVC()
                self.view.showAlert(alertTitle: "Error", message: "Error while fetching the word details. Please try again later.", buttonTitle: "Okay")
            }
        }
    }
    
    func fetchSynonymsOutput(_ result: SynonymResult) {
        DispatchQueue.main.async {
            switch result {
            case .success(let synonyms):
                self.view.displaySynonyms(synonyms)
            case .failure:
                self.view.showAlert(alertTitle: "Error", message: "Error while fetching synonyms. Please try again later.", buttonTitle: "Okay")
            }
        }
    }
}
