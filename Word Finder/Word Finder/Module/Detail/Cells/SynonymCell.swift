//
//  SynonymCell.swift
//  Word Finder
//
//  Created by Mert Ozseven on 13.06.2024.
//

import UIKit

class SynonymCell: UICollectionViewCell {
    
    // MARK: - Properties
    static let identifier = "SynonymCell"
    
    // MARK: - UI Components
    private let synonymLabel = WFLabel(
        text: "",
        textAlignment: .center,
        textColor: .label,
        font: .preferredFont(forTextStyle: .headline),
        backgroundColor: .secondarySystemBackground,
        clipsToBounds: true,
        cornerRadius: 12,
        adjustsFontSizeToFitWidth: true,
        minimumScaleFactor: 0.5
    )
    
    // MARK: - Inits
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    public func configure(synonym: String) {
        self.synonymLabel.text = synonym
    }
    
    // MARK: - Private Methods
    private func configureView() {
        addViews()
        configureLayout()
    }
    
    private func addViews() {
        contentView.addSubview(synonymLabel)
    }
    
    private func configureLayout() {
        let synonymLabelConstraints = [
            synonymLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            synonymLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            synonymLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            synonymLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
        ]
        NSLayoutConstraint.activate(synonymLabelConstraints)
    }
    
    // MARK: - Handle reuse
    override func prepareForReuse() {
        super.prepareForReuse()
        synonymLabel.text = nil
    }
    
}
