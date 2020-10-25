//
//  NoteViewController.swift
//  Notes
//
//  Created by Salman Faris on 25/10/2020.
//

import UIKit

class NoteViewController: UIViewController {
    
    var note: Note!
    
    @IBOutlet var textView: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        note.contents = textView.text
        NoteManager.main.saveNote(for: note)
    }
    
    
    func configure() {
        textView.text = note.contents
    }
}
