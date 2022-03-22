import CoreData

struct Persistence {
    static let shared = Persistence()
    
    let container: NSPersistentCloudKitContainer
    
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
    }
}
