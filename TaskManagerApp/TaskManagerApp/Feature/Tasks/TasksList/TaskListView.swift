//
//  TaskListView.swift
//  TaskManagerApp
//
//  Created by Sreekutty Maya on 25/02/2025.
//

import SwiftUI

struct TaskListView: View {
    @EnvironmentObject var theme: ThemeManager
    @State private var path = NavigationPath()
    @StateObject var viewModel: TaskListViewModel =  TaskListViewModel()

    var body: some View {
        NavigationStack(path: $path) {
            taskItemList
            .task {
                await viewModel.fetchTasks()
            }
            .navigationTitle(TStrings.NTTaskList)
            .navigationBarTitleTextColor(theme.selectedTheme.secondoryThemeColor)
            .navigationBarTitleDisplayMode(.inline)
            .navigationDestination(for: String.self) { route in
                switch route {
                    case "CreateTask":
                        AddTaskView( viewModel: AddTaskViewModel(action: .AddTask))
                    default:
                        AddTaskView( viewModel: AddTaskViewModel(action: .AddTask))
                }
            }
            .self.safeAreaInset(edge: .bottom, alignment: .trailing) {
                plusButton
            }.padding(.all, 30)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Menu(content: {
                        Button("Sorting", action: {
                            viewModel.selectedSearchOption = .Sort
                            viewModel.isPresented = true
                        })
                        Button("Filter", action: {
                            viewModel.selectedSearchOption = .Filter
                            viewModel.isPresented = true
                        })
                    }) {
                        Image(systemName: "line.3.horizontal.decrease.circle.fill")
                            .font(.system(size: 21))
                    }
                }
            }
            .sheet(isPresented: $viewModel.isPresented) {
                    SearchOptionsMenu(title: viewModel.selectedSearchOption.rawValue, searchOption: viewModel.selectedSearchOption).presentationDetents([.height(350), .medium, .large])
                        .presentationDragIndicator(.automatic)
                }

        }

    }

    private var plusButton: some View {
            Button {
                viewModel.isAnimated = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    path.append("CreateTask")
                    viewModel.isAnimated = false
                }
            } label: {
                PulseEffectCircle(isOn: $viewModel.isAnimated)
            }
    }

    private var taskItemList: some View {
        ScrollView {
            LazyVStack(alignment: .leading) {
                ForEach($viewModel.array_tasks, id: \.self) { task in
                    TaskListItem(taskModel: task)
                }
            }
        }
    }

}

#Preview {
    TaskListView().environmentObject(ThemeManager())
}
