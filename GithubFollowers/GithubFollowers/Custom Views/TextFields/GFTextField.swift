//
//  GFTextField.swift
//  GithubFollowers
//
//  Created by Salman Faris on 04/10/2020.
//

import UIKit

class GFTextField: UITextField {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    // Storyboard initiliazer (XCode yells)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false  // Use auto layout
        
        // Border
        layer.cornerRadius = 10
        layer.borderWidth = 2
        layer.borderColor = UIColor.systemGray4.cgColor
        
        // Text
        textColor = .label  // Black in white mode, White in dark mode
        tintColor = .label  // Color of blinking cursor
        textAlignment = .center
        font = UIFont.preferredFont(forTextStyle: .title2)
        adjustsFontSizeToFitWidth = true
        minimumFontSize = 12
        
        // Misc.
        backgroundColor = .tertiarySystemBackground
        autocorrectionType = .no  // Turn autocorrect off
        returnKeyType = .go
        clearButtonMode = .whileEditing  // Allow quick clear in textfield
        placeholder = "Enter a username"
    }
}
