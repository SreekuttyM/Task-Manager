# Task-Manager - iOS Task Management App

## Description
    TaskMaster is a simple iOS application designed to help users manage their tasks effectively. This application supports functionalities like add task with progress, delete and complete tasks.

https://github.com/user-attachments/assets/70bc2e01-9737-4e0b-b55c-06c94288f81d

## Table of Contents
- Installation
- Usage
- Configuration
- Design Rationale

## Installation

### Prerequisites
Before setting up the project, ensure you have the following installed:
- xcode - 16
- ios version - 16.6
- supported for iphone applications 

### Steps
1. Clone the repository:
    https://github.com/SreekuttyM/Task-Manager.git


2. Open the project in Xcode:
    open TaskManagerApp.xcodeproj

4. Run the app:
    - Choose a target simulator or connect a physical device.
    - Press the Run button (`Cmd + R`) in Xcode to build and run the app.


## Usage

### Running the App
Once the app is installed and set up.
Key features include:
- **Onboarding**: This is the first screen shown when user opens the app.
- **Tabbed View**: Once user click on the button in onboarding screen, it opens a tabbed view with Home and settings Tab.
- **Task List(Home)**: View all tasks in a list view.
    - Key features: 
         - swipe functionalities include delete and mark as complete
         - sort and filter options available
         - sort with Priority, Due date, or Alphabetically
         - filter with All, Completed, Pending
- **Add Tasks**: Tap the "+" button to add a new task with a title, description, due date, and priority and task progress.
- **Task Details**: Tap on a task will open same detail screen, including the option to edit or mark it as complete.
- **Settings**: user can change the theme color of the application.

### Example Usage
1. Open the app and click on the onboading get started button.
2. Open the app and click the "+" button to create a task.
3. Enter the task title, description and if needed task progress too with slider which shows circular animation.
3. Tap "Save" to add the task to your list.
4. Use the filters to sort tasks by due date, priority,alphabetic order or completion status.

## Configuration

The app can be configured via the following settings (if applicable):
- **Theme**: The theme can be changed from settings,it is saved locally.
- **Database**: The app uses Core Data for local storage. If you need to reset the app's data, delete the app from your device and reinstall it.

## Design Rationale

### Architecture Choices
- **Model-View-ViewModel (MVVM)**: The app follows the MVVM pattern for separation of concerns. The Model represents the task data, the View handles UI components, and the ViewModel acts as the mediator between the two. This ensures better scalability and easier testing.
  
- **Core Data**: CoreData is used for local storage.CoreDataManager handles the coredata functionality ensuring seperation of concerns.
    Task Manager handles the operations and communicates with viewModel to render the data in UI. 
    Sample TaskModel -> in Domain Layer
        - TaskModel(taskId: UUID(), taskCreationDate: Date.now, taskDescription: "Refactoring", taskPriority: .Low, taskTitle: "C Task 1", taskProgress: 1, isCompleted: true)
        - Entity is defined with following properties:
            isComplete
            taskCreationDate
            taskDescription
            taskId
            taskPriority
            taskProgress
            taskTitle

- **SwiftUI for UI**: UI is done on swiftUI.

