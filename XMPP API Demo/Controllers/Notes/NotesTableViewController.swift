//
//  NotesTableViewController.swift
//  XMPP API Demo
//
//  Created by Valio Cholakov on 5/16/17.
//  Copyright © 2017 Valentin Cholakov. All rights reserved.
//

import UIKit

class NotesTableViewController: BaseTableViewController, NoteDelegate {
    
    // MARK: Constants
    
    private let kCellIdentifier = "NoteCell"
    
    
    // MARK: Variables
    
    private var _notes: [Note]?
    private var _indexPathToDelete: IndexPath?
    
    
    // MARK: Controller Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.applyTheme()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.fetchNotes()
    }
    
    
    // MARK: Table View Data Source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return _notes?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = tableView.dequeueReusableCell(withIdentifier: kCellIdentifier, for: indexPath) as! NoteTableViewCell
        cell.note = _notes?[indexPath.row]
        return cell
    }
    
    
    // MARK: Table View Delegate
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .delete
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle != .delete {
            return
        }
        
        self.deleteNoteAtIndexPath(indexPath)
    }
    
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let noteController = segue.destination as? NoteViewController {
            noteController.delegate = self
            noteController.note     = self.selectedNote
        }
    }
    
    
    // MARK: Note Delegate
    
    func didAddNote(_ note: Note) {
        _notes?.append(note)
        self.tableView.reloadData()
    }
    
    func didUpdateNote(_ note: Note) {
        guard let idx = _notes?.index(of: note) else {
            return
        }
        
        _notes?.remove(at: idx)
        _notes?.insert(note, at: idx)
        
        self.tableView.reloadData()
    }
    
    
    // MARK: Communication Delegate
    
    func didGetNotes(_ notes: [Note]) {
        _notes = notes
        
        self.tableView.reloadData()
        self.hideLoadingHUD()
    }
    
    func didDeleteNote() {
        self.hideLoadingHUD()
        
        guard let deletedIndexPath = _indexPathToDelete else {
            return
        }
        
        _notes?.remove(at: deletedIndexPath.row)
        
        self.tableView.beginUpdates()
        self.tableView.deleteRows(at: [deletedIndexPath], with: .fade)
        self.tableView.endUpdates()
        self.tableView.setEditing(false, animated: true)
        
        _indexPathToDelete = nil
    }
    
    
    // MARK: Private Methods
    
    private func applyTheme() {
        self.tableView.tableFooterView = UIView()
        self.tableView.backgroundColor = .backgroundGray
    }
    
    private func fetchNotes() {
        self.showLoadingHUD()
        CommunicationManager.getNotes()
    }
    
    private func deleteNoteAtIndexPath(_ indexPath: IndexPath) {
        guard let note = _notes?[indexPath.row] else {
            return
        }
        
        _indexPathToDelete = indexPath
        
        self.showLoadingHUD()
        CommunicationManager.deleteNote(note)
    }
    
    
    // MARK: Helpers
    
    private var selectedNote: Note? {
        guard let selecterIndexPath = self.tableView.indexPathForSelectedRow else {
            return nil
        }
        
        return _notes?[selecterIndexPath.row]
    }
}
