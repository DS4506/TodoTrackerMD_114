
import SwiftUI

struct TaskGroupDetailView: View {
    @Binding var group: TaskGroup
    @State private var newTitle: String = ""

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            header

            List {
                ForEach($group.tasks) { $task in
                    HStack {
                        Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
                            .foregroundStyle(task.isCompleted ? .green : .secondary)
                            .onTapGesture { task.isCompleted.toggle() }

                        TextField("Task title", text: $task.title)
                            .textFieldStyle(.plain)
                    }
                }
                .onDelete { indexSet in
                    group.tasks.remove(atOffsets: indexSet)
                }

                HStack {
                    TextField("New task", text: $newTitle)
                        .textFieldStyle(.roundedBorder)
                    Button {
                        let t = newTitle.trimmingCharacters(in: .whitespacesAndNewlines)
                        guard !t.isEmpty else { return }
                        withAnimation {
                            group.tasks.append(TaskItem(title: t))
                            newTitle = ""
                        }
                    } label: {
                        Image(systemName: "plus.circle.fill").imageScale(.large)
                    }
                    .buttonStyle(.plain)
                    .accessibilityLabel("Add task")
                }
            }
            .listStyle(.insetGrouped)
        }
        .padding()
        .navigationTitle(group.title)
        .toolbar {
            ToolbarItemGroup(placement: .primaryAction) {
                Button {
                    withAnimation {
                        group.tasks = group.tasks.map { TaskItem(title: $0.title, isCompleted: true) }
                    }
                } label: { Label("Complete All", systemImage: "checkmark.seal") }

                Button {
                    withAnimation {
                        group.tasks.removeAll { $0.isCompleted }
                    }
                } label: { Label("Clear Completed", systemImage: "trash") }
            }
        }
    }

    private var header: some View {
        HStack(spacing: 12) {
            Image(systemName: group.symbolName)
                .font(.system(size: 28, weight: .semibold))
                .foregroundColor(.accentColor)   // <- fixed

            VStack(alignment: .leading, spacing: 2) {
                Text(group.title).font(.title2).bold()
                let remaining = group.tasks.filter { !$0.isCompleted }.count
                Text("\(remaining) remaining")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            Spacer()
        }
    }
}
