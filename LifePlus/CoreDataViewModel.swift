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
    @Published var calendarCellEntities: [CalendarEntity] = []
    @Published var logins: [LoginEntity] = []
    
    @Published var masterListEntities: [ListEntity] = []
    @Published var customListEntities: [ListEntity] = []
    @Published var calendarListEntities: [ListEntity] = []
    @Published var defaultListEntities: [ListEntity] = []
    
    @Published var pointEntities: [PointEntity] = [] //holds rewardpoints and points
    @Published var masterRewardEntities: [RewardEntity] = []
    @Published var walletRewardEntities: [RewardEntity] = [] // used for WalletView
    //rewardEntities 1 thru 4 represent each reward level
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
                print("Error loading core data. \(error)")
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
        
        
        fetchCalendarLists()
        if(calendarListEntities.isEmpty)
        {
            print("list is empty")
            setCalendarListData()
            saveCalendarListData()
        }
        else
        {
            print("list is not empty")
        }
        
        fetchDefaultLists()
        if(defaultListEntities.isEmpty)
        {
            print("default list is empty")
            setDefaultListData()
            saveDefaultListData()
        }
        else
        {
            print("default list is not empty")
        }
        
        fetchLogin()
        if logins.isEmpty
        {
            let log = LoginEntity(context: container.viewContext)
            log.lastLogin = Date()
            logins.append(log)
            saveLoginData()
        }
        else
        {
            setLogins()
        }
    
        fetchLevelRewards()
        if(rewardEntities1.isEmpty && rewardEntities2.isEmpty && rewardEntities3.isEmpty && rewardEntities4.isEmpty)
        {
            setRewardData()
            saveLevelRewardData()
        }
        else
        {
            
        }
         
        fetchCalendarCells()
        fetchTasks()
        fetchWalletRewards()
        fetchMode()
        fetchPoints()
        fetchGoals()
        fetchCustomLists()
        fetchLogin()
        
    }
    
    func setCalendarListData()
    {
        //add daily list
        addList(name:"Daily TODO", startDate: Date(), endDate: getCalendarListDayDate(), style: "calendar", isComplete: false)
        
        //add weekly list
        let weeklyDates: [Date] = getCalendarListWeekDate()
        addList(name:"Weekly TODO", startDate: weeklyDates[0], endDate: weeklyDates[1], style: "calendar", isComplete: false)
        
        //add monthly list
        let monthlyDates: [Date] = getCalendarListMonthDate()
        let month: String = monthlyDates[0].formatted(Date.FormatStyle().month(.wide))
        addList(name:"\(month) TODO" , startDate: monthlyDates[0], endDate: monthlyDates[1], style: "calendar", isComplete: false)
        
    }
    
    func getCalendarListDayDate() -> Date
    {
        let currentDate = Date()
        
        var endofDayDate = DateComponents()
        endofDayDate.year = Calendar.current.dateComponents([.year], from: currentDate).year ?? 1
        endofDayDate.month = Calendar.current.dateComponents([.month], from: currentDate).month ?? 1
        endofDayDate.day = Calendar.current.dateComponents([.day], from: currentDate).day ?? 1
        endofDayDate.timeZone = TimeZone(abbreviation: "EST")
        endofDayDate.hour = 23
        endofDayDate.minute = 59
        endofDayDate.second = 59
        let endofDayDateSet = Calendar.current.date(from: endofDayDate) ?? Date()
        
        return endofDayDateSet
        
    }
    
    func getCalendarListWeekDate() -> [Date]
    {
        
        let currentDate = Date()
    
        let dayOfWeek: String = currentDate.formatted(Date.FormatStyle().weekday(.wide))
        var startOfWeek = Date()
        var endOfWeek = Date()
        
        switch dayOfWeek
        {
        case "Monday":
            endOfWeek = currentDate.addingTimeInterval(6*86400)
        case "Tuesday":
            startOfWeek = currentDate.addingTimeInterval(-86400)
            endOfWeek = currentDate.addingTimeInterval(5*86400)
        case "Wednesday":
            startOfWeek = currentDate.addingTimeInterval((-2)*86400)
            endOfWeek = currentDate.addingTimeInterval(4*86400)
        case "Thursday":
            startOfWeek = currentDate.addingTimeInterval((-3)*86400)
            endOfWeek = currentDate.addingTimeInterval(3*86400)
        case "Friday":
            startOfWeek = currentDate.addingTimeInterval((-4)*86400)
            endOfWeek = currentDate.addingTimeInterval(2*86400)
        case "Saturday":
            startOfWeek = currentDate.addingTimeInterval((-5)*86400)
            endOfWeek = currentDate.addingTimeInterval(86400)
        case "Sunday":
            startOfWeek = currentDate.addingTimeInterval((-6)*86400)
        default: print("something went wrong")
        }
        
        var endofWeekDate = DateComponents()
        endofWeekDate.year = Calendar.current.dateComponents([.year], from: endOfWeek).year ?? 1
        endofWeekDate.month = Calendar.current.dateComponents([.month], from: endOfWeek).month ?? 1
        endofWeekDate.day = Calendar.current.dateComponents([.day], from: endOfWeek).day ?? 1
        endofWeekDate.hour = 23
        endofWeekDate.minute = 59
        endofWeekDate.second = 59
        let endofWeekDateSet = Calendar.current.date(from: endofWeekDate) ?? Date()
    
        return [startOfWeek ,endofWeekDateSet]
        
    }
    
    func getCalendarListMonthDate() -> [Date]
    {
        let currentDate = Date()
        
        var startMonthDate = DateComponents()
        startMonthDate.year = Calendar.current.dateComponents([.year], from: currentDate).year ?? 1
        startMonthDate.month = Calendar.current.dateComponents([.month], from: currentDate).month ?? 1
        startMonthDate.day = 1
        startMonthDate.timeZone = TimeZone(abbreviation: "EST")
        let startMonthDateSet = Calendar.current.date(from: startMonthDate) ?? Date()
        
        var endMonthDate = DateComponents()
        endMonthDate.year = Calendar.current.dateComponents([.year], from: currentDate).year ?? 1
        endMonthDate.month = Calendar.current.dateComponents([.month], from: currentDate).month ?? 1
        
        var endOfMonthDay: Int
        switch  endMonthDate.month
        {
        case 1: endOfMonthDay = 31
        case 2: endOfMonthDay = 28
        case 3: endOfMonthDay = 31
        case 4: endOfMonthDay = 30
        case 5: endOfMonthDay = 31
        case 6: endOfMonthDay = 30
        case 7: endOfMonthDay = 31
        case 8: endOfMonthDay = 31
        case 9: endOfMonthDay = 30
        case 10: endOfMonthDay = 31
        case 11: endOfMonthDay = 30
        case 12: endOfMonthDay = 31
        default:
            print("couldn't set end of month day")
            endOfMonthDay = 31
        }
        
        endMonthDate.day = endOfMonthDay
        endMonthDate.timeZone = TimeZone(abbreviation: "EST")
        endMonthDate.hour = 23
        endMonthDate.minute = 59
        endMonthDate.second = 59
        let endMonthDateSet = Calendar.current.date(from: endMonthDate) ?? Date()
        
        return [ startMonthDateSet, endMonthDateSet]
       
    }
    
    
    
    func setDefaultListData()
    {
        
        // week can only use MTWTFSS and month can only use day numbers.
        //cannot have a start date and end date becasue then it's a calendar unless it's over a long period of time
        //day can have a time to complete by/optional
        //week and month will have no date to them
        
        //daily
        addList(name:"Daily DEFAULT", startDate: Date(), endDate: Date(), style: "default", isComplete: false)
        //weekly
        addList(name:"Weekly DEFAULT", startDate: Date(), endDate: Date(), style: "default", isComplete: false)
        //month
        addList(name:"Monthly DEFAULT" , startDate: Date(), endDate: Date(), style: "default", isComplete: false)
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
    
    func setLogins()
    {
        fetchLogin()
        fetchCalendarLists()
        
        //updates login
        logins[0].lastLogin = Date()
        
        //setting daily TODO
        let endOfDayDate = calendarListEntities.first{$0.name == "Daily TODO"}?.endDate ?? Date()
        if Date() > endOfDayDate
        {
            resetCalendarListDay()
        }
        //setting weekly TODO
        let endOfWeekDate = calendarListEntities.first{$0.name == "Weekly TODO"}?.endDate ?? Date()
        if Date() > endOfWeekDate
        {
            resetCalendarListWeek()
        }
        
        //setting monthly TODO
        var endOfMonthDate = Date().addingTimeInterval(86400)
        for tasklist in calendarListEntities
        {
            let str = tasklist.name ?? ""
            if !str.contains("Weekly") && !str.contains("Daily")
            {
                endOfMonthDate = tasklist.endDate ?? Date().addingTimeInterval(86400)
            }
        }
        if Date() > endOfMonthDate
        {
            resetCalendarListMonth()
        }
        saveLoginData()
    }
    
    func resetCalendarListDay()
    {
        //if tasks were completed, dont adjust points
        
        fetchTasks()
        //save current day list data somewhere
        
        
        let dailyTODOlist = calendarListEntities.first{$0.name == "Daily TODO"} ?? ListEntity()
        let dailyDEFAULTlist = defaultListEntities.first{$0.name == "Daily DEFAULT"} ?? ListEntity()
        
        //set calendar cell
        if dailyTODOlist.isComplete
        {
            addCalendarCells(date: dailyTODOlist.startDate ?? Date(), isComplete: true)
        }
        else
        {
            addCalendarCells(date: dailyTODOlist.startDate ?? Date(), isComplete: false)
        }
        
        //delete non-default items in daily TODO
        for task in taskEntities
        {
            if dailyTODOlist.id == task.listId
            {
                container.viewContext.delete(task)
            }
        }
        //mark default items as incomplete and update date for tasks daily default
        
        let currentDate = Date()
        var components = DateComponents()
        components.year = Calendar.current.dateComponents([.year], from: currentDate).year ?? 1
        components.month = Calendar.current.dateComponents([.month], from: currentDate).month ?? 1
        components.day = Calendar.current.dateComponents([.day], from: currentDate).day ?? 1
        
        for task in taskEntities
        {
            if dailyDEFAULTlist.id == task.listId
            {
                task.isComplete = false
                //reset counterview's value
                task.currentReps = 0
                let oldDate = task.date ?? Date()
                components.hour = Calendar.current.dateComponents([.hour], from: oldDate).hour ?? 1
                components.minute = Calendar.current.dateComponents([.minute], from: oldDate).minute ?? 1
                let newDate = Calendar.current.date(from: components) ?? Date()
                task.date = newDate
            }
        }
        
        //delete current day list
        container.viewContext.delete(dailyTODOlist)
        
        //add new daily list
        addList(name:"Daily TODO", startDate: Date(), endDate: getCalendarListDayDate(), style: "calendar", isComplete: false)
        
        saveCalendarListData()
        saveTaskData()
    }
    
    func resetCalendarListWeek()
    {
        //if tasks were completed, dont adjust points
        fetchTasks()
        //save current week list data somewhere
        
        
        let weeklyTODOlist = calendarListEntities.first{$0.name == "Weekly TODO"} ?? ListEntity()
        let weeklyDEFAULTlist = defaultListEntities.first{$0.name == "Weekly DEFAULT"} ?? ListEntity()
        
        //delete non-default items in weekly TODO
        for task in taskEntities
        {
            if weeklyTODOlist.id == task.listId
            {
                container.viewContext.delete(task)
            }
        }
        
        let weeklyDates: [Date] = getCalendarListWeekDate()
            
        //mark default items as incomplete and update date for tasks in weekly default
        for task in taskEntities
        {
            if weeklyDEFAULTlist.id == task.listId
            {
                task.isComplete = false
                //reset counterview's value
                task.currentReps = 0
                //resetting date
                task.date = weeklyDates[1]
                
            }
        }
        
        //delete current weekly list
        container.viewContext.delete(weeklyTODOlist)
        
        //adding new weekly list
        addList(name:"Weekly TODO", startDate: weeklyDates[0], endDate: weeklyDates[1], style: "calendar", isComplete: false)
        
        saveCalendarListData()
        saveTaskData()
    }
    
    func resetCalendarListMonth()
    {
        //if tasks were completed, dont adjust points
        
        fetchTasks()
        //save current month list data somewhere
        
        var monthlyTODOlist: ListEntity = ListEntity()
        
        //getting current month TODO list
        for tasklist in calendarListEntities
        {
            let str = tasklist.name ?? ""
            
            if !str.contains("Weekly") && !str.contains("Daily")
            {
                monthlyTODOlist = tasklist
            }
        }
        
        let monthlyDEFAULTlist = defaultListEntities.first{$0.name == "Monthly DEFAULT"} ?? ListEntity()
        
        //delete non-default items in monthly TODO
        for task in taskEntities
        {
            if monthlyTODOlist.id == task.listId
            {
                container.viewContext.delete(task)
            }
        }
        
        let monthlyDates: [Date] = getCalendarListMonthDate()
        
        //mark default items as incomplete for monthly default
        for task in taskEntities
        {
            if monthlyDEFAULTlist.id == task.listId
            {
                task.isComplete = false
                //reset counterview's value
                task.currentReps = 0
                //resetting date
                task.date = monthlyDates[1]
                
            }
        }
        
        //delete current monthly list
        container.viewContext.delete(monthlyTODOlist)
        
        
        //add new monthly list
        let month: String = monthlyDates[0].formatted(Date.FormatStyle().month(.wide))
        addList(name:"\(month) TODO" , startDate: monthlyDates[0], endDate: monthlyDates[1], style: "calendar", isComplete: false)
        
        saveCalendarListData()
        saveTaskData()
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
    
    
    func fetchMasterLists() {
        let request = NSFetchRequest<ListEntity>(entityName: "ListEntity")
        
        do {
            masterListEntities = try container.viewContext.fetch(request)
        } catch let error {
            print("Error fetching lists. \(error)")
        }
    }
    
    func fetchCalendarCells() {
        let request = NSFetchRequest<CalendarEntity>(entityName: "CalendarEntity")
        
        do {
            calendarCellEntities = try container.viewContext.fetch(request)
        } catch let error {
            print("Error fetching calendar cells. \(error)")
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
    
    func fetchCustomLists() {
        fetchMasterLists()
        
        /*
         maybe change this to
         customListEntities = masterListEntities.filter({$0.style != "calendar" && $0.style != "default"})
         
         */
        var temp: [ListEntity]
        temp = masterListEntities.filter({!($0.name?.contains("TODO") ?? false)})
        customListEntities = temp.filter(
            {
                !($0.name?.contains("Daily") ?? false) &&
            !($0.name?.contains("Weekly") ?? false) &&
            !($0.name?.contains("January") ?? false) &&
            !($0.name?.contains("February") ?? false) &&
            !($0.name?.contains("March") ?? false) &&
            !($0.name?.contains("April") ?? false) &&
            !($0.name?.contains("May") ?? false) &&
            !($0.name?.contains("June") ?? false) &&
            !($0.name?.contains("July") ?? false) &&
            !($0.name?.contains("August") ?? false) &&
            !($0.name?.contains("September") ?? false) &&
            !($0.name?.contains("October") ?? false) &&
            !($0.name?.contains("November") ?? false) &&
            !($0.name?.contains("December") ?? false) &&
            !($0.name?.contains("DEFAULT") ?? false)
            })
    }
    
    func fetchCalendarLists() {
        
        fetchMasterLists()
        calendarListEntities = masterListEntities.filter({$0.style == "calendar"})
    }
    
    func fetchDefaultLists() {
        
        fetchMasterLists()
        defaultListEntities = masterListEntities.filter({$0.style == "default"})
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
    
    func fetchLogin() {
        let request = NSFetchRequest<LoginEntity>(entityName: "LoginEntity")
        
        do {
            logins = try container.viewContext.fetch(request)
        } catch let error {
            print("Error fetching login. \(error)")
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
    func addTask(name: String, duration: Int, date: Date, isComplete: Bool, info: String, listId: UUID, totalReps: Int, currentReps: Int)
    {
        let newTask = TaskEntity(context: container.viewContext)
        newTask.id = UUID()
        newTask.completedOrder = 1000000000 //placeholderdate
        newTask.name = name
        newTask.duration = Int32(duration)
        newTask.date = date
        newTask.isComplete = isComplete
        newTask.info = info
        newTask.listId = listId
        newTask.totalReps = Int32(totalReps)
        newTask.currentReps = Int32(currentReps)
        saveTaskData()
    }
    
    //sole purpose it to test pastdue list colors and functionality
    func addtestlist () -> ListEntity
    {
        let newList = ListEntity(context: container.viewContext)
        newList.id = UUID()
        newList.name = "test"
        newList.isComplete = false
        // or no date
        newList.startDate = Date()
        newList.endDate = Date().addingTimeInterval(-86400)
        return newList
    }
    
    func addList(name: String, startDate: Date, endDate: Date, style: String, isComplete: Bool)
    {
        let newList = ListEntity(context: container.viewContext)
        newList.id = UUID()
        newList.name = name
        newList.isComplete = isComplete
        // or no date
        newList.startDate = startDate
        newList.endDate = endDate
        newList.style = style
        saveCustomListData()
    }
    
    func addReward(name: String, price: Int32, image: String, isPurchased: Bool, isUsed: Bool)
    {
        let newReward = RewardEntity(context: container.viewContext)
        newReward.id = UUID()
        newReward.redeemedDate = Date.now.addingTimeInterval(1576800000)
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
    
    func addCalendarCells(date: Date, isComplete: Bool)
    {
        let newCell = CalendarEntity(context: container.viewContext)
        newCell.date = date
        newCell.isComplete = isComplete
        saveCalendarCellData()
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
    
    func listNotComplete(tasklist: ListEntity)
    {
        tasklist.isComplete = false
        saveCustomListData()
    }
    
    func listNotCompleteCalendar(tasklist: ListEntity)
    {
        tasklist.isComplete = false
        saveCalendarListData()
    }
   
    
    func findCalendarListIndex(tasklist: ListEntity) -> Int
    {
        fetchCalendarLists()
        if tasklist.name == "Daily DEFAULT"
        {
            let dailyIndex: Int = calendarListEntities.firstIndex(where:{$0.name == "Daily TODO"}) ?? 5
            if dailyIndex != 5
            {
                return dailyIndex
            }
        }
        else if tasklist.name == "Weekly DEFAULT"
        {
            let weeklyIndex: Int = calendarListEntities.firstIndex(where:{$0.name == "Weekly TODO"}) ?? 5
            if weeklyIndex != 5
            {
                return weeklyIndex
            }
        }
        else if tasklist.name == "Monthly DEFAULT"//monthly default
        {
            let monthlyIndex: Int = calendarListEntities.firstIndex(where:{$0.name != "Weekly TODO" && $0.name != "Daily TODO"}) ?? 5
            if monthlyIndex != 5
            {
                return monthlyIndex
            }
            
        }
        else
        {
            print("This case should not happen ( tasklist != a default list)")
        }
        
        return 0
    }
    
    func isDefaultTask(task: TaskEntity) -> Bool
    {
        //this function broke the app for some reason
        //fetchDefaultLists()
        let idTask: UUID  = task.listId ?? UUID()
        let idL1: UUID = defaultListEntities[0].id ?? UUID()
        let idL2: UUID = defaultListEntities[1].id ?? UUID()
        let idL3: UUID = defaultListEntities[2].id ?? UUID()
        
        if idL1 == idTask || idL2 == idTask || idL3 == idTask
        {
            return true
        }
        else
        {
            return false
        }
        
        /*
        if defaultListEntities[0].id == task.listId || defaultListEntities[1].id == task.listId || defaultListEntities[2].id == task.listId
        {
            return true
        }
        return false
         */
    }
    
    func isDefaultTaskList(tasklist: ListEntity) -> Bool
    {
        //this function broke the app for some reason
        //fetchDefaultLists()
        let name: String  = tasklist.name ?? "t"
        let nameL1: String = defaultListEntities[0].name ?? "d"
        let nameL2: String = defaultListEntities[1].name ?? "d"
        let nameL3: String = defaultListEntities[2].name ?? "d"
        
        if nameL1 == name || nameL2 == name || nameL3 == name
        {
          return true
        }
        else
        {
            return false
        }
        
        
        /*
        if defaultListEntities[0].name == tasklist.name || defaultListEntities[1].name == tasklist.name || defaultListEntities[2].name == tasklist.name
        {
            return true
        }
        return false
         */
    }
    
    func listCompleteChecker(tasklist: ListEntity)
    {
        var count = 0
        var index: Int
        
        if tasklist.style == "calendar"
        {
            switch tasklist.name
            {
            case "Daily TODO": index = 0
            case "Weekly TODO": index = 1
            default: index = 2
            }
            
            for task in taskEntities
            {
                if task.listId == defaultListEntities[index].id
                {
                    count += 1
                    if !task.isComplete
                    {
                        print("task isn't complete")
                        tasklist.isComplete = false
                        saveCalendarListData()
                        return
                    }
                }
            }
        }
        
        
            for task in taskEntities
            {
                if task.listId == tasklist.id
                {
                    count += 1
                    if !task.isComplete
                    {
                        print("task isn't complete")
                        tasklist.isComplete = false
                        saveCustomListData()
                        return
                    }
                    
                }
            }
            if count > 0
            {
                //list is complete
                tasklist.isComplete = true
                
            }
            else
            {
                //no items in list
                tasklist.isComplete = false
            }
            saveCustomListData()
            saveCalendarListData()
    }
    
    func deleteTask(index: Int)
    {
        let entity = taskEntities[index]
        container.viewContext.delete(entity)
        saveTaskData()
    }
    func deleteCalendarCell(index: Int)
    {
        let entity = calendarCellEntities[index]
        container.viewContext.delete(entity)
        saveCalendarCellData()
    }
    
    func deleteDefaultTask(task: TaskEntity)
    {
        //i think upon a fetchdefaulttasks() call it will also remove from defaulttaskEntities because it pulls from taskEntities
        
        if let index = taskEntities.firstIndex(of: task)
        {
            taskEntities.remove(at: index)
            saveTaskData()
            print("removed task")
        }
        else
        {
            print("did not remove task")
        }
    }
    
    func deleteList(index: Int)
    {

        let entity = customListEntities[index]
        
        //deleting taskEntities
        for task in taskEntities
        {
            if task.listId == entity.id
            {
                if task.isComplete
                {
                    adjustPoints(task: task)
                }
                container.viewContext.delete(task)
            }
        }
        saveTaskData()
        
        //Deleting listEntity item
        container.viewContext.delete(entity)
        saveCustomListData()
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
    
    func setCurrentReps(entity: TaskEntity, reps: Int)
    {
        entity.currentReps = Int32(reps)
        saveTaskData()
    }
    
    func adjustPoints(task: TaskEntity)
    {
        //remove points for deleting a completed task
        let product: Int = Int(((task.duration * 400) / 60) + 100)
        let remove: Int = product * Int(task.totalReps) //needed for counterTasks/Views
        let pointsValue: Int = Int(pointEntities[0].value)
        let rewardPointsValue: Int = Int(pointEntities[1].value)
        
        if remove > pointsValue
        {
            // setting points to zero
            addPoints(entity: pointEntities[0], increment: (pointsValue * (-1)))
        }
        else
        {   // removing the amount of points the task was worth
            addPoints(entity: pointEntities[0], increment: (remove * (-1)))
        }
        
        if remove > rewardPointsValue
        {
            // setting points to zero
            addPoints(entity: pointEntities[1], increment: (rewardPointsValue * (-1)))
        }
        else
        {   // removing the amount of points the task was worth
            addPoints(entity: pointEntities[1], increment: (remove * (-1)))
        }
        
        //remove progress from goal
        for goal in goalEntities
        {
            if task.completedOrder > goal.createdOrder
                
            {
                subToCurrentValue(task: task, goal: goal, taskIncrement: Float(-1.0) , hourIncrement: Float((Float(task.duration)/60)*(-1)))
            }
        }
    }
    
    func setRedeemedDate(entity: RewardEntity)
    {
        entity.redeemedDate = Date()
        saveWalletRewardData()
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
    
    func getListName (entity: ListEntity) -> String
    {
        let listname = entity.name
        return listname ?? "no name"
    }
    
    func getTaskCount (list: ListEntity) -> Float
    {
        var count: Float = 0
        var index: Int
        
        if list.style == "calendar"
        {
            switch list.name
            {
            case "Daily TODO": index = 0
            case "Weekly TODO": index = 1
            default: index = 2
            }
            
            for task in taskEntities
            {
                if task.listId == defaultListEntities[index].id
                {
                    count += 1
                }
            }
        }
        
        for task in taskEntities
        {
            if task.listId == list.id
            {
                count += 1
            }
        }
        print("gettaskCount: \(count)")
        if count < 1
        {
            return 0
        }
        else
        {
            return count
        }
    }
    
    func getHourCount (list: ListEntity) -> Float
    {
        var hours: Float = 0
        var mins = 0
        
        var index: Int
        
        if list.style == "calendar"
        {
            switch list.name
            {
            case "Daily TODO": index = 0
            case "Weekly TODO": index = 1
            default: index = 2
            }
            
            for task in taskEntities
            {
                if task.listId == defaultListEntities[index].id
                {
                    mins += Int(task.duration)
                }
            }
        }
        
        for task in taskEntities
        {
            if task.listId == list.id
            {
                mins += Int(task.duration)
            }
        }
        
        hours = Float(mins)/60
        print("gethourCount: \(hours)")
        if mins < 1
        {
            return 0
        }
        else
        {
            return hours
        }
    }
    
    func getCompletedHourCount (list: ListEntity) -> Float
    {
        var hours: Float = 0
        var mins = 0

        var index: Int
        
        if list.style == "calendar"
        {
            switch list.name
            {
            case "Daily TODO": index = 0
            case "Weekly TODO": index = 1
            default: index = 2
            }
            
            for task in taskEntities
            {
                if task.listId == defaultListEntities[index].id
                {
                    if task.isComplete
                    {
                        mins += Int(task.duration)
                    }
                }
            }
        }
    
        for task in taskEntities
        {
            if task.listId == list.id
            {
                if task.isComplete
                {
                    mins += Int(task.duration)
                }
            }
        }
        
        hours = Float(mins)/60
        print("getCompletedHourCount: \(hours)")
        if mins < 1
        {
            return 0
        }
        else
        {
            return hours
        }
    }
    
    func getCompletedTaskCount (list: ListEntity) -> Float
    {
        var completeCount: Float = 0
        
        var index: Int
        
        if list.style == "calendar"
        {
            switch list.name
            {
            case "Daily TODO": index = 0
            case "Weekly TODO": index = 1
            default: index = 2
            }
            
            for task in taskEntities
            {
                if task.listId == defaultListEntities[index].id
                {
                    if task.isComplete
                    {
                        completeCount += 1
                    }
                }
            }
        }
    
        for task in taskEntities
        {
            if task.listId == list.id
            {
                if task.isComplete
                {
                    completeCount += 1
                }
                
            }
        }
        print("getCompletedTaskCount: \(completeCount)")
        
        if completeCount < 1
        {
            return 0
        }
        else
        {
            return completeCount
        }
    }
    
    func getHoursValue(list: ListEntity) -> Float
    {
        if getHourCount(list: list) == 0
        {
            return 0
        }
        let result: Float = getCompletedHourCount(list: list) / getHourCount(list: list)
        print("result: \(result)")
        return result
    }
    
    func getTasksValue(list: ListEntity) -> Float
    {
        if getTaskCount(list: list) == 0
        {
            return 0
        }
        let result: Float = getCompletedTaskCount(list: list) / getTaskCount(list: list)
        print("result: \(result)")
        return result
    }
    
    func getTaskList (tasklist: ListEntity) -> [TaskEntity]
    {
        var arr: [TaskEntity] = []
        for task in taskEntities
        {
            if tasklist.id == task.listId
            {
                arr.append(task)
            }
        }
        return arr
    }
    
    func getCombinedTaskList(tasklist: ListEntity) -> [TaskEntity]
    {
        var defaultTaskList: [TaskEntity] = getTaskList(tasklist: getDefaultTaskList(tasklist: tasklist))
        let calendarTaskList: [TaskEntity] = getTaskList(tasklist: tasklist)
        defaultTaskList.append(contentsOf: calendarTaskList)
        
        return defaultTaskList
    }
    
    func getDefaultTaskList (tasklist: ListEntity) -> ListEntity
    {
        var index: Int
        switch tasklist.name
        {
        case "Daily TODO": index = 0
        case "Weekly TODO":index = 1
        case "Monthly TODO": index = 2
        default: index = 2 //not an ideal default value
        }
        
        return defaultListEntities[index]
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
    
    func sortTaskCH(choice: Int, taskArr: [TaskEntity]) -> [TaskEntity]
    {
        var arr: [TaskEntity] = []
        var arrT: [TaskEntity] = []
        var arrF: [TaskEntity] = []
        switch (choice)
        {
        case 1:  print("sort by date")
            arr = taskArr.sorted { $0.date ?? Date() < $1.date ?? Date ()}
            return arr
        case 2: print("sort by duration")
            arr = taskArr.sorted { $0.duration < $1.duration}
            return arr
        case 3: print("sort by completed ")
            for task in taskArr{
                if task.isComplete{
                    arrT.append(task)
                }
                else
                {
                    arrF.append(task)
                }
            }
            arr = arrF + arrT
            return arr
        default:
            print("did not work")
            return taskArr
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
    
    //used for custom lists
    func sortList(choice: Int, gaugeDisplaysHours: Bool)
    {
        var arr: [ListEntity] = []
        var arrT: [ListEntity] = []
        var arrF: [ListEntity] = []
        switch (choice)
        {
        case 1:  print("sort by date")
            arr = self.customListEntities.sorted { $0.endDate ?? Date() < $1.endDate ?? Date ()}
            self.customListEntities = arr
                            
        case 2: print("sort by progress")
            
            //display buy hours
            if gaugeDisplaysHours
            {
                arr = self.customListEntities.sorted {  getHoursValue(list: $0) < getHoursValue(list: $1) }
            }
            //display by tasks
            else
            {
                arr = self.customListEntities.sorted {  getTasksValue(list: $0) < getTasksValue(list: $1) }
            }
            
            self.customListEntities = arr
        case 3: print("sort by completed ")
            for tasklist in customListEntities{
                if tasklist.isComplete{
                    arrT.append(tasklist)
                }
                else
                {
                    arrF.append(tasklist)
                }
            }
            arr = arrF + arrT
            self.customListEntities = arr
        default: print("did not work")
        }
        
        print(customListEntities)
        //saveTaskData()
    }
    
    //used for calender lists
    
    func sortList2(choice: Int, gaugeDisplaysHours: Bool)
    {
        var arr: [ListEntity] = []
        var arrT: [ListEntity] = []
        var arrF: [ListEntity] = []
        switch (choice)
        {
        case 1:  print("sort by date")
            arr = self.calendarListEntities.sorted { $0.endDate ?? Date() < $1.endDate ?? Date ()}
            self.calendarListEntities = arr
                            
            //need to update
        case 2: print("sort by progress")
            
            //display buy hours
            if gaugeDisplaysHours
            {
                arr = self.calendarListEntities.sorted {  getHoursValue(list: $0) < getHoursValue(list: $1) }
            }
            //display by tasks
            else
            {
                arr = self.calendarListEntities.sorted {  getTasksValue(list: $0) < getTasksValue(list: $1) }
            }
            
            self.calendarListEntities = arr
            
        case 3: print("sort by completed ")
            for tasklist in calendarListEntities{
                if tasklist.isComplete{
                    arrT.append(tasklist)
                }
                else
                {
                    arrF.append(tasklist)
                }
            }
            arr = arrF + arrT
            self.calendarListEntities = arr
        default: print("did not work")
        }
        
        print(calendarListEntities)
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
    
    func saveCustomListData(){
        do{
            try container.viewContext.save()
            fetchCustomLists()
        } catch let error{
                print("Error saving lists. \(error)")
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
    
    func saveMasterListData(){
        do{
            try container.viewContext.save()
            fetchMasterLists()
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
    
    func saveCalendarListData(){
        do{
            try container.viewContext.save()
            fetchCalendarLists()
        } catch let error{
                print("Error saving calendar lists. \(error)")
            }
        }
    
    func saveDefaultListData(){
        do{
            try container.viewContext.save()
            fetchDefaultLists()
        } catch let error{
                print("Error saving default lists. \(error)")
            }
        }
    
    func saveCalendarCellData(){
        do{
            try container.viewContext.save()
            fetchCalendarCells()
        } catch let error{
                print("Error saving default calendar cells. \(error)")
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
    
    func saveLoginData(){
        do{
            try container.viewContext.save()
            fetchLogin()
        } catch let error{
                print("Error saving login. \(error)")
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
    
    func restoreDefaultRewards()
    {
        //delete current instance of reward arrays
        masterRewardEntities.forEach { reward in
            if !walletRewardEntities.contains(reward)
            {
                container.viewContext.delete(reward)
            }
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
        
        saveMasterRewardData()
        
        //add default rewards back
        setRewardData()
        saveLevelRewardData()
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
        customListEntities.forEach { tasklist in
            container.viewContext.delete(tasklist)
        }
        masterListEntities.forEach { tasklist in
            container.viewContext.delete(tasklist)
        }
        calendarCellEntities.forEach { cell in
            container.viewContext.delete(cell)
        }
        
        //just for testing
        defaultListEntities.forEach { tasklist in
            container.viewContext.delete(tasklist)
        }
        
        pointEntities[0].value = 0
        pointEntities[1].value = 0
        
        saveCustomListData()
        saveTaskData()
        saveMasterListData()
        saveMasterRewardData()
        saveWalletRewardData()
        saveGoalData()
        savePointData()
        saveCalendarCellData()
        
        
        //add default rewards back
        setRewardData()
        saveLevelRewardData()
        
        //add default lists back
        setDefaultListData()
        saveDefaultListData()
        
        //add weekly & daily todo lists back
        setCalendarListData()
        saveCalendarListData()
        saveMasterListData()
    }

}


    
