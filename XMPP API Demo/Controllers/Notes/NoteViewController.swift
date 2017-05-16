//
//  NoteViewController.swift
//  XMPP API Demo
//
//  Created by Valio Cholakov on 5/16/17.
//  Copyright © 2017 Valentin Cholakov. All rights reserved.
//

import UIKit

class NoteViewController: BaseViewController {
    
    // MARK: Outlets
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var contentTextView: UITextView!
    
    
    // MARK: Variables
    
    var note: Note?
    var delegate: NoteDelegate?
    private var _noteId: Int = 0
    
    
    // MARK: Controller Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setData()
    }
    
    override func localize() {
        super.localize()
        
        self.navigationItem.title = NSLocalizedString(self.note == nil ? "Add note" : "Edit note", comment: "")
    }
    
    override func goBack() {
        self.hideLoadingHUD()
        
        super.goBack()
    }
    
    
    // MARK: Actions
    
    @IBAction func save(_ sender: Any) {
        if !self.formIsValid {
            UIAlertController.showEmptyFieldsErrorMessage(self)
            return
        }
        
        self.showLoadingHUD()
        self.note == nil ? CommunicationManager.addNote(self.noteFromInterface)
                         : CommunicationManager.updateNote(self.noteFromInterface)
    }
    
    
    // MARK: Communication Delegate
    
    func didAddNote(_ noteId: Int) {
        _noteId = noteId
        
        self.delegate?.didAddNote(self.noteFromInterface)
        self.goBack()
    }
    
    func didUpdateNote() {
        self.delegate?.didUpdateNote(self.noteFromInterface)
        self.goBack()
    }
    
    
    // MARK: Private Methods
    
    private func setData() {
        guard let note = self.note else {
            return
        }
        
        self.titleTextField.text  = note.title
        self.contentTextView.text = note.content
    }
    
    
    // MARK: Helpers
    
    private var formIsValid: Bool {
        return !self.titleTextField.isEmpty && self.contentTextView.text.trimmed.length > 0
    }
    
    private var noteFromInterface: Note {
        return Note(json: [
            Parameters.id      : self.note?.id ?? _noteId,
            Parameters.title   : self.titleTextField.text ?? "",
            Parameters.content : self.contentTextView.text
            ]
        )
    }
}

protocol NoteDelegate {
    func didAddNote(_ note: Note)
    func didUpdateNote(_ note: Note)
}
