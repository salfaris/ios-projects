//
//  UserInfoVC.swift
//  GithubFollowers
//
//  Created by Salman Faris on 16/10/2020.
//

import UIKit

class UserInfoVC: UIViewController {
    
    var username: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem = doneButton
        
        guard let username = username else { return }
        print(username)
    }
    
    
    @objc func dismissVC() {
        dismiss(animated: true)
    }
}
