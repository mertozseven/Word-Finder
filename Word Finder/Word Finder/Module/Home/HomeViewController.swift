//
//  HomeViewController.swift
//  Word Finder
//
//  Created by Mert Ozseven on 7.06.2024.
//

import UIKit

// MARK: - HomeViewController Protocol
protocol HomeViewControllerProtocol: AnyObject {
    func setupTableView()
    func setupTextField()
    func reloadData()
    func showAlert()
}

final class HomeViewController: UIViewController {
    
    // MARK: - Properties
    var presenter: HomePresenterProtocol!
    private var recentSearches: [String] = []
    private var isWordEntered: Bool {
        return !searchTextField.text!.isEmpty
    }
    
    // MARK: - UI Components
    private let topView = WFTopView()
    
    private let searchTextField: UITextField = {
        let textField = UITextField()
        textField.layer.cornerRadius = 10
        textField.textColor = .label
        textField.tintColor = .label
        textField.textAlignment = .center
        textField.font = .preferredFont(forTextStyle: .title2)
        textField.adjustsFontSizeToFitWidth = true
        textField.minimumFontSize = 12
        textField.backgroundColor = .secondarySystemBackground
        textField.placeholder = "Enter a word here"
        textField.returnKeyType = .search
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }()
    
    private lazy var recentTableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(RecentCell.self, forCellReuseIdentifier: RecentCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        configureView()
    }
    
    // MARK: - Private Methods
    private func configureView() {
        addViews()
        configureLayout()
        view.backgroundColor = .systemBackground
        createDismissKeyboardTapGesture()
    }
    
    private func addViews() {
        view.addSubview(topView)
        view.addSubview(searchTextField)
        view.addSubview(recentTableView)
    }
    
    private func configureLayout() {
        let topViewConstraints = [
            topView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            topView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            topView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            topView.heightAnchor.constraint(equalToConstant: 136)
        ]
        let searchTextFieldConstraints = [
            searchTextField.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 16),
            searchTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            searchTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            searchTextField.heightAnchor.constraint(equalToConstant: 50)
        ]
        let recentTableViewConstraints = [
            recentTableView.topAnchor.constraint(equalTo: searchTextField.bottomAnchor, constant: 16),
            recentTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            recentTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            recentTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -16)
        ]
        
        NSLayoutConstraint.activate(topViewConstraints)
        NSLayoutConstraint.activate(searchTextFieldConstraints)
        NSLayoutConstraint.activate(recentTableViewConstraints)
    }
    
}

// MARK: - HomeViewControllerProtocol Extension
extension HomeViewController: HomeViewControllerProtocol {
    
    func setupTextField() {
        searchTextField.delegate = self
    }
    
    func showAlert() {
        presentWFAlertOnMainThread(alertTitle: "Please enter a word 📖", message: "Please enter the word you want to search for", buttonTitle: "Okay")
    }
    
    func setupTableView() {
        
    }
    
    func reloadData() {
        DispatchQueue.main.async {
            self.recentTableView.reloadData()
        }
    }
}

// MARK: - UITableViewDelegate Extension
extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didSelectRowAt(indexPath)
    }
}

// MARK: - UITableViewDataSource Extension
extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfItems()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RecentCell.identifier, for: indexPath) as? RecentCell else {
            return UITableViewCell()
        }
        
        cell.configure(recentWord: presenter.recentSearch(at: indexPath) ?? "")
        return cell
    }
}

// MARK: - UITextFieldDelegate Extension
extension HomeViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        guard let text = textField.text, !text.isEmpty else {
            showAlert()
            return false
        }
        presenter.searchWord(text)
        return true
    }
//    
//    func textFieldDidEndEditing(_ textField: UITextField) {
//        guard let text = textField.text, !text.isEmpty else {
//            showAlert()
//            return
//        }
//        presenter.searchWord(text)
//    }
}

