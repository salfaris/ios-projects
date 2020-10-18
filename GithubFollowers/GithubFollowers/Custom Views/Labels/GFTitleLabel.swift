//
//  GFTitleLabel.swift
//  GithubFollowers
//
//  Created by Salman Faris on 04/10/2020.
//

import UIKit

class GFTitleLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    // Storyboard initiliazer
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // Use `convenience` so that we don't have to call configure() in this init
    convenience init(textAlignment: NSTextAlignment, fontSize: CGFloat) {
        self.init(frame: .zero)  // Here we call our designated init (which calls configure())
        self.textAlignment = textAlignment
        self.font = UIFont.systemFont(ofSize: fontSize, weight: .bold)
    }
    
    
    private func configure() {
        textColor = .label  // Black on dark, white on white mode.
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.9
        lineBreakMode = .byTruncatingTail  // When too long, how to break the text.
        translatesAutoresizingMaskIntoConstraints = false  // Use autolayout.
    }
}
