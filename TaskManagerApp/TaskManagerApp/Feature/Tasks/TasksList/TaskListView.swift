//
//  TaskListView.swift
//  TaskManagerApp
//
//  Created by Sreekutty Maya on 25/02/2025.
//

import SwiftUI

enum NavigationDestination {
    case AddTask(viewModel: AddTaskViewModel)
}

struct TaskListView: View {
    @EnvironmentObject var theme: ThemeManager
    @StateObject var viewModel: TaskListViewModel =  TaskListViewModel()
    @ObservedObject  var router: NavigationRouter

    var body: some View {
        NavigationStack(path: $router.path) {
            taskItemList
                .task {
                    await viewModel.fetchTasks()
                }
                .navigationDestination(for: NavigationRoute.self) { route in
                    switch route {
                        case .addTask(let action):
                            AddTaskView(action: action, router: router)
                        case .editAtsk(let action, let taskModel):
                            AddTaskView(action: action, task: taskModel, router: router)
                    }
                }.navigationTitle(TStrings.NTTaskList)
                .navigationBarTitleTextColor(theme.selectedTheme.secondoryThemeColor)
                .navigationBarTitleDisplayMode(.inline)

                .self.safeAreaInset(edge: .bottom, alignment: .trailing) {
                    plusButton
                }.padding(.all, 20)
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
                }.sheet(isPresented: $viewModel.isPresented) {
                    SearchOptionsMenu(title: viewModel.selectedSearchOption.rawValue, searchOption: viewModel.selectedSearchOption, isSearchOptionEnabled: $viewModel.isSearchOptionEnabled).presentationDetents([.height(350), .medium, .large])
                        .presentationDragIndicator(.automatic)
                }

        }

    }

    private var plusButton: some View {
            Button {
                viewModel.isAnimated = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    router.navigate(to: .addTask(action: .AddTask))
                    viewModel.isAnimated = false
                }
            } label: {
                PulseEffectCircle(isOn: $viewModel.isAnimated)
            }
    }

    private var taskItemList: some View {
        ScrollView {
            LazyVStack(alignment: .leading) {
                if viewModel.array_tasks.count > 0 {
                    ForEach(viewModel.array_tasks, id: \.self) { task in
                        TaskListItem(taskModel: task)
                            .onTapGesture {
                                router.navigate(to: .editAtsk(action: .EditTask, taskModel: task))
                            }
                    }
                } else {
                    TaskListShimmerView()
                }
            }
        }
    }
}

#Preview {
    TaskListView(router: NavigationRouter()).environmentObject(ThemeManager())
}
