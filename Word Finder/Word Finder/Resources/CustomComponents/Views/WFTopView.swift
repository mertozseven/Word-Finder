//
//  WFTopView.swift
//  Word Finder
//
//  Created by Mert Ozseven on 11.06.2024.
//

import UIKit

class WFTopView: UIView {

    // MARK: - UI Components
    private let titleLabel = WFLabel(
        text: "Word\nFinder",
        textAlignment: .left,
        textColor: .label,
        font: .systemFont(ofSize: 44, weight: .black),
        numberOfLines: 0
    )
    
    private let dateLabel = WFLabel(
        text: "",
        textAlignment: .left,
        textColor: .secondaryLabel,
        font: .systemFont(ofSize: 24, weight: .heavy)
    )
    
    // MARK: - Inits
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private methods
    private func configureView() {
        backgroundColor = .clear
        translatesAutoresizingMaskIntoConstraints = false
        addViews()
        configureLayout()
        configureWithCurrentDateAndGreeting()
    }
    
    private func addViews() {
        addSubview(titleLabel)
        addSubview(dateLabel)
    }
    
    private func configureLayout() {
        let titleLabelConstraints = [
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 106)
        ]
        let dateLabelConstraints = [
            dateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            dateLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            dateLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            dateLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ]
        NSLayoutConstraint.activate(titleLabelConstraints)
        NSLayoutConstraint.activate(dateLabelConstraints)
    }
    
    private func configureWithCurrentDateAndGreeting() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = " E d MMM"
        let currentDate = dateFormatter.string(from: Date())
        dateLabel.text = currentDate
    }

}
