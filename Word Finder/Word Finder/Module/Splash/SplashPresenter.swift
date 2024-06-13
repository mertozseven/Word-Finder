//
//  SplashPresenter.swift
//  Word Finder
//
//  Created by Mert Ozseven on 14.06.2024.
//

import Foundation

protocol SplashPresenterProtocol {
    func viewDidLoad()
    func didTapContinueButton()
}

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

extension SplashPresenter: SplashPresenterProtocol {
    func viewDidLoad() {
        view.setupView()
    }
    
    func didTapContinueButton() {
        router.dismissSplash()
    }
}
