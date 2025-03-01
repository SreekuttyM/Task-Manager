//
//  AddTaskView.swift
//  TaskManagerApp
//
//  Created by Sreekutty Maya on 27/02/2025.
//

import SwiftUI

struct AddTaskView: View {
    @EnvironmentObject var theme: ThemeManager
    @StateObject private var viewModel: AddTaskViewModel
    @ObservedObject var router: NavigationRouter

    @State private var animate = false
    @State  var isSubmitted: Bool = false
    @State var deleteAlert: Bool = false
    @State var completeAlert: Bool = false
//    @State var saveAlert: Bool = false

    init(router: NavigationRouter, action: ViewAction, taskManager: TaskManager, taskModel: TaskModel?) {
        _viewModel = StateObject(wrappedValue: AddTaskViewModel(action: action, taskModel: taskModel, taskManager: taskManager))
        _router = ObservedObject(wrappedValue: router)
    }

    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            Form {
                Section {
                    TextField("Title", text: $viewModel.name)
                        .accessible(.textField(label: "Title"))
                    TextField("Description", text: $viewModel.description)
                        .accessible(.textField(label: "Description"))

                    Picker("Priority", selection: $viewModel.selectedPriority) {
                        ForEach(TaskPriority.allCases, id: \.self) {
                            Text("\($0)")
                                .accessible(.text(label: "Priority"))

                        }
                    }
                    DatePicker(selection: $viewModel.taskCreatedDate, in: Date.now..., displayedComponents: .date) {
                        Text("Select a date")
                            .accessible(.text(label: "Select a date"))

                    }

                }

                Section {
                    VStack(alignment: .center) {
                        CircularProgressView(color: theme.selectedTheme.accentColor, progress: viewModel.taskProgress)
                            .frame(width: 100, height: 100).padding()
                        if !viewModel.isCompleted {
                            sliderView
                        }
                    }.frame(maxWidth: .infinity)
                        .disabled(viewModel.disableForm)

                    if viewModel.showFormButtons() {
                        HStack(alignment: .center) {
                            Spacer()
                            if !viewModel.isCompleted {
                                CompleteButton
                            }
                            DeleteButton
                            Spacer()
                        }
                    }
                }
            }
        }
        .scaleEffect(animate ? 1.0 : 0.9)
        .opacity(animate ? 1 : 0)
        .onAppear {
            withAnimation(.spring()) {
                animate = true
                           }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                if !viewModel.isCompleted {
                    SaveButton
                }
            }
            ToolbarItem(placement: .principal) {
                    Text(viewModel.title)
                        .headerTextHeading(theme: theme)
                        .padding(.top, 10)
                
            }
        }
        .alert("Are you sure you want to mark it as complete? This will set the progress to 100%", isPresented: $completeAlert, actions: {
            Button("No") {
            }.accessible(.button())
            Button("Yes") {
                viewModel.taskProgress = 1.0
                viewModel.markTaskToComplete()
                router.goBack()
            }.accessible(.button(label: "CompleteAlert"))

        })
        .alert("Are you sure you want to delete the task?", isPresented: $deleteAlert, actions: {
            Button("No") {
            }.accessible(.button())
            Button("Yes") {
                viewModel.deleteTaskModel()
                router.goBack()
            }.accessible(.button(label: "DeleteAlert"))
        })

    }

    private var SaveButton: some View {
        FormViewActionButton(action: {
            if !viewModel.disableForm {
                viewModel.update()
                router.goBack()
            }

        }, title: "Save")
    }

    private var CompleteButton: some View {
        FormViewActionButton(action: {
            if !viewModel.disableForm {
                completeAlert = true
            }
        }, title: "Complete")

    }

    private var sliderView: some View {
            VStack {
                SliderView(progress: $viewModel.taskProgress, title: "Select Progress")
            }
    }

    private var DeleteButton: some View {
        FormViewActionButton(action: {
            if !viewModel.disableForm {
                deleteAlert = true
            }
        }, title: "Delete")
    }
}

 #Preview {
     AddTaskView(router: NavigationRouter(), action: .AddTask, taskManager: TaskManager(coreDataManager: CoreDataManager()), taskModel: nil)
 }
