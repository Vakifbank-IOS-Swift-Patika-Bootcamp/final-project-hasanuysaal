//
//  NoteListViewController.swift
//  GameBook
//
//  Created by Hasan Uysal on 15.12.2022.
//

import UIKit

class NoteListViewController: BaseViewController {

    @IBOutlet weak var noteListTableView: UITableView!
    
    var viewModel: NoteListViewModelProtocol = NoteListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavBarTitle(view: self, title: "Notes")
        tableViewSetup()
        viewModel.delegate = self
        viewModel.getNotes()
    }
    
    func tableViewSetup() {
        noteListTableView.delegate = self
        noteListTableView.dataSource = self
        tableViewCellRegister()
    }
    
    func tableViewCellRegister() {
        noteListTableView.register(UINib(nibName: "NoteListTableViewCell", bundle: nil), forCellReuseIdentifier: "NoteListCell")
    }
}

extension NoteListViewController: UITableViewDelegate { }
extension NoteListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.getNotesCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = noteListTableView.dequeueReusableCell(withIdentifier: "NoteListCell", for: indexPath) as? NoteListTableViewCell, let noteModel = viewModel.getNote(index: indexPath.row) else {
            return UITableViewCell()
        }
        cell.configure(noteModel: noteModel)
        return cell
    }
}

extension NoteListViewController: NoteListViewModelDelegate {
    func notesLoaded() {
        noteListTableView.reloadData()
    }
    
    func notesFailed(error: Error) {
        //
    }
    
    
}
