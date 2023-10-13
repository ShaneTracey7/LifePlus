//
//  TaskListView.swift
//  Demo2
//
//  Created by Coding on 2023-09-12.
//

import SwiftUI

struct TaskListView: View {
    
    @ObservedObject var vm: CoreDataViewModel
    //@State var doubleCheck: Bool = false
    @State var sortSelection: Int = 0
    @State var showPopUp: Bool = false
    @State var namePopUp: String = ""
    @State var infoPopUp: String = ""
    
    @Binding var tasklist: ListEntity
    
    var body: some View {
        
        ZStack{
        
        NavigationStack{
            
            Picker(selection: $sortSelection, label: Text("Sort").foregroundColor(Color.primary))
            {
                Text("Date").tag(1)
                Text("Duration").tag(2)
                Text("Complete").tag(3)
            }.pickerStyle(.segmented).frame(width: 300)
                .padding([.bottom], 5)
                .onChange(of: sortSelection) { newValue in
                    vm.sortTask(choice: newValue)
                            }
            
            ScrollView{
                if vm.getTaskList(tasklist: tasklist).isEmpty
                {
                    Text("There are no tasks").frame(maxWidth: .infinity).foregroundColor(Color.blue)
                }
                else
                {
                    ForEach(vm.getTaskList(tasklist: tasklist)) { task in
                        
                        TaskView(vm: vm, sortSelection: $sortSelection, showPopUp: $showPopUp, namePopUp: $namePopUp, infoPopUp: $infoPopUp, task: task)
                    }
                }
            }
            .navigationTitle(vm.getListName(entity: tasklist))
            .toolbar {
                
                NavigationLink(destination: AddTaskView(vm: self.vm, sortSelection: $sortSelection, tasklist: $tasklist)){
                    Image(systemName: "plus")
                }
                
            }
            }
            
            PopUpWindowTask(title: namePopUp, message: infoPopUp, buttonText: "Ok", show: $showPopUp)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .environment(\.colorScheme, vm.modeEntities[0].isDark ? .dark : .light)
        //.background(Color.white)
        }
    }


struct TaskListView_Previews: PreviewProvider {
    
    struct TaskListViewContainer: View {
        
        @State var vm = CoreDataViewModel()
        @State var tasklist = ListEntity()
            var body: some View {
                TaskListView(vm: vm, tasklist: $tasklist)
            }
        }
    
    static var previews: some View {
        TaskListViewContainer()
        
    }
}


