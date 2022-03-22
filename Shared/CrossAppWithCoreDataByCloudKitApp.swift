import SwiftUI

@main
struct CrossAppWithCoreDataByCloudKitApp: App {
    let viewContext = Persistence.shared.container.viewContext

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, viewContext)
        }
    }
}
