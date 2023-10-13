//
//  SettingsView.swift
//  Demo2
//
//  Created by Coding on 2023-09-29.
//

import SwiftUI




struct SettingsView: View {
    
@ObservedObject var vm: CoreDataViewModel
    @State var doubleCheckErase: Bool = false
    @State var doubleCheckRestore: Bool = false
    
    var body: some View {
        
        NavigationView{
        
            VStack{
                
                Text("Settings").font(.title).foregroundColor(Color.primary)
                
                List{
                    
                    Toggle("Dark Mode",isOn: $vm.modeEntities[0].isDark ).toggleStyle(.switch)
                    
                    
                    // 'Restore Default Rewards' button
                    Button(role: .destructive,
                           action: {
                        withAnimation{
                            print("'restore default rewards' button was pressed")
                            doubleCheckRestore = true
                        }
                    },
                           label: {
                        Text("Restore Default Rewards").foregroundColor(Color.green)
                    })
                    .buttonStyle(.plain)
                    .confirmationDialog(
                    "Are you sure? This will remove all custom rewards added",
                    isPresented: $doubleCheckRestore,
                    titleVisibility: .visible
                    )
                    {
                        Button("Yes", role: .destructive)
                        {
                            vm.restoreDefaultRewards()
                            print("confirmation 'restore default rewards' button was pressed")
                        }
                        Button("No", role: .cancel){}
            
                    }
                    
                    // 'Erase all Data' button
                    Button(role: .destructive,
                           action: {
                        withAnimation{
                            print("'erase all data' button was pressed")
                            doubleCheckErase = true
                        }
                    },
                           label: {
                        Text("Erase All Data").foregroundColor(Color.red)
                    })
                    .buttonStyle(.plain)
                    .confirmationDialog(
                    "Are you sure? This will remove all tasks, rewards and points",
                    isPresented: $doubleCheckErase,
                    titleVisibility: .visible
                    )
                    {
                        Button("Yes", role: .destructive)
                        {
                            vm.resetCoreData()
                            print("confirmation 'erase all data' button was pressed")
                        }
                        Button("No", role: .cancel){}
            
                    }
                    
                    
                    
                }
                
                //save button (necessary for mode to save to core data)
                Button {
                    print("'Save Changes' button was pressed")
                    vm.saveModeData()
                } label: {
                    Text("Save Changes").foregroundColor(Color.white)
                }
                .frame(width: 150, height: 40)
                .background(Color.green)
                .cornerRadius(15)
                .buttonStyle(PressableButtonStyle())
            }
                
        }.frame(maxWidth: .infinity, maxHeight: .infinity).background(Color.primary).environment(\.colorScheme, vm.modeEntities[0].isDark ? .dark : .light)
    }
}

struct SettingsView_Previews: PreviewProvider {
    struct SettingsViewContainer: View {
        @State var vm = CoreDataViewModel()
            var body: some View {
                SettingsView(vm: self.vm )
            }
        }
    
    static var previews: some View {
        SettingsViewContainer()
    }
}

