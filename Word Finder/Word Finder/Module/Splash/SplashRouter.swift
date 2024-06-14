//
//  SplashRouter.swift
//  Word Finder
//
//  Created by Mert Ozseven on 14.06.2024.
//

import Foundation

// MARK: - SplashRouterProtocol
protocol SplashRouterProtocol {
    func dismissSplash()
}

// MARK: - SplashRouter
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

// MARK: - SplashRouterProtocol Methods
extension SplashRouter: SplashRouterProtocol {
    func dismissSplash() {
        viewController?.dismiss(animated: true, completion: nil)
    }
}
