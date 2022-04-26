import UIKit
import RealmSwift

class AllNotesTableViewController: UITableViewController {
    
    var notes: Results<NoteModel>!
    
    let label = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        notes = realm.objects(NoteModel.self)
        changeSafeArea()
        showHiddenEmptyLabel()
    }
    
    @IBAction func sortButton(_ sender: Any) {
        sortAlert()
    }
    
    @IBAction func unwindSegue(_ segue: UIStoryboardSegue) {
        guard let newNoteVC = segue.source as? NewNoteViewController else { return }
        newNoteVC.saveNote()
        tableView.reloadData()
    }
}
