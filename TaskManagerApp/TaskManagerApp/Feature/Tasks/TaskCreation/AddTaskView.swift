//
//  AddTaskView.swift
//  TaskManagerApp
//
//  Created by Sreekutty Maya on 27/02/2025.
//

import SwiftUI

struct AddTaskView: View {
    @State  var isSubmitted: Bool = false
    @StateObject private var viewModel: AddTaskViewModel
    @ObservedObject var router: NavigationRouter

    var onSave: ((TaskModel) -> Void)?

    init( action: ViewAction, task: TaskModel? = nil, onSave: ((TaskModel) -> Void)? = nil, router: NavigationRouter) {
        _viewModel = StateObject(wrappedValue: AddTaskViewModel(action: action, taskModel: task))
        if let onSave = onSave {
            self.onSave = onSave
        }
        _router =  ObservedObject(wrappedValue: router)
    }

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
                FormViewActionButton(action: {
                    if !viewModel.disableForm {
                        viewModel.saveTask()
                    }
                    router.goBack()

                }, title: "Submit")

                if !self.viewModel.isCompleted {
                    FormViewActionButton(action: {
                        if !viewModel.disableForm {
                            viewModel.markTaskToComplete()
                        }
                        router.goBack()

                    }, title: "Complete")
                }
                FormViewActionButton(action: {
                    if !viewModel.disableForm {
                        viewModel.deleteTaskModel()
                    }
                    router.goBack()
                }, title: "Delete")

            }
            .disabled(viewModel.disableForm)

        }
        .navigationTitle(viewModel.title)
        .navigationBarTitleDisplayMode(.inline)

    }
}

 #Preview {
     AddTaskView(action: .AddTask, router: NavigationRouter())
 }
