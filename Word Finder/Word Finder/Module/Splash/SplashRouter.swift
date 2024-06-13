//
//  SplashRouter.swift
//  Word Finder
//
//  Created by Mert Ozseven on 14.06.2024.
//

import Foundation

protocol SplashRouterProtocol {
    func dismissSplash()
}

class SplashRouter {
    weak var viewController: SplashViewController?
    
    static func createModule() -> SplashViewController {
        let view = SplashViewController()
        let interactor = SplashInteractor()
        let router = SplashRouter()
        let presenter = SplashPresenter(view: view, interactor: interactor, router: router)
        view.presenter = presenter
        router.viewController = view
        return view
    }
}

extension SplashRouter: SplashRouterProtocol {
    func dismissSplash() {
        viewController?.dismiss(animated: true, completion: nil)
    }
}
