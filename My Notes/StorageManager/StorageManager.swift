import RealmSwift

let realm = try! Realm()

class StorageManager {
    static func saveObject(_ note: NoteModel) {
        try! realm.write {
            realm.add(note)
        }
    }
    
    static func deleteObject(_ note: NoteModel) {
        try! realm.write {
            realm.delete(note)
        }
    }
}
