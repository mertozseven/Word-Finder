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
    func showAlert(alertTitle: String, message: String, buttonTitle: String)
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
        textField.autocorrectionType = .no
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
    
    private let searchButton = WFButton(
        backgroundColor: .systemBlue,
        title: "Search",
        titleState: .normal,
        font: .preferredFont(forTextStyle: .headline),
        cornerRadius: 10,
        titleColor: .white,
        colorState: .normal
    )
    
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
        setupKeyboardObservers()
        createDismissKeyboardTapGesture()
        searchButtonTapped()
        view.backgroundColor = .systemBackground
    }
    
    private func addViews() {
        view.addSubview(topView)
        view.addSubview(searchTextField)
        view.addSubview(recentTableView)
        view.addSubview(searchButton)
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
            recentTableView.bottomAnchor.constraint(equalTo: searchButton.topAnchor, constant: -16)
        ]
        let searchButtonConstraints = [
            searchButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -32),
            searchButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 80),
            searchButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -80),
            searchButton.heightAnchor.constraint(equalToConstant: 50)
        ]
        
        NSLayoutConstraint.activate(topViewConstraints)
        NSLayoutConstraint.activate(searchTextFieldConstraints)
        NSLayoutConstraint.activate(recentTableViewConstraints)
        NSLayoutConstraint.activate(searchButtonConstraints)
    }
    
    private func performSearch() {
        guard let text = searchTextField.text, !text.isEmpty else {
            showAlert(alertTitle: "Please enter a word 📖", message: "Please enter the word you want to search for", buttonTitle: "Okay")
            return
        }
        presenter.searchWord(text)
    }
    
    private func setupKeyboardObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func adjustSearchButtonPosition(keyboardHeight: CGFloat) {
        UIView.animate(withDuration: 0.3) {
            self.searchButton.transform = CGAffineTransform(translationX: 0, y: -keyboardHeight)
            self.view.layoutIfNeeded()
        }
    }
    
    private func searchButtonTapped() {
        searchButton.addTarget(self, action: #selector(searchButtonAction), for: .touchUpInside)
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(searchButtonAction))
        searchButton.addGestureRecognizer(tapGestureRecognizer)
    }
    
    // MARK: - Objective Methods
    @objc private func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
            let keyboardHeight = keyboardFrame.height - 16
            adjustSearchButtonPosition(keyboardHeight: keyboardHeight)
        }
    }

    @objc private func keyboardWillHide(_ notification: Notification) {
        adjustSearchButtonPosition(keyboardHeight: 0)
    }
    
    @objc private func searchButtonAction() {
        performSearch()
    }
}

// MARK: - HomeViewControllerProtocol Extension
extension HomeViewController: HomeViewControllerProtocol {
    
    func setupTextField() {
        searchTextField.delegate = self
    }
    
    func showAlert(alertTitle: String, message: String, buttonTitle: String) {
        let alert = UIAlertController(title: alertTitle, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: buttonTitle, style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    func setupTableView() {
        // Ensure table view setup if needed
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
        tableView.deselectRow(at: indexPath, animated: true)
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
        performSearch()
        return true
    }
}
