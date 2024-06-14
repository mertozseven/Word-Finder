//
//  MeaningView.swift
//  Word Finder
//
//  Created by Mert Ozseven on 13.06.2024.
//

import UIKit

class MeaningView: UIView {
    
    // MARK: - Properties
    var partOfSpeech: String = ""
    private var definitions: [Definition] = [] {
        didSet {
            meaningTableView.reloadData()
            updateHeight()
        }
    }

    // MARK: - UI Components
    private let partOfSpeechLabel = WFLabel(
        text: "",
        textAlignment: .left,
        textColor: .label,
        font: .preferredFont(forTextStyle: .title3),
        adjustsFontSizeToFitWidth: true,
        minimumScaleFactor: 0.5,
        lineBreakMode: .byWordWrapping
    )
    
    private lazy var meaningTableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MeaningCell.self, forCellReuseIdentifier: MeaningCell.identifier)
        tableView.backgroundColor = .secondarySystemBackground
        tableView.layer.cornerRadius = 10
        tableView.isScrollEnabled = false
        tableView.isUserInteractionEnabled = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    
    private var tableViewHeightConstraint: NSLayoutConstraint?

    // MARK: - Inits
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    public func configure(partOfSpeech: String, definitions: [Definition]) {
        self.partOfSpeech = partOfSpeech
        self.partOfSpeechLabel.text = partOfSpeech
        self.definitions = definitions
    }
    
    // MARK: - Private Methods
    private func configureView() {
        addViews()
        configureLayout()
        translatesAutoresizingMaskIntoConstraints = false
        addTableViewHeightObserver()
    }
    
    private func addViews() {
        addSubview(partOfSpeechLabel)
        addSubview(meaningTableView)
    }
    
    private func configureLayout() {
        NSLayoutConstraint.activate([
            partOfSpeechLabel.topAnchor.constraint(equalTo: topAnchor),
            partOfSpeechLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            partOfSpeechLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            partOfSpeechLabel.heightAnchor.constraint(equalToConstant: 24),
            
            meaningTableView.topAnchor.constraint(equalTo: partOfSpeechLabel.bottomAnchor, constant: 8),
            meaningTableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            meaningTableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            meaningTableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        tableViewHeightConstraint = meaningTableView.heightAnchor.constraint(equalToConstant: 0)
        tableViewHeightConstraint?.isActive = true
    }
    
    private func addTableViewHeightObserver() {
        meaningTableView.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
    }
    
    deinit {
        meaningTableView.removeObserver(self, forKeyPath: "contentSize")
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "contentSize", let newValue = change?[.newKey] as? CGSize {
            tableViewHeightConstraint?.constant = newValue.height
        }
    }
    
    private func updateHeight() {
        meaningTableView.reloadData()
        meaningTableView.layoutIfNeeded()
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource Methods
extension MeaningView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return definitions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MeaningCell.identifier, for: indexPath) as? MeaningCell else {
            return UITableViewCell()
        }
        let definition = definitions[indexPath.row]
        cell.configure(definition: definition.definition ?? "", example: definition.example ?? "")
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
