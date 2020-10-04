//
//  SearchVC.swift
//  GithubFollowers
//
//  Created by Salman Faris on 03/10/2020.
//

import UIKit

class SearchVC: UIViewController {

    let logoImageView = UIImageView()
    let usernameTextField = GFTextField()
    let callToActionButton = GFButton(backgroundColor: .systemGreen, title: "Get Followers")
    
    
    // Called when view is loaded the first time
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground  // White if white mode, black if dark mode.
        configureLogoImageView()
        configureTextField()
        configureCallToActionButton()
    }
    
    
    // Called everytime the view appears
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true  // Hide the navigation bar
    }
    
    
    func configureLogoImageView() {
        // Storyboard equivalent to grabbing UIImageView from library, drag and drop to ViewController
        view.addSubview(logoImageView)
        
        logoImageView.translatesAutoresizingMaskIntoConstraints = false  // Use auto layout
        logoImageView.image = UIImage(named: "gh-logo")!
        
        // Rule of thumb: 4 constraints per object (height, width, x-coord, y-coord)
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),  // y-coord
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),  // x-coord
            logoImageView.heightAnchor.constraint(equalToConstant: 200),  // Height
            logoImageView.widthAnchor.constraint(equalToConstant: 200)  // Width
        ])
    }
    
    
    func configureTextField() {
        // Storyboard drag and drop
        view.addSubview(usernameTextField)
        
        NSLayoutConstraint.activate([
            usernameTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 48),  // y-coord
            
            // These two determines the width and x-coord
            usernameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            usernameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            
            usernameTextField.heightAnchor.constraint(equalToConstant: 50)  // Height
        ])
    }
    
    
    func configureCallToActionButton() {
        view.addSubview(callToActionButton)
        
        NSLayoutConstraint.activate([
            callToActionButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            callToActionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            callToActionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            callToActionButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
