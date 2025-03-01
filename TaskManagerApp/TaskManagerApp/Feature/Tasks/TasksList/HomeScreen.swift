//
//  HomeScreen.swift
//  TaskManagerApp
//
//  Created by Sreekutty Maya on 28/02/2025.
//

import SwiftUI

struct HomeScreen: View {
    @EnvironmentObject var theme: ThemeManager
    @StateObject var viewModel: TaskListViewModel
    @StateObject private var router = NavigationRouter()
    @ObservedObject var coreDataManager: CoreDataManager

    init(coreDataManager: CoreDataManager) {
        _viewModel = StateObject(wrappedValue: TaskListViewModel(taskManager: TaskManager(coreDataManager: coreDataManager)))
        self.coreDataManager = coreDataManager
    }

    var body: some View {
        NavigationStack(path: $router.path) {
            VStack {
                switch viewModel.viewState {
                    case .isLoading:
                        ShimmerEffectView()
                    case .failed:
                        ErrorView
                    case .finish(let tasks):
                        if tasks.isEmpty {
                            EmptyView()
                        } else {
                            TaskListView(viewModel: viewModel, router: router)
                        }
                }
            }.accessibilityIdentifier("homeScreen")
            .onAppear {
                viewModel.fetchTasks()
            }
           
            .modifier(
                NavigationDestinationModifier(router: router, coreDataManager: coreDataManager)
            )
            .safeAreaInset(edge: .bottom, alignment: .trailing) {
                PlusButton.padding(.all, 20)
            }
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        CustomToolBarMenu(isPresented: $viewModel.isPresented) { searchOption in
                            viewModel.selectedSearchOption = searchOption
                        }.accessible(.toolBarMenu)
                    }
                    ToolbarItem(placement: .principal) {
                        Text(TStrings.NTTaskList)
                            .headerTextHeading(theme: theme)
                            .padding(.top, 10)
                        }
                }
        }.sheet(isPresented: $viewModel.isPresented) {
            SearchOptionsMenu(isSearchOptionEnabled: $viewModel.isSearchOptionEnabled, title: viewModel.selectedSearchOption.rawValue, searchOption: viewModel.selectedSearchOption).presentationDetents([.height(300), .medium, .large])
                .presentationDragIndicator(.automatic)
        }
    }

    private var PlusButton: some View {
        Button {
            viewModel.isAnimated = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                router.navigate(to: .addTask(action: .AddTask))
                viewModel.isAnimated = false
            }
        } label: {
            PulseEffectCircle(isOn: $viewModel.isAnimated)
        }
        .accessible(.pulseButton)
    }

    private var ErrorView: some View {
        VStack {
            Text("Something Went Wrong")
                .foregroundColor(.red)
                .accessible(.text(label: "Something Went Wrong"))
            Button("Retry") {
                viewModel.fetchTasks()
            }
            .accessible(.button())
        }
    }
}

#Preview {
    HomeScreen(coreDataManager: CoreDataManager()).environmentObject(ThemeManager())
}
