//
//  CoreDataManager.swift
//  GameBook
//
//  Created by Hasan Uysal on 14.12.2022.
//

import UIKit
import CoreData

final class CoreDataManager {
    static let shared = CoreDataManager()
    private let managedContext: NSManagedObjectContext!
    
    private init() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        managedContext = appDelegate.persistentContainer.viewContext
    }
    
    @discardableResult
    func saveFavoriteId(id: Int?) -> Favorite? {
        let entity = NSEntityDescription.entity(forEntityName: "Favorite", in: managedContext)!
        let favorite = NSManagedObject(entity: entity, insertInto: managedContext)
        favorite.setValue(id, forKeyPath: "id")
        
        do {
            try managedContext.save()
            return favorite as? Favorite
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        return nil
    }
    
    func getFavoritesId() -> [Int] {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Favorite")
        
        do {
            let favorites = try managedContext.fetch(fetchRequest)
            let ids = favorites.map { $0.value(forKey: "id") }
            return ids as! [Int]
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        return []
    }
    
    func getFavoriteGame(id: Int?) -> Favorite? {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Favorite")
        
        do {
            let favorites = try managedContext.fetch(fetchRequest)
            let favoriteGame = favorites.filter { $0.value(forKey: "id") as? Int == id }
            if favoriteGame.isEmpty {
                return nil
            } else {
                return favoriteGame.first as? Favorite
                
            }
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        return nil
    }
    
    func deleteFavoriteId(favorite: Favorite) {
        
        managedContext.delete(favorite)
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    @discardableResult
        func updateNote(image: Data, gameName: String, noteText: String, note: Note) -> Note? {
            note.setValue(image, forKeyPath: "image")
            note.setValue(gameName, forKeyPath: "gameName")
            note.setValue(noteText, forKeyPath: "noteText")
            
            do {
                try managedContext.save()
                return note
            } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
            }
            return nil
        }
        
        @discardableResult
        func saveNote(image: Data, gameName: String, noteText: String) -> Note? {
            let entity = NSEntityDescription.entity(forEntityName: "Note", in: managedContext)!
            let note = NSManagedObject(entity: entity, insertInto: managedContext)
            note.setValue(image, forKeyPath: "image")
            note.setValue(gameName, forKeyPath: "gameName")
            note.setValue(noteText, forKeyPath: "noteText")
            
            do {
                try managedContext.save()
                return note as? Note
            } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
            }
            
            return nil
        }
        
        func getNotes() -> [Note] {
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Note")
            do {
                let notes = try managedContext.fetch(fetchRequest)
                return notes as! [Note]
            } catch let error as NSError {
                print("Could not fetch. \(error), \(error.userInfo)")
            }
            return []
        }
        
        func deleteNote(note: Note) {
            
            managedContext.delete(note)
            
            do {
                try managedContext.save()
            } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
            }
        }
}
