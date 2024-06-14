//
//  DetailRouter.swift
//  Word Finder
//
//  Created by Mert Ozseven on 12.06.2024.
//

import Foundation

enum DetailRoutes {
    case detail(word: String)
}

protocol DetailRouterProtocol {
    func navigate(_ route: DetailRoutes)
    func popVC()
}

final class DetailRouter {
    weak var viewController: DetailViewController?
    
    static func createModule(with word: String) -> DetailViewController {
        let view = DetailViewController(nibName: nil, bundle: nil)
        let interactor = DetailInteractor(word: word)
        let router = DetailRouter()
        let presenter = DetailPresenter(view: view, interactor: interactor, router: router)
        
        view.presenter = presenter
        interactor.output = presenter
        router.viewController = view
        
        return view
    }
}

extension DetailRouter: DetailRouterProtocol {
    
    func popVC() {
        viewController?.navigationController?.popViewController(animated: true)
    }
    
    func navigate(_ route: DetailRoutes) {
        switch route {
        case .detail(let word):
            let detailVC = DetailRouter.createModule(with: word)
            viewController?.navigationController?.pushViewController(detailVC, animated: true)
        }
    }
}
