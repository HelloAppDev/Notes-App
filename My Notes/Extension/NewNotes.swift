import UIKit

extension NewNoteViewController {
    
    func setupEditScreen() {
        
        saveButton.isEnabled = false
        dateFormatter.dateFormat = "dd.MM.yyyy"
        dateFormatter.defaultDate = .now
        
        if currentNote != nil {
            setupNavBar()
            imageIsChanged = true
            guard let data = currentNote.noteImageData, let image = UIImage(data: data) else { return }
            
            noteImageView.image = image
            noteImageView.contentMode = .scaleAspectFill
            noteNameTF.text = currentNote.noteName
            noteDescriptionTF.text = currentNote.noteDescription
        }
        
        func setupNavBar() {
            if let topItem = navigationController?.navigationBar.topItem {
                topItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
            }
            title = currentNote.noteName
            saveButton.isEnabled = true
        }
    }
    
    func saveNote() {
        
        var image: UIImage?
        
        if imageIsChanged {
            image = noteImageView.image
        } else {
            image = #imageLiteral(resourceName: "no image")
        }
        let imageData = image?.pngData()
        let newNote = NoteModel(noteName: noteNameTF.text!,
                                noteDescription: noteDescriptionTF.text,
                                noteImageData: imageData,
                                noteAddingDate: "\(dateFormatter.string(from: currentDate as Date))",
                                noteEditingDate: "")
        
        if currentNote != nil {
            try! realm.write {
                currentNote.noteName = newNote.noteName
                currentNote.noteDescription = newNote.noteDescription ?? ""
                currentNote.noteImageData = newNote.noteImageData
                currentNote.noteEditingDate = "Ред. \(dateFormatter.string(from: currentDate as Date))"
            }
        } else {
            StorageManager.saveObject(newNote)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editSegue" {
            currentNote.noteName = noteNameTF.text!
            currentNote.noteDescription = noteDescriptionTF.text
            currentNote.noteImageData = noteImageView.image?.pngData()
        }
    }
}

extension NewNoteViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @objc func textFieldChanged() {
        if noteNameTF.text?.isEmpty == false {
            saveButton.isEnabled = true
        } else {
            saveButton.isEnabled = false
        }
    }
}

//MARK: work with image

extension NewNoteViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func chooseImagePicker(source: UIImagePickerController.SourceType) {
        if UIImagePickerController.isSourceTypeAvailable(source) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = source
            present(imagePicker, animated: true)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        noteImageView.image = info[.editedImage] as? UIImage
        noteImageView.contentMode = .scaleAspectFill
        noteImageView.clipsToBounds = true
        imageIsChanged = true
        dismiss(animated: true)
    }
}
