import UIKit

class NewNoteViewController: UITableViewController {
    
    let currentDate = Date()
    let dateFormatter = DateFormatter()
    
    var imageIsChanged = false
    var currentNote: NoteModel!
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var noteImageView: UIImageView!
    @IBOutlet weak var noteNameTF: UITextField!
    @IBOutlet weak var noteDescriptionTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        noteNameTF.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        
        setupEditScreen()
    }
}
