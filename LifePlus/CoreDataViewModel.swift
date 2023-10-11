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
    @Published var walletRewardEntities: [RewardEntity] = [] // used for WalletView
    //@Published var staticRewardEntities: [RewardEntity] = [] // used for RewardView
    @Published var rewardEntities1: [RewardEntity] = []
    @Published var rewardEntities2: [RewardEntity] = []
    @Published var rewardEntities3: [RewardEntity] = []
    @Published var rewardEntities4: [RewardEntity] = []
    @Published var modeEntities: [ModeEntity] = [] //needed for dark/light mode
    @Published var goalEntities: [GoalEntity] = []
    
    
    init(){
        container = NSPersistentContainer(name: "LifePlus")
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
            let order = PointEntity(context: container.viewContext)
            order.value = 0
            pointEntities.append(order)
            savePointData()
        }
        
        if(modeEntities.isEmpty)
        {
            let mode = ModeEntity(context: container.viewContext)
            mode.isDark = false
            modeEntities.append(mode)
            saveModeData()
        }
        
        fetchLevelRewards()
        if(rewardEntities1.isEmpty && rewardEntities2.isEmpty && rewardEntities3.isEmpty && rewardEntities4.isEmpty)
        {
            print("1: \(rewardEntities1.count)")
            print("2: \(rewardEntities2.count)")
            print("3: \(rewardEntities3.count)")
            print("4: \(rewardEntities4.count)")
            print("Have to set reward date")
            print("1: \(rewardEntities1.count)")
            print("2: \(rewardEntities2.count)")
            print("3: \(rewardEntities3.count)")
            print("4: \(rewardEntities4.count)")
            setRewardData()
            saveLevelRewardData()
            
        }
        else
        {
            print("not empty")
            print("1: \(rewardEntities1.count)")
            print("2: \(rewardEntities2.count)")
            print("3: \(rewardEntities3.count)")
            print("4: \(rewardEntities4.count)")
        }
         
        /*
        fetchMasterRewards()
        
        if(masterRewardEntities.isEmpty)
        {
            print("1: \(rewardEntities1.count)")
            print("2: \(rewardEntities2.count)")
            print("3: \(rewardEntities3.count)")
            print("4: \(rewardEntities4.count)")
            print("Have to set reward date")
            
            setRewardData()
            saveMasterRewardData()
            print("master: \(masterRewardEntities.count)")
            
        }
        else
        {
            print("not empty")
            print("master: \(masterRewardEntities.count)")
        }
         */
        fetchTasks()
        fetchWalletRewards()
        fetchMode()
        fetchPoints()
        fetchGoals()
    }
    
    func setRewardData(){
        
        //2000
            addReward(name: "Get a tasty drink", price: Int32(2000), image: "cup.and.saucer", isPurchased: false, isUsed: false)
        
            addReward(name: "Get a tasty treat", price: Int32(2000), image: "birthday.cake", isPurchased: false, isUsed: false)
        //4000
            addReward(name: "Get some fast food", price: Int32(4000), image: "takeoutbag.and.cup.and.straw", isPurchased: false, isUsed: false)
            addReward(name: "Play 1 hour of video games", price: Int32(4000), image: "gamecontroller", isPurchased: false, isUsed: false)
            addReward(name: "Sleep-in an extra hour", price: Int32(4000), image: "bed.double", isPurchased: false, isUsed: false)
        //8000
            addReward(name: "Eat out / Get takeout", price: Int32(8000), image: "fork.knife", isPurchased: false, isUsed: false)
            addReward(name: "Go see a movie in theatres", price: Int32(8000), image: "popcorn", isPurchased: false, isUsed: false)
        //16000
            addReward(name: "Buy shoes / article of clothing", price: Int32(16000), image: "bag", isPurchased: false, isUsed: false)
            addReward(name: "Book a massage", price: Int32(16000), image: "hand.raised.fingers.spread", isPurchased: false, isUsed: false)
         
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
    
    
    func fetchWalletRewards() {
        
        fetchMasterRewards()
        walletRewardEntities = masterRewardEntities.filter({$0.isPurchased })
        
    }
    
    func fetchLevelRewards() {
        
        fetchMasterRewards()
        rewardEntities1 = masterRewardEntities.filter({!$0.isPurchased && $0.price == Int32(2000)})
        rewardEntities2 = masterRewardEntities.filter({!$0.isPurchased && $0.price == Int32(4000)})
        rewardEntities3 = masterRewardEntities.filter({!$0.isPurchased && $0.price == Int32(8000)})
        rewardEntities4 = masterRewardEntities.filter({!$0.isPurchased && $0.price == Int32(16000)})
        
    }
    
    
    func fetchMasterRewards() {
       let request = NSFetchRequest<RewardEntity>(entityName: "RewardEntity")
        do {
            masterRewardEntities = try container.viewContext.fetch(request)
        } catch let error {
            print("Error fetching rewards. \(error)")
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
    func addTask(name: String, duration: Int, date: Date, isComplete: Bool, info: String)
    {
        let newTask = TaskEntity(context: container.viewContext)
        newTask.id = UUID()
        newTask.completedOrder = 1000000000 //placeholderdate
        newTask.name = name
        newTask.duration = Int32(duration)
        newTask.date = date
        newTask.isComplete = isComplete
        newTask.info = info
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
        saveLevelRewardData()
    }
    
    func addToWallet(name: String, price: Int32, image: String, isPurchased: Bool, isUsed: Bool)
    {
        let newReward = RewardEntity(context: container.viewContext)
        newReward.id = UUID()
        newReward.name = name
        newReward.price = Int32(price)
        newReward.image = image
        newReward.isPurchased = isPurchased
        newReward.isUsed = isUsed
        saveWalletRewardData()
    }
    
    func addGoal(name: String, isHours: Bool, value: Float, currentValue: Float, startDate: Date, endDate: Date, completedPoints: Int, isComplete: Bool)
    {
        self.addPoints(entity: self.pointEntities[2], increment: 1)
       
        let newGoal = GoalEntity(context: container.viewContext)
        newGoal.id = UUID()
        newGoal.completedOrder = 1000000000
        newGoal.createdOrder = self.pointEntities[2].value
        newGoal.currentValueOffset = 0.0 //default
        newGoal.name = name
        newGoal.isHours = isHours
        newGoal.value = value
        newGoal.currentValue = currentValue
        newGoal.startDate = startDate
        newGoal.endDate = endDate
        newGoal.completedPoints = Int32(completedPoints)
        newGoal.isComplete = isComplete
        saveGoalData()
        savePointData()
    }
    
    
    func addPoints(entity: PointEntity, increment: Int)
    {
        entity.value += Int32(increment)
        savePointData()
    }
    
    func addToCurrentValue(taskIncrement: Float, hourIncrement: Float)
    {
        
        for goal in goalEntities{
            
            if goal.isComplete
            {
                if goal.isHours
                {
                    goal.currentValueOffset += hourIncrement
                }
                else
                {
                    goal.currentValueOffset += taskIncrement
                }
            }
            else
            {
                if goal.isHours
                {
                    goal.currentValue += hourIncrement
                    
                    if goal.currentValue >= goal.value
                    {
                        goal.isComplete = true
                        
                        //setting order
                        self.addPoints(entity: self.pointEntities[2], increment: 1)
                        self.setGoalOrder(entity: goal, order: Int(self.pointEntities[2].value))
                        
                        goal.currentValueOffset = goal.currentValue - goal.value
                        goal.currentValue = goal.value //needed to avoid gauge error
                        let add: Int = Int((goal.completedPoints))
                        self.addPoints(entity: self.pointEntities[0], increment: add)
                        self.addPoints(entity: self.pointEntities[1], increment: add)
                    }
                }
                else //isTask
                {
                    goal.currentValue += taskIncrement
                    
                    if goal.currentValue >= goal.value
                    {
                        goal.isComplete = true
                        
                        //setting order
                        self.addPoints(entity: self.pointEntities[2], increment: 1)
                        self.setGoalOrder(entity: goal, order: Int(self.pointEntities[2].value))
                        
                        goal.currentValueOffset = goal.currentValue - goal.value
                        goal.currentValue = goal.value //needed to avoid gauge error
                        let add: Int = Int((goal.completedPoints))
                        self.addPoints(entity: self.pointEntities[0], increment: add)
                        self.addPoints(entity: self.pointEntities[1], increment: add)
                    }
                }
            }
        }
        saveGoalData()
        savePointData()
    }
    
    func subToCurrentValue(task: TaskEntity, goal: GoalEntity, taskIncrement: Float, hourIncrement: Float)
    {
        
        if goal.isComplete == false {
            
            print("goal is not complete")
            if goal.isHours
            {
                goal.currentValue += hourIncrement
            }
            else
            {
                goal.currentValue += taskIncrement
            }
        }
            
            else
            {
                print("goal is complete")
                if goal.isHours
                {
                    print("hourIncrement + goal.currentValueOffset = \(hourIncrement + goal.currentValueOffset)")
                    
                    if hourIncrement + goal.currentValueOffset < 0
                    {
                        print("less than zero")
                        // goal isn't complete anymore
                        goal.isComplete = false
                        self.setGoalOrder(entity: goal, order: 1000000000)
                        goal.currentValue += (hourIncrement + goal.currentValueOffset)
                        
                        //if goal isn't complete anymore(Subtracting from rewardpoints and points)
                        let sub: Int = Int((goal.completedPoints)*(-1))
                        
                        if goal.completedPoints >= self.pointEntities[0].value
                        {
                            self.addPoints(entity: self.pointEntities[0], increment: (Int(self.pointEntities[0].value))*(-1))
                        }
                        else
                        {
                            self.addPoints(entity: self.pointEntities[0], increment: sub)
                        }
                        
                        if goal.completedPoints >= self.pointEntities[1].value
                        {
                            self.addPoints(entity: self.pointEntities[1], increment: (Int(self.pointEntities[1].value))*(-1))
                        }
                        else
                        {
                            self.addPoints(entity: self.pointEntities[1], increment: sub)
                        }
                        
                        //reseting offset
                        goal.currentValueOffset = 0.0
                        
                    }
                    else
                    {   //decrementing offset
                        goal.currentValueOffset += hourIncrement
                    }
                    
                }
                else
                {
                    print("taskIncrement + goal.currentValueOffset = \(taskIncrement + goal.currentValueOffset)")
                    if taskIncrement + goal.currentValueOffset < 0
                    {
                        print("less than zero")
                        // goal isn't complete anymore
                        goal.isComplete = false
                        self.setGoalOrder(entity: goal, order: 1000000000)
                        goal.currentValue += (taskIncrement + goal.currentValueOffset)
                        
                        //if goal isn't complete anymore(Subtracting from rewardpoints and points)
                        let sub: Int = Int((goal.completedPoints)*(-1))
                        
                        if goal.completedPoints >= self.pointEntities[0].value
                        {
                            self.addPoints(entity: self.pointEntities[0], increment: (Int(self.pointEntities[0].value))*(-1))
                        }
                        else
                        {
                            self.addPoints(entity: self.pointEntities[0], increment: sub)
                        }
                        
                        if goal.completedPoints >= self.pointEntities[1].value
                        {
                            self.addPoints(entity: self.pointEntities[1], increment: (Int(self.pointEntities[1].value))*(-1))
                        }
                        else
                        {
                            self.addPoints(entity: self.pointEntities[1], increment: sub)
                        }
                        
                        //reseting offset
                        goal.currentValueOffset = 0.0
                        
                    }
                    else
                    {   //decrementing offset
                        goal.currentValueOffset += taskIncrement
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
    
    func deleteReward(index: Int, arr: [RewardEntity])
    {
        let entity = arr[index]
        container.viewContext.delete(entity)
        saveLevelRewardData()
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
    
    func setTaskCompletedOrder(entity: TaskEntity, order: Int)
    {
        entity.completedOrder = Int32(order)
        saveTaskData()
    }
    
    func setGoalOrder(entity: GoalEntity, order: Int)
    {
        entity.completedOrder = Int32(order)
        saveGoalData()
    }

    
    func setUsed (entity: RewardEntity)
    {
        entity.isUsed = true
        saveWalletRewardData()
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
    
    func saveMasterRewardData(){
        do{
            try container.viewContext.save()
            fetchMasterRewards()
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
    
    func saveWalletRewardData(){
        do{
            try container.viewContext.save()
            fetchWalletRewards()
        } catch let error{
                print("Error saving wallet rewards. \(error)")
            }
        }
    func saveLevelRewardData(){
        do{
            try container.viewContext.save()
            fetchLevelRewards()
        } catch let error{
                print("Error saving rewards. \(error)")
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
        masterRewardEntities.forEach { reward in
            container.viewContext.delete(reward)
        }
        rewardEntities1.forEach { reward in
            container.viewContext.delete(reward)
        }
        rewardEntities2.forEach { reward in
            container.viewContext.delete(reward)
        }
        rewardEntities3.forEach { reward in
            container.viewContext.delete(reward)
        }
        rewardEntities4.forEach { reward in
            container.viewContext.delete(reward)
        }
        
        walletRewardEntities.forEach { reward in
            container.viewContext.delete(reward)
        }
        goalEntities.forEach { goal in
            container.viewContext.delete(goal)
        }
        
        pointEntities[0].value = 0
        pointEntities[1].value = 0
        
        
        saveTaskData()
        saveMasterRewardData()
        saveWalletRewardData()
        saveGoalData()
        savePointData()
        
        
        //add default rewards back
        setRewardData()
        saveLevelRewardData()
    }

}


    
