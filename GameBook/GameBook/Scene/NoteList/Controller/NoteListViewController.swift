//
//  NoteListViewController.swift
//  GameBook
//
//  Created by Hasan Uysal on 15.12.2022.
//

import UIKit

final class NoteListViewController: BaseViewController {
    
    @IBOutlet private weak var noteListTableView: UITableView!
    
    private var viewModel: NoteListViewModelProtocol = NoteListViewModel()
    private var floatingButton = FloatingButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavBarTitle(view: self, title: "Notes")
        viewModel.delegate = self
        viewModel.getNotes()
        tableViewSetup()
        addTargetToButton()
        addSubviews()
    }
    
    private func addTargetToButton() {
        floatingButton.addTarget(self, action: #selector(floatingButtonTapped), for: .touchUpInside)
    }
    
    private func addSubviews(){
        view.addSubview(floatingButton)
    }
    
    @objc private func floatingButtonTapped(){
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "toNoteCreateUpdateView") as? NoteCreateUpdateViewController else {
            return
        }
        vc.viewModel.delegate = self
        self.present(vc, animated: true)
    }
    
    private func tableViewCellRegister() {
        noteListTableView.register(UINib(nibName: "NoteListTableViewCell", bundle: nil), forCellReuseIdentifier: "NoteListCell")
    }
    
    private func tableViewSetup() {
        noteListTableView.delegate = self
        noteListTableView.dataSource = self
        tableViewCellRegister()
    }
}

extension NoteListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "toNoteCreateUpdateView") as? NoteCreateUpdateViewController else {
            return
        }
        vc.viewModel.delegate = self
        vc.note = viewModel.getNote(index: indexPath.row)
        self.present(vc, animated: true)
    }
    
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
        showAlert(message: error.localizedDescription) {
            self.tabBarController?.selectedIndex = 0
        }
    }
}

extension NoteListViewController: NoteCreateUpdateViewModelDelegate {
    func noteSuccess() {
        viewModel.getNotes()
    }
    
    func noteFailed(error: Error) {
        showAlert(message: error.localizedDescription) { }
    }
}
