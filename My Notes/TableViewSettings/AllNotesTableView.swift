import UIKit

extension AllNotesTableViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! NotesTableViewCell
        
        let note = notes[indexPath.row]
        cell.noteNameLabel.text = note.noteName
        cell.noteDescrLabel.text = note.noteDescription
        cell.mainNoteImage.image = UIImage(data: note.noteImageData!)
        cell.additionLabel.text = note.noteAddingDate
        cell.editingLabel.text = note.noteEditingDate
        
        cell.mainNoteImage.layer.cornerRadius = cell.mainNoteImage.frame.size.height / 2
        cell.mainNoteImage.clipsToBounds = true
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            StorageManager.deleteObject(notes[indexPath.row])
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
            if notes.count == 0 {
                label.isHidden = false
                tableView.separatorStyle = .none
            } else {
                label.isHidden = true
                tableView.separatorStyle = .singleLine
            }
            return 1
        }
}
