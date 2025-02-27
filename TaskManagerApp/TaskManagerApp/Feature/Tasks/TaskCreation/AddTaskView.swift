//
//  AddTaskView.swift
//  TaskManagerApp
//
//  Created by Sreekutty Maya on 27/02/2025.
//

import SwiftUI

struct AddTaskView: View {

    @StateObject var viewModel: AddTaskViewModel = AddTaskViewModel(action: .AddTask)

    @State private var isSubmitted: Bool = false

    var body: some View {

        Form {
            TextField("Title", text: $viewModel.name)
            TextField("Description", text: $viewModel.description)

            Picker("Priority", selection: $viewModel.selectedPriority) {
                ForEach(TaskPriority.allCases, id: \.self) {
                    Text("\($0)")
                }
            }
            DatePicker(selection: $viewModel.taskCreatedDate, in: Date.now..., displayedComponents: .date) {
                Text("Select a date")
            }
            Section {
                Button("Save", action: {
                    if !viewModel.disableForm {
                        viewModel.saveTask()
                    }
                })
                .alert(isPresented: $isSubmitted) {
                    Alert(
                        title: Text("Saved"),
                        message: Text("Task is created"),
                        dismissButton: .default(Text("OK"))
                    )
                }
            }
            .disabled(viewModel.disableForm)

        }
        .navigationTitle(viewModel.title)
        .navigationBarTitleDisplayMode(.inline)

    }
}

 #Preview {
    AddTaskView()
 }
