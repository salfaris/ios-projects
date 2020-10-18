//
//  GFSecondaryTitleLabel.swift
//  GithubFollowers
//
//  Created by Salman Faris on 16/10/2020.
//

import UIKit

class GFSecondaryTitleLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    // Storyboard initiliazer
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // Custom initializer
    convenience init(fontSize: CGFloat) {
        self.init(frame: .zero)
        font = UIFont.systemFont(ofSize: fontSize, weight: .medium)
    }
    
    
    private func configure() {
        textColor = .secondaryLabel
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.90
        lineBreakMode = .byTruncatingTail  // When too long, how to break the text.
        translatesAutoresizingMaskIntoConstraints = false  // Use autolayout.
    }
}
