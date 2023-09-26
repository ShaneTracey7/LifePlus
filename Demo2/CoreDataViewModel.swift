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
    @Published var pointEntities: [PointEntity] = []
    //@Published var rewardEntities: [RewardEntity] = []
    
    //@Published var pointEntities: [PointEntity] = [] (hold rewardpoints and points
    
    init(){
        container = NSPersistentContainer(name: "Demo2")
        container.loadPersistentStores{ (description, error) in
            if let error = error{
                print("Error loadinf core data. \(error)")
            }
        }
        
        if(pointEntities.isEmpty)
        {
            let points = PointEntity(context: container.viewContext)
            points.value = 0
            pointEntities.append(points)
            let rewardPoints = PointEntity(context: container.viewContext)
            rewardPoints.value = 0
            pointEntities.append(rewardPoints)
            savePointData()
        }
        fetchTasks()
        fetchPoints()
    }
    
    func fetchTasks() {
        let request = NSFetchRequest<TaskEntity>(entityName: "TaskEntity")
        
        do {
            taskEntities = try container.viewContext.fetch(request)
        } catch let error {
            print("Error fetching tasks. \(error)")
        }
    }
    
    func fetchPoints() {
        let request = NSFetchRequest<PointEntity>(entityName: "PointEntity")
        
        do {
            pointEntities = try container.viewContext.fetch(request)
        } catch let error {
            print("Error fetching points. \(error)")
        }
    }
    
    func addTask(name: String, duration: Int, date: Date, isComplete: Bool)
    {
        let newTask = TaskEntity(context: container.viewContext)
        newTask.id = UUID()
        newTask.name = name
        newTask.duration = Int32(duration)
        newTask.date = date
        newTask.isComplete = isComplete
        saveTaskData()
    }
    
    
    func deleteTask(index: Int)
    {
        let entity = taskEntities[index]
        container.viewContext.delete(entity)
        saveTaskData()
    }
    
    func addPoints(entity: PointEntity, increment: Int)
    {
        entity.value += Int32(increment)
        savePointData()
    }
    
    func saveTaskData(){
        do{
            try container.viewContext.save()
            fetchTasks()
        } catch let error{
                print("Error saving tasks. \(error)")
            }
        }
    func savePointData(){
        do{
            try container.viewContext.save()
            fetchPoints()
        } catch let error{
                print("Error saving points. \(error)")
            }
        }
}
