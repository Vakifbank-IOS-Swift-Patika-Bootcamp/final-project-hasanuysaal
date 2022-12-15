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
    var floatingButton = FloatingButton()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavBarTitle(view: self, title: "Notes")
        tableViewSetup()
        viewModel.delegate = self
        viewModel.getNotes()
        addTargetToButton()
        addSubviews()
    }
    
    func addTargetToButton() {
        floatingButton.addTarget(self, action: #selector(floatingButtonTapped), for: .touchUpInside)
    }
    
    func addSubviews(){
        view.addSubview(floatingButton)
    }
    
    @objc func floatingButtonTapped(){
        print("floatingButtonTapped")
    }
    
    func tableViewCellRegister() {
        noteListTableView.register(UINib(nibName: "NoteListTableViewCell", bundle: nil), forCellReuseIdentifier: "NoteListCell")
    }
    
    func tableViewSetup() {
        noteListTableView.delegate = self
        noteListTableView.dataSource = self
        tableViewCellRegister()
    }

}

extension NoteListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (action, sourceView, completionHandler) in
            self.viewModel.deleteNote(index: indexPath.row)
            self.viewModel.getNotes()
            completionHandler(true)
        }
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
}
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
