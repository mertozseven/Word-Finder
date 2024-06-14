//
//  MeaningCell.swift
//  Word Finder
//
//  Created by Mert Ozseven on 13.06.2024.
//

import UIKit

class MeaningCell: UITableViewCell {

    // MARK: - Properties
    static let identifier = "MeaningCell"
    
    // MARK: - UI Components
    private let definitionLabel = WFLabel(
        text: "",
        textAlignment: .left,
        textColor: .label,
        font: .preferredFont(forTextStyle: .body),
        backgroundColor: .clear,
        numberOfLines: 0,
        adjustsFontSizeToFitWidth: true,
        minimumScaleFactor: 0.8,
        lineBreakMode: .byWordWrapping
    )
    
    private let exampleTitleLabel = WFLabel(
        text: "Example",
        textAlignment: .left,
        textColor: .label,
        font: .preferredFont(forTextStyle: .headline),
        backgroundColor: .clear
    )
    
    private let exampleLabel = WFLabel(
        text: "",
        textAlignment: .left,
        textColor: .secondaryLabel,
        font: .preferredFont(forTextStyle: .body),
        backgroundColor: .clear,
        numberOfLines: 0,
        adjustsFontSizeToFitWidth: true,
        minimumScaleFactor: 0.8,
        lineBreakMode: .byWordWrapping
    )

    // MARK: - Inits
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    public func configure(definition: String, example: String) {
        self.definitionLabel.text = definition.isEmpty ? nil : definition
        let isExampleEmpty = example.isEmpty
        self.exampleTitleLabel.isHidden = isExampleEmpty
        self.exampleLabel.text = isExampleEmpty ? nil : example
        self.exampleLabel.isHidden = isExampleEmpty
    }
    
    // MARK: - Private Methods
    private func configureView() {
        addViews()
        configureLayout()
        contentView.backgroundColor = .clear
        backgroundColor = .clear
    }
    
    private func addViews() {
        contentView.addSubview(definitionLabel)
        contentView.addSubview(exampleTitleLabel)
        contentView.addSubview(exampleLabel)
    }
    
    private func configureLayout() {
        definitionLabel.translatesAutoresizingMaskIntoConstraints = false
        exampleTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        exampleLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            definitionLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            definitionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            definitionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            exampleTitleLabel.topAnchor.constraint(equalTo: definitionLabel.bottomAnchor, constant: 16),
            exampleTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            exampleTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            exampleTitleLabel.heightAnchor.constraint(equalToConstant: 18),
            
            exampleLabel.topAnchor.constraint(equalTo: exampleTitleLabel.bottomAnchor, constant: 8),
            exampleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            exampleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            exampleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])
    }

}
