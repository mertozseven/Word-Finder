//
//  WFButton.swift
//  Word Finder
//
//  Created by Mert Ozseven on 7.06.2024.
//

import UIKit

class WFButton: UIButton {

    // MARK: - inits
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(
        backgroundColor: UIColor = .red,
        title: String,
        titleState: UIControl.State = .normal,
        font: UIFont,
        cornerRadius: CGFloat = 10,
        titleColor: UIColor = UIColor.white,
        colorState: UIControl.State = .normal
    ) {
        super.init(frame: .zero)
        self.backgroundColor = backgroundColor
        self.setTitle(title, for: titleState)
        self.titleLabel?.font = font
        self.layer.cornerRadius = cornerRadius
        self.setTitleColor(titleColor, for: colorState)
        configure()
    }
    
    // MARK: - Private Methods
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
    }

}
