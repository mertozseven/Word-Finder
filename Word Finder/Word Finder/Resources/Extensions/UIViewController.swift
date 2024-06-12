//
//  UIViewController.swift
//  Word Finder
//
//  Created by Mert Ozseven on 7.06.2024.
//

import UIKit

extension UIViewController {
    
    // MARK: - Presenting WFAlert on main thread
    func presentWFAlertOnMainThread(alertTitle: String, message: String, buttonTitle: String) {
        DispatchQueue.main.async {
            let alertVC = WFAlertViewController(alertTitle: alertTitle, message: message, buttonTitle: buttonTitle)
            alertVC.modalPresentationStyle = .overFullScreen
            alertVC.modalTransitionStyle = .crossDissolve
            self.present(alertVC, animated: true)
        }
    }
    
    // MARK: - Keyboard Dismiss Gesture
    func createDismissKeyboardTapGesture() {
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
}
