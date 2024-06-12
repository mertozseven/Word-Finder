//
//  HomeRouter.swift
//  Word Finder
//
//  Created by Mert Ozseven on 7.06.2024.
//

import Foundation

enum HomeRoutes {
    case detail(word: WordEntity)
}

protocol HomeRouterProtocol {
    func navigate(_ route: HomeRoutes)
}

final class HomeRouter {
    weak var viewController: HomeViewController?
    
    static func createModule() -> HomeViewController {
        let view = HomeViewController()
        let interactor = HomeInteractor()
        let router = HomeRouter()
        let presenter = HomePresenter(view: view, router: router, interactor: interactor)
        view.presenter = presenter
        interactor.output = presenter
        router.viewController = view
        
        return view
    }
}

extension HomeRouter: HomeRouterProtocol {
    func navigate(_ route: HomeRoutes) {
        switch route {
        case .detail(let word):
            let detailVC = DetailRouter.createModule(with: word)
            viewController?.navigationController?.pushViewController(detailVC, animated: true)
        }
    }
}
