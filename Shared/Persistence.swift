import CoreData
import Combine
import CloudKit

public class Persistence {
    static let shared = Persistence()
    
    let container: NSPersistentCloudKitContainer
    
    @Published private(set) var cloudEvent : NSPersistentCloudKitContainer.Event? = nil
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        container = NSPersistentCloudKitContainer(name: "CrossAppWithCoreDataByCloudKitAppModel")
        container.viewContext.automaticallyMergesChangesFromParent = true
        container.viewContext.mergePolicy = NSMergeByPropertyStoreTrumpMergePolicy
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                //TODO: handle the error
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        setCloudKitEventChangedNotification()
    }
    
    private func setCloudKitEventChangedNotification() {
        NotificationCenter.default.publisher(for: NSPersistentCloudKitContainer.eventChangedNotification)
            .sink(receiveValue: { notification in
                if let cloudEvent = notification.userInfo?[NSPersistentCloudKitContainer.eventNotificationUserInfoKey]
                    as? NSPersistentCloudKitContainer.Event {
                    DispatchQueue.main.async {
                        self.cloudEvent = cloudEvent
                    }
                }
            })
            .store(in: &cancellables)
    }
}
