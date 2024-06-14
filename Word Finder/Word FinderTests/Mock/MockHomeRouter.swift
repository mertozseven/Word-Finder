//
//  MockHomeRouter.swift
//  Word FinderTests
//
//  Created by Mert Ozseven on 14.06.2024.
//

import Foundation
@testable import Word_Finder

final class MockHomeRouter: HomeRouterProtocol {
    
    var isInvokedNavigate = false
    var invokedNavigateCount = 0
    var invokedNavigateRoute: HomeRoutes?
    
    func navigate(_ route: HomeRoutes) {
        isInvokedNavigate = true
        invokedNavigateCount += 1
        invokedNavigateRoute = route
    }
}
