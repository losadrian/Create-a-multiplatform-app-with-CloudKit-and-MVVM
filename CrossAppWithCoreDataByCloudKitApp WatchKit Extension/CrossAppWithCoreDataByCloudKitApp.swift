import SwiftUI

@main
struct CrossAppWithCoreDataByCloudKitApp: App {
    let viewContext = Persistence.shared.container.viewContext
    
    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
                    .environment(\.managedObjectContext, viewContext)
            }
        }

        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}
