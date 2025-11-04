

import SwiftUI

struct TaskItem: Identifiable {
    let id = UUID()
    var title: String
    var isCompleted: Bool
}

struct PlaceHolderView: View {
    let title: String
    let icon: String
    
    @State private var tasks = [
        TaskItem(title: "Upload Assigment to Canvas", isCompleted: false),
        TaskItem(title: "Implement Login View", isCompleted: false),
        TaskItem(title: "Go groceries shopping", isCompleted: true)
    ]
    
    var body: some View {
        NavigationStack {
            VStack {
                Image(systemName: icon)
                    .font(.system(size: 50))
                    .foregroundStyle(.blue)
                    .padding(.top, 20)
                    .padding(.bottom, 10)
                
                // Task - Checkmark - Task title
                List($tasks) { $task in
                    HStack(spacing: 15) {
                        Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
                            .font(.title3)
                            .foregroundStyle(task.isCompleted ? .green : .secondary)
                            .onTapGesture {
                                withAnimation {
                                    task.isCompleted.toggle()
                                }
                            }
                        TextField("New Task", text: $task.title)
                            .strikethrough(task.isCompleted, color: .secondary)
                            .foregroundStyle(task.isCompleted ? .secondary : .primary)
                    }
                    .padding(.vertical, 4)
                }
                .navigationTitle(title)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing ) {
                        Button {
                            withAnimation {
                                tasks.append(TaskItem(title: "New task", isCompleted: false))
                            }
                        } label: {
                            Image(systemName: "plus")
                        }
                    }
                }
            }
        }
    }
}
