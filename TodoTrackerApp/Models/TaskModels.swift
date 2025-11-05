
import Foundation

struct TaskItem: Identifiable, Hashable {
    let id = UUID()
    var title: String
    var isCompleted: Bool = false
}

struct TaskGroup: Identifiable, Hashable {
    let id = UUID()
    var title: String
    var symbolName: String
    var tasks: [TaskItem]
}

let sampleTaskGroups: [TaskGroup] = [
    TaskGroup(
        title: "Personal",
        symbolName: "person",
        tasks: [
            TaskItem(title: "Read 20 pages"),
            TaskItem(title: "Gym session"),
            TaskItem(title: "Meditation", isCompleted: true)
        ]
    ),
    TaskGroup(
        title: "Work",
        symbolName: "laptopcomputer",
        tasks: [
            TaskItem(title: "Prepare deck"),
            TaskItem(title: "1:1 with manager", isCompleted: true),
            TaskItem(title: "Inbox zero")
        ]
    ),
    TaskGroup(
        title: "Shopping",
        symbolName: "cart",
        tasks: [
            TaskItem(title: "Apples"),
            TaskItem(title: "Eggs", isCompleted: true),
            TaskItem(title: "Dish soap")
        ]
    )
]
