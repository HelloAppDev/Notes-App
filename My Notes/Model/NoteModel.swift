import RealmSwift

class NoteModel: Object {
    
    @objc dynamic var noteName = ""
    @objc dynamic var noteDescription: String?
    @objc dynamic var noteImageData: Data?
    @objc dynamic var noteAddingDate = ""
    @objc dynamic var noteEditingDate = ""
    
    convenience init(noteName: String, noteDescription: String?, noteImageData: Data?, noteAddingDate: String, noteEditingDate: String) {
        
        self.init()
        self.noteName = noteName
        self.noteDescription = noteDescription
        self.noteImageData = noteImageData
        self.noteAddingDate = noteAddingDate
    }
}
