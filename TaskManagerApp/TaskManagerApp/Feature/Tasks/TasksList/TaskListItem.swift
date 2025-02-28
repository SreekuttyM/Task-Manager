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
        ZStack {
            VStack(alignment: .leading) {
                Text(taskModel.taskTitle)
                    .font(theme.selectedTheme.textTitleFont)
                    .foregroundStyle(theme.selectedTheme.accentColor)
                Text(taskModel.taskDescription)
                    .font(theme.selectedTheme.secondaryTextTitleFont)
                    .foregroundStyle(theme.selectedTheme.accentColor)
                    .padding(.bottom, 10)
                HStack {
                    Text(self.dayDifference(from: taskModel.taskCreationDate)).font(theme.selectedTheme.subTextFont)
                        .foregroundStyle(theme.selectedTheme.secondoryThemeColor)
                        .font(theme.selectedTheme.subTextFont)
                    Spacer()
                    Text(taskModel.getTaskPriorityString())
                        .font(theme.selectedTheme.secondaryTextTitleFont)
                       Image(systemName: "flag.fill")
                        .foregroundStyle(self.getPriorityColor(priority: taskModel.taskPriority))

                }
            }.padding(.all, 10)
        } .frame(height: 120)    .clipShape(RoundedRectangle(cornerRadius: 10))
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.white)
                    .shadow(radius: 1)
            )
            .padding(.all)
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

 #Preview {
     TaskListItem(taskModel: (TaskModel(taskId: UUID(), taskCreationDate: Date.now.addingTimeInterval(1740860831), taskDescription: "Start with the progress view logic and aim to finish it by tomorrow", taskPriority: .Low, taskTitle: "Refactor Checkout Module", isCompleted: false))).environmentObject(ThemeManager())
 }
