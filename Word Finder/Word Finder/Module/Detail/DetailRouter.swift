//
//  DetailRouter.swift
//  Word Finder
//
//  Created by Mert Ozseven on 12.06.2024.
//

import Foundation
import UIKit

protocol DetailRouterProtocol {
    // Define navigation methods if needed
}

final class DetailRouter {
    weak var viewController: DetailViewController?
    
    static func createModule(with word: WordEntity) -> DetailViewController {
        let view = DetailViewController(nibName: nil, bundle: nil)
        let interactor = DetailInteractor(word: word)
        let router = DetailRouter()
        let presenter = DetailPresenter(view: view, interactor: interactor, router: router)
        
        view.presenter = presenter
        router.viewController = view
        
        return view
    }
}

extension DetailRouter: DetailRouterProtocol {
    // Implement navigation methods if needed
}


