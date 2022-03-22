import Foundation
import CoreData
import Combine

class ContentViewModel: ObservableObject {
    @Published var items: [TimeData] = []
    
    private let viewContext = Persistence.shared.container.viewContext
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        fetchAllTimeItem()
        Persistence.shared.$cloudEvent
            .sink { newValue in
                print("Persistence cloudEvent property changed")
                self.fetchAllTimeItem()
            }
            .store(in: &cancellables)
    }
    
    private func fetchAllTimeItem() {
        do {
            let timeDataRequest: NSFetchRequest<TimeData> = TimeData.fetchRequest()
            items = try viewContext.fetch(timeDataRequest)
        }
        catch {
            NSLog("Handle Error!") //TODO: Handle Error!!
        }
    }
    
    func addItem() {
            let newItem = TimeData(context: viewContext)
            newItem.creationTime = Date()
            
            do {
                try viewContext.save()
                fetchAllTimeItem()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
    }
    
    func deleteItems(offsets: IndexSet) {
            offsets.map { items[$0] }.forEach(viewContext.delete)
            
            do {
                try viewContext.save()
                fetchAllTimeItem()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
    }
}
