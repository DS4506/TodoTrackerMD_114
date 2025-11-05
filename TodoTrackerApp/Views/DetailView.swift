
import SwiftUI

struct AppDetailView: View {
    @Binding var groups: [TaskGroup]
    @Binding var selection: SideBarSelection?

    private func bindingForGroup(id: TaskGroup.ID) -> Binding<TaskGroup>? {
        guard let idx = groups.firstIndex(where: { $0.id == id }) else { return nil }
        return $groups[idx]
    }

    var body: some View {
        Group {
            switch selection {
            case .group(let id):
                if let groupBinding = bindingForGroup(id: id) {
                    TaskGroupDetailView(group: groupBinding)
                } else {
                    PlaceHolderView(title: "List not found",
                                    message: "Choose another list in the sidebar.")
                }
            case .profile:
                ProfileView()
            case .none:
                PlaceHolderView(title: "No list selected",
                                message: "Choose a list from the sidebar to get started.")
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.systemGroupedBackground))
    }
}
