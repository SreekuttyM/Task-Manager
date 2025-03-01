//
//  TaskListItem.swift
//  TaskManagerApp
//
//  Created by Sreekutty Maya on 27/02/2025.
//

import SwiftUI

struct TaskListItem: View {
    @EnvironmentObject var theme: ThemeManager
     var taskModel: TaskModel
    var body: some View {
        VStack(alignment: .leading) {
            Text(taskModel.taskTitle)
                .primaryTextHeading(theme: theme)
                .accessible(.text(label: taskModel.taskTitle))
            Text(taskModel.taskDescription)
                .secondaryTextHeading(theme: theme)
                .padding(.bottom, 10)
                .accessible(.text(label: taskModel.taskDescription))
            HStack {
                Text(self.dayDifference(from: taskModel.taskCreationDate)).secondaryTextHeading(theme: theme)
                    .accessible(.text(label: "Date"))
                Spacer()
                PriorityView
            }

        }

    }

    private var PriorityView: some View {
        HStack {
            Text(taskModel.getTaskPriorityString())
                .font(theme.selectedTheme.secondaryTextTitleFont)
                .accessible(.text(label: taskModel.getTaskPriorityString()))
            Image(systemName: "flag.fill")
                .foregroundStyle(self.getPriorityColor(priority: taskModel.taskPriority))
                .accessible(.image)
        }
    }

    private func dayDifference(from date: Date) -> String {
            let calendar = Calendar.current
            if calendar.isDateInYesterday(date) { return "Yesterday" } else if calendar.isDateInToday(date) { return "Today" } else if calendar.isDateInTomorrow(date) { return "Tomorrow" } else {
            let formatter = DateFormatter()
            formatter.dateStyle = .short
            formatter.timeStyle = .none
            formatter.doesRelativeDateFormatting = true
            return formatter.string(from: date)
        }
    }
    private  func getPriorityColor(priority: TaskPriority) -> Color {
        switch priority {
            case .High:
                return Color.red
            case .Low:
                return Color.yellow
            case .Medium:
                return Color.orange
        }
    }
}

// #Preview {
//     TaskListItem(taskModel: (.constant(TaskModel(taskId: UUID(), taskCreationDate: Date.now.addingTimeInterval(1740860831), taskDescription: "Start with the progress view logic and aim to finish it by tomorrow", taskPriority: .Low, taskTitle: "Refactor Checkout Module", taskProgress: 10, isCompleted: false))).environmentObject(ThemeManager())
// }
