//
//  Persistence.swift
//  Demo2
//
//  Created by Coding on 2023-09-26.
//

//import Foundation

/*import CoreData

struct PersistenceController {
    static let shared = PersistenceController()
    
    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        for x in 0..<10 {
            let newTask = TaskEntity(context: viewContext)
            newTask.name = " Task \(x)"
            newTask.isComplete = false
            newTask.id = UUID()
            newTask.duration = 60
            newTask.date = Date()
        }
        do{
            try viewContext.save()
        } catch{
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()
    
    
    
    
    
    
    let container: NSPersistentContainer
    
    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "Demo2")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
       // container.viewContext.automaticallyMergesChangesFromParent = true
        container.loadPersistentStores { storeDescription, err in
            if let err = err {
                fatalError(err.localizedDescription)
            }
        }
    }
    
    func save() throws {
        let context = container.viewContext
        if context.hasChanges {
            try context.save()
        }
    }
    
    func delete(_ object: NSManagedObject) throws {
        let context = container.viewContext
        context.delete(object)
        try save()
    }
}
*/
