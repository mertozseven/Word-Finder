//
//  SplashPresenter.swift
//  Word Finder
//
//  Created by Mert Ozseven on 14.06.2024.
//

import Foundation

// MARK: - SplashPresenterProtocol
protocol SplashPresenterProtocol {
    func viewDidLoad()
    func didTapContinueButton()
}

// MARK: - SplashPresenter
class SplashPresenter {
    unowned var view: SplashViewControllerProtocol
    let interactor: SplashInteractorProtocol
    let router: SplashRouterProtocol
    
    init(view: SplashViewControllerProtocol, interactor: SplashInteractorProtocol, router: SplashRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

// MARK: - SplashPresenterProtocol Methods
extension SplashPresenter: SplashPresenterProtocol {
    func viewDidLoad() {
        view.setupView()
    }
    
    func didTapContinueButton() {
        router.dismissSplash()
    }
}
