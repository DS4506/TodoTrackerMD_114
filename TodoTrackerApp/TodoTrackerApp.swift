
import SwiftUI

@main
struct TodoTrackerApp: App {
    @AppStorage("IsDerkMode") private var IsdarkMode: Bool = false
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .preferredColorScheme(IsdarkMode ? .dark : .light)
        }
    }
}
