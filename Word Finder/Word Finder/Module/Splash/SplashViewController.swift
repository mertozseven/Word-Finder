//
//  SplashViewController.swift
//  Word Finder
//
//  Created by Mert Ozseven on 14.06.2024.
//

import UIKit

protocol SplashViewControllerProtocol: AnyObject {
    func setupView()
}

class SplashViewController: UIViewController {
    
    // MARK: - Properties
    var presenter: SplashPresenterProtocol!
    
    // MARK: - UI Components
    private let welcomeLabel = WFLabel(
        text: "Welcome to \nWord Finder",
        textAlignment: .center,
        textColor: .label,
        font: .systemFont(ofSize: 40, weight: .bold),
        numberOfLines: 0,
        adjustsFontSizeToFitWidth: false
    )
    
    private let textIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "text.word.spacing")
        imageView.tintColor = .systemYellow
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private let textTitleDescription = WFLabel(
        text: "Your Pocket Dictionary",
        textAlignment: .left,
        textColor: .label,
        font: .preferredFont(forTextStyle: .title2),
        numberOfLines: 0,
        adjustsFontSizeToFitWidth: true
    )
    
    private let textDescription = WFLabel(
        text: "Find all the word you want to learn 📖.",
        textAlignment: .left,
        textColor: .secondaryLabel,
        font: .preferredFont(forTextStyle: .body),
        numberOfLines: 0,
        adjustsFontSizeToFitWidth: false
    )
    
    private let bookIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "text.book.closed.fill")
        imageView.tintColor = .systemGreen
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private let bookTitleDescription = WFLabel(
        text: "See Details",
        textAlignment: .left,
        textColor: .label,
        font: .preferredFont(forTextStyle: .title2),
        adjustsFontSizeToFitWidth: false
    )
    
    private let bookDescription = WFLabel(
        text: "What is that mean ? Check the in depth detail of the words you want to know 🤓.",
        textAlignment: .left,
        textColor: .secondaryLabel,
        font: .preferredFont(forTextStyle: .body),
        numberOfLines: 0,
        adjustsFontSizeToFitWidth: false
    )
    
    private let devicesIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "laptopcomputer.and.iphone")
        imageView.tintColor = .systemBlue
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private let devicesTitleDescription = WFLabel(
        text: "Connect From Anywhere",
        textAlignment: .left,
        textColor: .label,
        font: .preferredFont(forTextStyle: .title2),
        adjustsFontSizeToFitWidth: true
    )
    
    private let devicesDescription = WFLabel(
        text: "Word Finder is available on all Apple products. Find about the most complex words from anywhere 💻",
        textAlignment: .left,
        textColor: .secondaryLabel,
        font: .preferredFont(forTextStyle: .body),
        numberOfLines: 0,
        adjustsFontSizeToFitWidth: true
    )
    
    private let continueButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 10
        button.titleLabel?.font = .preferredFont(forTextStyle: .headline)
        button.titleLabel?.textAlignment = .center
        button.setTitle("Continue", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
}

extension SplashViewController: SplashViewControllerProtocol {
    func setupView() {
        view.backgroundColor = .systemBackground
        addViews()
        configureLayout()
        setupButtonAction()
    }
    
    private func addViews() {
        view.addSubview(welcomeLabel)
        view.addSubview(textIcon)
        view.addSubview(textTitleDescription)
        view.addSubview(textDescription)
        view.addSubview(bookIcon)
        view.addSubview(bookTitleDescription)
        view.addSubview(bookDescription)
        view.addSubview(devicesIcon)
        view.addSubview(devicesTitleDescription)
        view.addSubview(devicesDescription)
        view.addSubview(continueButton)
    }
    
    private func configureLayout() {
        
        let welcomeLabelConstraints = [
            welcomeLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 40),
            welcomeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            welcomeLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            welcomeLabel.heightAnchor.constraint(equalToConstant: 96)
        ]
        let textIconConstraints = [
            textIcon.topAnchor.constraint(equalTo: textTitleDescription.topAnchor, constant: 16),
            textIcon.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            textIcon.widthAnchor.constraint(equalToConstant: 52),
            textIcon.heightAnchor.constraint(equalToConstant: 52)
        ]
        let textTitleDescriptionConstraints = [
            textTitleDescription.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 32),
            textTitleDescription.leadingAnchor.constraint(equalTo: textIcon.trailingAnchor, constant: 16),
            textTitleDescription.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 2),
            textTitleDescription.heightAnchor.constraint(equalToConstant: 32)
        ]
        let textDescriptionConstraints = [
            textDescription.topAnchor.constraint(equalTo: textTitleDescription.bottomAnchor, constant: 4),
            textDescription.leadingAnchor.constraint(equalTo: textIcon.trailingAnchor, constant: 16),
            textDescription.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 2 + 40),
            textDescription.heightAnchor.constraint(equalToConstant: 48)
        ]
        let bookIconConstraints = [
            bookIcon.topAnchor.constraint(equalTo: bookTitleDescription.topAnchor, constant: 16),
            bookIcon.leadingAnchor.constraint(equalTo: textIcon.leadingAnchor),
            bookIcon.widthAnchor.constraint(equalToConstant: 48),
            bookIcon.heightAnchor.constraint(equalToConstant: 48)
        ]
        let bookTitleDescriptionConstraints = [
            bookTitleDescription.topAnchor.constraint(equalTo: textDescription.bottomAnchor, constant: 24),
            bookTitleDescription.leadingAnchor.constraint(equalTo: textTitleDescription.leadingAnchor),
            bookTitleDescription.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 2),
            bookTitleDescription.heightAnchor.constraint(equalToConstant: 24)
        ]
        let bookDescriptionConstraints = [
            bookDescription.topAnchor.constraint(equalTo: bookTitleDescription.bottomAnchor, constant: 2),
            bookDescription.leadingAnchor.constraint(equalTo: bookTitleDescription.leadingAnchor),
            bookDescription.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 2 + 40),
            bookDescription.heightAnchor.constraint(equalToConstant: 72)
        ]
        let devicesIconConstraints = [
            devicesIcon.topAnchor.constraint(equalTo: devicesTitleDescription.topAnchor, constant: 36),
            devicesIcon.leadingAnchor.constraint(equalTo: textIcon.leadingAnchor, constant: -8),
            devicesIcon.widthAnchor.constraint(equalToConstant: 64),
            devicesIcon.heightAnchor.constraint(equalToConstant: 64)
        ]
        let devicesTitleDescriptionConstraints = [
            devicesTitleDescription.topAnchor.constraint(equalTo: bookDescription.bottomAnchor, constant: 24),
            devicesTitleDescription.leadingAnchor.constraint(equalTo: devicesIcon.trailingAnchor, constant: 16),
            devicesTitleDescription.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 2 + 40),
            devicesTitleDescription.heightAnchor.constraint(equalToConstant: 28)
        ]
        let devicesDescriptionConstraints = [
            devicesDescription.topAnchor.constraint(equalTo: devicesTitleDescription.bottomAnchor, constant: 4),
            devicesDescription.leadingAnchor.constraint(equalTo: devicesTitleDescription.leadingAnchor),
            devicesDescription.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 2 + 32),
            devicesDescription.heightAnchor.constraint(equalToConstant: 90)
        ]
        let continueButtonConstraints = [
            continueButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -24),
            continueButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            continueButton.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 2 + 40),
            continueButton.heightAnchor.constraint(equalToConstant: 48)
        ]
        NSLayoutConstraint.activate(welcomeLabelConstraints)
        NSLayoutConstraint.activate(textIconConstraints)
        NSLayoutConstraint.activate(textTitleDescriptionConstraints)
        NSLayoutConstraint.activate(textDescriptionConstraints)
        NSLayoutConstraint.activate(bookIconConstraints)
        NSLayoutConstraint.activate(bookTitleDescriptionConstraints)
        NSLayoutConstraint.activate(bookDescriptionConstraints)
        NSLayoutConstraint.activate(devicesIconConstraints)
        NSLayoutConstraint.activate(devicesTitleDescriptionConstraints)
        NSLayoutConstraint.activate(devicesDescriptionConstraints)
        NSLayoutConstraint.activate(continueButtonConstraints)
    }
    
    private func setupButtonAction() {
        continueButton.addTarget(self, action: #selector(continueButtonTapped), for: .touchUpInside)
    }
    
    @objc private func continueButtonTapped() {
        presenter.didTapContinueButton()
    }
}
