
import SwiftUI

struct AppCompactStack: View {
    @Binding var groups: [TaskGroup]

    var body: some View {
        NavigationStack {
            List {
                Section("Lists") {
                    ForEach(groups) { group in
                        NavigationLink {
                            GroupDetailWrapper(groups: $groups, groupID: group.id)
                        } label: {
                            Label(group.title, systemImage: group.symbolName)
                        }
                    }
                }
                Section("Account") {
                    NavigationLink { ProfileView() } label: {
                        Label("Profile", systemImage: "person.crop.circle")
                    }
                }
            }
            .navigationTitle("TodoTracker")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        withAnimation {
                            groups.append(TaskGroup(title: "New List",
                                                    symbolName: "list.bullet",
                                                    tasks: []))
                        }
                    } label: { Image(systemName: "plus") }
                }
            }
        }
    }
}

private struct GroupDetailWrapper: View {
    @Binding var groups: [TaskGroup]
    let groupID: TaskGroup.ID

    private var index: Int? { groups.firstIndex { $0.id == groupID } }

    var body: some View {
        if let idx = index {
            TaskGroupDetailView(group: $groups[idx])
        } else {
            PlaceHolderView(title: "List not found", message: "Choose another list.")
        }
    }
}
