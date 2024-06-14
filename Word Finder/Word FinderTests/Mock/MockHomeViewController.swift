//
//  MockHomeViewController.swift
//  Word FinderTests
//
//  Created by Mert Ozseven on 14.06.2024.
//

import Foundation
@testable import Word_Finder

final class MockHomeViewController: HomeViewControllerProtocol {
    
    var isInvokedSetupTableView = false
    var invokedSetupTableViewCount = 0
    
    func setupTableView() {
        isInvokedSetupTableView = true
        invokedSetupTableViewCount += 1
    }
    
    var isInvokedSetupTextField = false
    var invokedSetupTextFieldCount = 0
    
    func setupTextField() {
        isInvokedSetupTextField = true
        invokedSetupTextFieldCount += 1
    }
    
    var isInvokedReloadData = false
    var invokedReloadDataCount = 0
    
    func reloadData() {
        isInvokedReloadData = true
        invokedReloadDataCount += 1
    }
    
    var isInvokedShowAlert = false
    var invokedShowAlertCount = 0
    var invokedShowAlertParameters: (alertTitle: String, message: String, buttonTitle: String)?
    
    func showAlert(alertTitle: String, message: String, buttonTitle: String) {
        isInvokedShowAlert = true
        invokedShowAlertCount += 1
        invokedShowAlertParameters = (alertTitle, message, buttonTitle)
    }
}
