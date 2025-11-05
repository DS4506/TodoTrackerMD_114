
import SwiftUI

struct ContentRootView: View {
    @Environment(\.horizontalSizeClass) private var hSize
    @State private var groups: [TaskGroup] = sampleTaskGroups
    @State private var selection: SideBarSelection? = .group(sampleTaskGroups.first?.id ?? UUID())

    var body: some View {
        Group {
            if hSize == .compact {
                AppCompactStack(groups: $groups)
            } else {
                NavigationSplitView {
                    AppSidebarView(groups: $groups, selection: $selection)
                } detail: {
                    AppDetailView(groups: $groups, selection: $selection)
                }
                .navigationSplitViewColumnWidth(min: 250, ideal: 300, max: 380)
            }
        }
        .onAppear {
            if selection == nil, let first = groups.first {
                selection = .group(first.id)
            }
        }
    }
}
