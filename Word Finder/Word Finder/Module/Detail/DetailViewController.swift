//
//  DetailViewController.swift
//  Word Finder
//
//  Created by Mert Ozseven on 12.06.2024.
//

import UIKit

protocol DetailViewControllerProtocol: AnyObject {
    func displayWordDetail(_ word: WordEntity)
}

final class DetailViewController: UIViewController {
    var presenter: DetailPresenterProtocol!
    
    // MARK: - UI Components
    private let wordLabel = WFLabel()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        presenter.viewDidLoad()
    }
    
    // MARK: - Private Methods
    private func configureView() {
        view.backgroundColor = .white
        setupUIComponents()
        setupConstraints()
    }
    
    private func setupUIComponents() {
        wordLabel.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(wordLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            wordLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            wordLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            wordLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])
    }
}

extension DetailViewController: DetailViewControllerProtocol {
    func displayWordDetail(_ word: WordEntity) {
        wordLabel.text = word.word
    }
}
