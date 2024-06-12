//
//  RecentCell.swift
//  Word Finder
//
//  Created by Mert Ozseven on 11.06.2024.
//

import UIKit

class RecentCell: UITableViewCell {
    
    // MARK: - Properties
    static let identifier = "RecentCell"
    
    // MARK: - UI Components
    private let magnifierIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "magnifyingglass")
        imageView.contentMode = .scaleAspectFill
        imageView.tintColor = .label
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private let recentWord = WFLabel(
        textAlignment: .left,
        textColor: .label,
        font: .preferredFont(forTextStyle: .title3),
        adjustsFontSizeToFitWidth: true
    )
    
    private let rightArrowIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "arrow.right")
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .label
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    // MARK: - Inits
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    public func configure(recentWord: String) {
        self.recentWord.text = recentWord
    }
    
    // MARK: - Private Methods
    private func configureView() {
        addViews()
        configureLayout()
    }
    
    private func addViews() {
        contentView.addSubview(magnifierIcon)
        contentView.addSubview(recentWord)
        contentView.addSubview(rightArrowIcon)
    }
    
    private func configureLayout() {
        let magnifierIconConstraints = [
            magnifierIcon.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            magnifierIcon.centerYAnchor.constraint(equalTo: centerYAnchor),
            magnifierIcon.widthAnchor.constraint(equalToConstant: 24),
            magnifierIcon.heightAnchor.constraint(equalToConstant: 24)
        ]
        let recentWordConstraints = [
            recentWord.leadingAnchor.constraint(equalTo: magnifierIcon.trailingAnchor, constant: 8),
            recentWord.trailingAnchor.constraint(equalTo: rightArrowIcon.leadingAnchor, constant: -8),
            recentWord.centerYAnchor.constraint(equalTo: centerYAnchor),
            recentWord.heightAnchor.constraint(equalToConstant: 24)
        ]
        let rightArrowIconConstraints = [
            rightArrowIcon.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            rightArrowIcon.centerYAnchor.constraint(equalTo: centerYAnchor),
            rightArrowIcon.widthAnchor.constraint(equalToConstant: 24),
            rightArrowIcon.heightAnchor.constraint(equalToConstant: 24)
        ]
        NSLayoutConstraint.activate(magnifierIconConstraints)
        NSLayoutConstraint.activate(recentWordConstraints)
        NSLayoutConstraint.activate(rightArrowIconConstraints)
    }
    
}
