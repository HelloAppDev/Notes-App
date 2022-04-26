import UIKit

extension AllNotesTableViewController {
    
    func changeSafeArea() {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithTransparentBackground()
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        navBarAppearance.backgroundColor = .blue
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        self.navigationItem.leftBarButtonItem = self.editButtonItem
        self.navigationItem.leftBarButtonItem?.title = "Изм."
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        self.editButtonItem.title = editing ? "Готово" : "Изм."
    }
    
    func sortAlert() {
        let ac = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let sortName = UIAlertAction(title: "Сортировка по названию", style: .default, handler: { [self] _ in
            notes = realm.objects(NoteModel.self).sorted(byKeyPath: "noteName", ascending: true)
            tableView.reloadData()
        })
        let sortDate = UIAlertAction(title: "Сортировка по дате добавления", style: .default, handler: { [self] _ in
            notes = realm.objects(NoteModel.self).sorted(byKeyPath: "noteAddingDate", ascending: false)
            tableView.reloadData()
        })
        let cancel = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        
        ac.addAction(sortName)
        ac.addAction(sortDate)
        ac.addAction(cancel)
        present(ac, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editSegue" {
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            let note = notes[indexPath.row]
            let newNoteVC = segue.destination as! NewNoteViewController
            newNoteVC.currentNote = note
        }
    }
    
    func showHiddenEmptyLabel() {
        setupLabelConstraints()
        label.textAlignment = NSTextAlignment.center
        label.text = "Добавьте заметку"
        label.textColor = .darkGray
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        label.isHidden = true
    }
    
    func setupLabelConstraints() {
        view.addSubview(label)
        
        label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -130).isActive = true
    }
}
