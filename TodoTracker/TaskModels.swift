
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

enum SideBarSelection : Hashable {
    case group(TaskGroup.ID)
    case profile
}
