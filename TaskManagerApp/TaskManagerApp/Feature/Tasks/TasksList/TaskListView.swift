//
//  TaskListView.swift
//  TaskManagerApp
//
//  Created by Sreekutty Maya on 25/02/2025.
//

import SwiftUI

struct TaskListView: View {
    @ObservedObject var viewModel: TaskListViewModel
    @ObservedObject  var router: NavigationRouter
    @State var deleteAlert: Bool = false
    @State var completeAlert: Bool = false
    @State  var selectedTask: TaskModel?

    var body: some View {
        List {
            ForEach(viewModel.array_tasks, id: \.self) { task in

                TaskListItem(taskModel: task)
                    .accessibilityIdentifier("listItem_\(task.taskId)")
                    .swipeActions {
                        Button(role: .destructive) {
                            selectedTask = task
                            deleteAlert = true
                        } label: {
                            Label("Delete", systemImage: "trash")
                        }
                        .accessible(.button())
                        Button {
                            selectedTask = task
                            completeAlert = true
                        } label: {
                            Label("Mark As Complete", systemImage: "checkmark")
                        }
                        .accessible(.button())

                    }
                    .onTapGesture {
                        router.navigate(to: .editTask(action: .EditTask, viewModel: task))
                    }
            } .onMove(perform: moveItem)

        }.accessibilityIdentifier("taskList")

            .listStyle(.insetGrouped)
            .alert("Are you sure you want to delete the task?", isPresented: $deleteAlert, actions: {
                        Button("Cancel", role: .cancel) { }
                       .accessible(.button())
                        Button("Delete", role: .destructive) {
                            if let task = selectedTask {
                                deleteTask(task: task)
                            }
                        }.accessible(.button())
                    })
            .alert("Are you sure you want to mark it as complete?", isPresented: $completeAlert, actions: {
                        Button("Cancel", role: .cancel) { }
                       .accessible(.button())
                        Button("Mark As Complete", role: .destructive) {
                            if let task = selectedTask {
                                markComplete(task: task)
                            }
                        }.accessible(.button())
                    })

    }

    func moveItem(from source: IndexSet, to destination: Int) {
        viewModel.array_tasks.move(fromOffsets: source, toOffset: destination)
        triggerHaptic(style: .light)
       }

    func deleteTask(task: TaskModel) {
        viewModel.deleteTaskModel(selectedTask: task)
    }

    func markComplete(task: TaskModel) {
        viewModel.markTaskToComplete(selectedTask: task)
    }

    func triggerHaptic(style: UIImpactFeedbackGenerator.FeedbackStyle) {
           let generator = UIImpactFeedbackGenerator(style: style)
           generator.prepare()
           generator.impactOccurred()
       }
}

#Preview {
    TaskListView(viewModel: TaskListViewModel(), router: NavigationRouter()).environmentObject(ThemeManager())
}
