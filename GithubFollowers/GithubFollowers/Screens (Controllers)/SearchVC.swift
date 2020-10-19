//
//  SearchVC.swift
//  GithubFollowers
//
//  Created by Salman Faris on 03/10/2020.
//z

import UIKit

class SearchVC: UIViewController {

    let logoImageView = UIImageView()
    let usernameTextField = GFTextField()
    let callToActionButton = GFButton(backgroundColor: .systemGreen, title: "Get Followers")
    
    var isUsernameEntered: Bool {
        return !usernameTextField.text!.isEmpty
    }
    
    // Called when view is loaded the first time
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground  // White if white mode, black if dark mode.
        
        // Storyboard equivalent to grabbing UIImageView from library, drag and drop to ViewController
        view.addSubviews(logoImageView, usernameTextField, callToActionButton)
        
        configureLogoImageView()
        configureTextField()
        configureCallToActionButton()
        createDismissKeyboardTapGesture()
    }
    
    
    // Called everytime the view appears
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        usernameTextField.text = ""
        navigationController?.setNavigationBarHidden(true, animated: true)  // Hide the navigation bar
    }
    
    // DIsmiss the keyboard by tapping elsewhere.
    func createDismissKeyboardTapGesture() {
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
    
    
    // Passing the data to FollowerListVC.
    @objc func pushFollowerListVC() {
        guard isUsernameEntered else {
            presentGFAlertOnMainThread(title: "Empty Username", message: "Please enter a username. We need to know who to look for 😅.", buttonTitle: "Ok")
            return
        }
        
        usernameTextField.resignFirstResponder()
        
        let followerListVC = FollowerListVC(username: usernameTextField.text!)
        navigationController?.pushViewController(followerListVC, animated: true)  // Push this VC onto the stack
    }
    
    
    func configureLogoImageView() {
        logoImageView.translatesAutoresizingMaskIntoConstraints = false  // Use auto layout
        logoImageView.image = Images.ghLogo
        
        let topConstraintConstant: CGFloat = DeviceTypes.isiPhoneSE || DeviceTypes.isiPhone8Zoomed ? 20 : 80
        
        // Rule of thumb: 4 constraints per object (height, width, x-coord, y-coord)
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: topConstraintConstant),  // y-coord
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),  // x-coord
            logoImageView.heightAnchor.constraint(equalToConstant: 200),  // Height
            logoImageView.widthAnchor.constraint(equalToConstant: 200)  // Width
        ])
    }
    
    
    func configureTextField() {
        // Sets the delegate: Tells the ViewController to listen to usernameTextField
        // "Hey listen to me" code
        usernameTextField.delegate = self
        
        NSLayoutConstraint.activate([
            usernameTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 48),  // y-coord
            
            // These two determines the width and x-coord
            usernameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            usernameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            
            usernameTextField.heightAnchor.constraint(equalToConstant: 50)  // Height
        ])
    }
    
    
    func configureCallToActionButton() {
        // When callToActionButton button is tapped, call pushFollowerListVC
        callToActionButton.addTarget(self, action: #selector(pushFollowerListVC), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            callToActionButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            callToActionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            callToActionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            callToActionButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}


extension SearchVC: UITextFieldDelegate {
    // The return key (on keyboard) listener (delegate)
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        pushFollowerListVC()
        return true
    }
}


