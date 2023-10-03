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
    @Published var pointEntities: [PointEntity] = [] //holds rewardpoints and points
    @Published var masterRewardEntities: [RewardEntity] = []
    @Published var rewardEntities: [RewardEntity] = [] // used for WalletView
    @Published var staticRewardEntities: [RewardEntity] = [] // used for RewardView
    @Published var modeEntities: [ModeEntity] = [] //needed for dark/light mode
    @Published var goalEntities: [GoalEntity] = []
    
    
    
    
    
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
        
        if(modeEntities.isEmpty)
        {
            let mode = ModeEntity(context: container.viewContext)
            mode.isDark = false
            modeEntities.append(mode)
            saveModeData()
        }
        
        setRewardData()
        fetchStaticRewards()
        fetchTasks()
        fetchRewards()
        fetchMode()
        fetchPoints()
        fetchGoals()
    }
    
    func setRewardData(){
        
        //2000
            addStaticReward(name: "Get a tasty drink", price: Int32(2000), image: "cup.and.saucer", isPurchased: false, isUsed: false)
            addStaticReward(name: "Get a tasty treat", price: Int32(2000), image: "birthday.cake", isPurchased: false, isUsed: false)
        //4000
            addStaticReward(name: "Get some fast food", price: Int32(4000), image: "takeoutbag.and.cup.and.straw", isPurchased: false, isUsed: false)
            addStaticReward(name: "Play 1 hour of video games", price: Int32(4000), image: "gamecontroller", isPurchased: false, isUsed: false)
            addStaticReward(name: "Sleep-in an extra hour", price: Int32(4000), image: "bed.double", isPurchased: false, isUsed: false)
        //8000
            addStaticReward(name: "Eat out / Get takeout", price: Int32(8000), image: "fork.knife", isPurchased: false, isUsed: false)
            addStaticReward(name: "Go see a movie in theatres", price: Int32(8000), image: "popcorn", isPurchased: false, isUsed: false)
        //16000
            addStaticReward(name: "Buy shoes / article of clothing", price: Int32(16000), image: "bag", isPurchased: false, isUsed: false)
            addStaticReward(name: "Book a massage", price: Int32(16000), image: "hand.raised.fingers.spread", isPurchased: false, isUsed: false)
            
    }
    
    //fetching functions
    func fetchTasks() {
        let request = NSFetchRequest<TaskEntity>(entityName: "TaskEntity")
        
        do {
            taskEntities = try container.viewContext.fetch(request)
        } catch let error {
            print("Error fetching tasks. \(error)")
        }
    }
    
    func fetchRewards() {
        
        fetchMasterRewards()
        rewardEntities = masterRewardEntities.filter({$0.isPurchased})
    }
    
    func fetchMasterRewards() {
        let request = NSFetchRequest<RewardEntity>(entityName: "RewardEntity")
        
        do {
            masterRewardEntities = try container.viewContext.fetch(request)
        } catch let error {
            print("Error fetching rewards. \(error)")
        }
    }
    
    
    func fetchStaticRewards() {
        
        fetchMasterRewards()
        staticRewardEntities = masterRewardEntities.filter({!$0.isPurchased})
    }
    
    func fetchPoints() {
        let request = NSFetchRequest<PointEntity>(entityName: "PointEntity")
        
        do {
            pointEntities = try container.viewContext.fetch(request)
        } catch let error {
            print("Error fetching points. \(error)")
        }
    }
    
    func fetchMode() {
        let request = NSFetchRequest<ModeEntity>(entityName: "ModeEntity")
        
        do {
            modeEntities = try container.viewContext.fetch(request)
        } catch let error {
            print("Error fetching mode. \(error)")
        }
    }
    
    func fetchGoals() {
        let request = NSFetchRequest<GoalEntity>(entityName: "GoalEntity")
        
        do {
            goalEntities = try container.viewContext.fetch(request)
        } catch let error {
            print("Error fetching goals. \(error)")
        }
    }
    
    // adding functions
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
    
    func addReward(name: String, price: Int32, image: String, isPurchased: Bool, isUsed: Bool)
    {
        let newReward = RewardEntity(context: container.viewContext)
        newReward.id = UUID()
        newReward.name = name
        newReward.price = Int32(price)
        newReward.image = image
        newReward.isPurchased = isPurchased
        newReward.isUsed = isUsed
        saveRewardData()
    }
    
    func addGoal(name: String, isHours: Bool, value: Float, currentValue: Float, startDate: Date, endDate: Date, completedPoints: Int, isComplete: Bool)
    {
        let newGoal = GoalEntity(context: container.viewContext)
        newGoal.id = UUID()
        newGoal.name = name
        newGoal.isHours = isHours
        newGoal.value = value
        newGoal.currentValue = currentValue
        newGoal.startDate = startDate
        newGoal.endDate = endDate
        newGoal.completedPoints = Int32(completedPoints)
        newGoal.isComplete = isComplete
        saveGoalData()
    }
    
    func addStaticReward(name: String, price: Int32, image: String, isPurchased: Bool, isUsed: Bool)
    {
        let newReward = RewardEntity(context: container.viewContext)
        newReward.id = UUID()
        newReward.name = name
        newReward.price = Int32(price)
        newReward.image = image
        newReward.isPurchased = isPurchased
        newReward.isUsed = isUsed
        saveStaticRewardData()
    }
    
    func addPoints(entity: PointEntity, increment: Int)
    {
        entity.value += Int32(increment)
        savePointData()
    }
    
    func addToCurrentValue(taskIncrement: Float, hourIncrement: Float)
    {
        
        for goal in goalEntities{
            
            if goal.isHours
            {
                goal.currentValue += hourIncrement
                
                if goal.currentValue >= goal.value
                {
                    goal.isComplete = true
                    goal.currentValue = goal.value //needed to avoid gauge error
                    let add: Int = Int((goal.completedPoints))
                    self.addPoints(entity: self.pointEntities[0], increment: add)
                    self.addPoints(entity: self.pointEntities[1], increment: add)
                }
            }
            else
            {
                goal.currentValue += taskIncrement
                
                if goal.currentValue >= goal.value
                {
                    goal.isComplete = true
                    goal.currentValue = goal.value //needed to avoid gauge error
                    let add: Int = Int((goal.completedPoints))
                    self.addPoints(entity: self.pointEntities[0], increment: add)
                    self.addPoints(entity: self.pointEntities[1], increment: add)
                }
            }
        }
        saveGoalData()
    }
    
    func deleteTask(index: Int)
    {
        let entity = taskEntities[index]
        container.viewContext.delete(entity)
        saveTaskData()
    }
    
    func deleteGoal(index: Int)
    {
        let entity = goalEntities[index]
        container.viewContext.delete(entity)
        saveGoalData()
    }
    
    func setIsDark(entity: ModeEntity)
    {
        if (entity.isDark)
        {
            entity.isDark = false
        }
        else
        {
            entity.isDark = true
        }
        saveModeData()
    }
    
    func setUsed (entity: RewardEntity)
    {
        entity.isUsed = true
        saveRewardData()
    }
    
    func sortTask(choice: Int)
    {
        var arr: [TaskEntity] = []
        var arrT: [TaskEntity] = []
        var arrF: [TaskEntity] = []
        switch (choice)
        {
        case 1:  print("sort by date")
            arr = self.taskEntities.sorted { $0.date ?? Date() < $1.date ?? Date ()}
            self.taskEntities = arr
        case 2: print("sort by duration")
            arr = self.taskEntities.sorted { $0.duration < $1.duration}
            self.taskEntities = arr
        case 3: print("sort by completed ")
            for task in taskEntities{
                if task.isComplete{
                    arrT.append(task)
                }
                else
                {
                    arrF.append(task)
                }
            }
            arr = arrF + arrT
            self.taskEntities = arr
        default: print("did not work")
        }

    }
    
    func sortGoal(choice: Int)
    {
        var arr: [GoalEntity] = []
        var arrT: [GoalEntity] = []
        var arrF: [GoalEntity] = []
        switch (choice)
        {
        case 1:  print("sort by date")
            arr = self.goalEntities.sorted { $0.endDate ?? Date() < $1.endDate ?? Date ()}
            self.goalEntities = arr
                            
        case 2: print("sort by progress")
            arr = self.goalEntities.sorted { $0.currentValue / $0.value < $1.currentValue / $1.value}
            self.goalEntities = arr
        case 3: print("sort by completed ")
            for task in goalEntities{
                if task.isComplete{
                    arrT.append(task)
                }
                else
                {
                    arrF.append(task)
                }
            }
            arr = arrF + arrT
            self.goalEntities = arr
        default: print("did not work")
        }
        
        print(goalEntities)
        //saveTaskData()
    }
    
    // save functions
    func saveTaskData(){
        do{
            try container.viewContext.save()
            fetchTasks()
        } catch let error{
                print("Error saving tasks. \(error)")
            }
        }
    
    func saveModeData(){
        do{
            try container.viewContext.save()
            fetchMode()
        } catch let error{
                print("Error saving mode. \(error)")
            }
        }
    
    func saveRewardData(){
        do{
            try container.viewContext.save()
            fetchRewards()
        } catch let error{
                print("Error saving rewards. \(error)")
            }
        }
    func saveStaticRewardData(){
        do{
            try container.viewContext.save()
            fetchStaticRewards()
        } catch let error{
                print("Error saving static rewards. \(error)")
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
    
    func saveGoalData(){
        do{
            try container.viewContext.save()
            fetchGoals()
        } catch let error{
                print("Error saving goals. \(error)")
            }
        }
    
    func resetCoreData(){
        
        taskEntities.forEach { task in
            container.viewContext.delete(task)
        }
        
        rewardEntities.forEach { reward in
            container.viewContext.delete(reward)
        }
        goalEntities.forEach { goal in
            container.viewContext.delete(goal)
        }
        
        pointEntities[0].value = 0
        pointEntities[1].value = 0
        
        
        saveTaskData()
        saveRewardData()
        saveGoalData()
        savePointData()
    }

}


    
