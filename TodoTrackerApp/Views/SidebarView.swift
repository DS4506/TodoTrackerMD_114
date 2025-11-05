
import SwiftUI

struct AppSidebarView: View {
    @Binding var groups: [TaskGroup]
    @Binding var selection: SideBarSelection?

    var body: some View {
        List(selection: $selection) {
            Section("Lists") {
                ForEach(groups) { group in
                    NavigationLink(value: SideBarSelection.group(group.id)) {
                        Label(group.title, systemImage: group.symbolName)
                    }
                }
            }
            Section("Account") {
                NavigationLink(value: SideBarSelection.profile) {
                    Label("Profile", systemImage: "person.crop.circle")
                }
            }
        }
        .navigationTitle("TodoTracker")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
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
