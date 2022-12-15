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
    }
}

extension NoteListViewController: UITableViewDelegate { }
extension NoteListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.getNotesCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
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
