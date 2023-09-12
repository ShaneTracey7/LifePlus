//
//  TaskView.swift
//  Demo2
//
//  Created by Coding on 2023-09-12.
//

import SwiftUI

struct TaskView: View {
    let task: Task
    var body: some View {
        VStack(alignment: .leading){
            Text(task.name)
            Text("\(task.duration)")
        }
    }
}

struct TaskView_Previews: PreviewProvider {
    static var task = Task.sampleData[0]
    static var previews: some View {
        TaskView(task:task)
            .previewLayout(.fixed(width: 400, height: 60))
            .background(Color(red: 0.94, green: 0.71, blue: 0.12))
    }
}
