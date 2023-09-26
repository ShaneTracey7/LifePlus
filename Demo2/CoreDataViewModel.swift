//
//  CoreDataViewModel.swift
//  Demo2
//
//  Created by Coding on 2023-09-26.
//
import CoreData
import Foundation

class CoreDataViewModel: ObservableObject {
    let container: NSPersistentContainer
    @Published var taskEntities: [TaskEntity] = []
    @Published var rewardEntities: [RewardEntity] = []
    
    //@Published var pointEntities: [PointEntity] = [] (hold rewardpoints and points
    
    init(){
        container = NSPersistentContainer(name: "Demo2")
        container.loadPersistentStores{ (description, error) in
            if let error = error{
                print("Error loadinf core data. \(error)")
            }
        }
        fetchTasks()
    
    }
    
    func fetchTasks() {
        let request = NSFetchRequest<TaskEntity>(entityName: "TaskEntity")
        
        do {
            taskEntities = try container.viewContext.fetch(request)
        } catch let error {
            print("Error fetching. \(error)")
        }
    }
    
    func addTask(name: String, duration: Int, date: Date, isComplete: Bool)
    {
        let newTask = TaskEntity(context: container.viewContext)
        newTask.id = UUID()
        newTask.name = name
        newTask.duration = duration
        newTask.date = date
        newTask.isComplete = isComplete
    }
}
